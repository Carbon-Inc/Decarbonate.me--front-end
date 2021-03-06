//
//  EventViewController.m
//  Decarbonate
//
//  Created by Kent Rogers on 5/16/17.
//  Copyright © 2017 Austin Rogers. All rights reserved.
//

#import "EventViewController.h"
#import "EventTableViewCell.h"
#import "LoginViewController.h"
#import "CarbonCalcViewController.h"
#import "Event.h"
#import "AuthManager.h"

@import CoreLocation;

@interface EventViewController () <UITableViewDataSource, UITableViewDelegate>

//@property(strong, nonatomic)NSArray *allEvents;

@property(weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property(strong, nonatomic)NSMutableArray *unpaidEvents;
@property(strong, nonatomic)NSMutableArray *paidEvents;
@property(strong, nonatomic)NSArray *currentDataSource;

@end

@implementation EventViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self presentAuthController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"EventTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.estimatedRowHeight = 200;
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    CLLocationManager* myLocationManager = [[CLLocationManager alloc] init];
    [myLocationManager requestAlwaysAuthorization];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

- (void)presentAuthController {
    LoginViewController *loginVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"loginVIewController"];

    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"kToken"] == nil) {
        [self presentViewController:loginVC animated:YES completion:nil];
    } else {
        if (self.unpaidEvents == nil) {
            [self.activityIndicator startAnimating];
        }
        self.unpaidEvents = [[NSMutableArray alloc]init];
        self.paidEvents = [[NSMutableArray alloc]init];
        
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString *documentsDirectory = [paths objectAtIndex:0];
//        NSString *appFile = [documentsDirectory stringByAppendingPathComponent:@"allEvents.txt"];
//        NSArray *events = [NSKeyedUnarchiver unarchiveObjectWithFile:appFile];
        
        for (Event *event in [AuthManager shared].allEvents) {
            if ([event.paid isEqual:@1]) {
                [self.paidEvents addObject:event];
            } else {
                [self.unpaidEvents addObject:event];
            }
        }
        [self paidEventSegment:nil];
    }
}

- (UIImage *)getImageFromURL:(NSString *)urlString {
    NSURL *imageURL = [NSURL URLWithString:urlString];
    NSData *imgData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *eventImage = [[UIImage alloc] initWithData:imgData];
    return eventImage;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    
    if ([segue.identifier isEqualToString:@"CarbonCalcViewController"]) {
        CarbonCalcViewController *carbonVC = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        carbonVC.selectedEvent = self.currentDataSource[indexPath.row];
    }
}
- (IBAction)logoutButtonPressed:(UIBarButtonItem *)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kToken"];
    [self presentAuthController];
}

- (IBAction)paidEventSegment:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.currentDataSource = self.unpaidEvents;
            [self.tableView reloadData];
            [self.activityIndicator stopAnimating];
            break;
        case 1:
            self.currentDataSource = self.paidEvents;
            [self.tableView reloadData];
            [self.activityIndicator stopAnimating];
            break;
        default:
            break;
    }
    
}

#pragma mark - UITableViewDelegate
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"cell";
    EventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier forIndexPath:indexPath];
    Event *currentEvent = self.currentDataSource[indexPath.row];

    cell.eventName.text = currentEvent.name;
    cell.eventTime.text = currentEvent.start;
    cell.eventCategory.text = currentEvent.category;
    cell.eventLocation.text = currentEvent.address;
    cell.eventImage.image = currentEvent.eventImage;
    
    if (currentEvent.paid == false) {
        cell.eventOffsetStatus.text = @"Paid";
    } else {
        cell.eventOffsetStatus.text = @"Unpaid";
    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.currentDataSource.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"CarbonCalcViewController" sender:nil];
}

@end
