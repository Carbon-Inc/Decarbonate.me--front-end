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
#import "Event.h"
#import "AuthManager.h"

@import CoreLocation;

@interface EventViewController () <UITableViewDataSource>

//@property(strong, nonatomic)NSArray *allEvents;

@property(weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property(strong, nonatomic)NSMutableArray *unpaidEvents;
@property(strong, nonatomic)NSMutableArray *paidEvents;
@property(strong, nonatomic)NSArray *currentDataSource;

@end

@implementation EventViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self presentAuthController];

}

- (void)presentAuthController {

    LoginViewController *loginVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"loginVIewController"];

    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"kToken"] == nil) {
        [self presentViewController:loginVC animated:YES completion:nil];
    } else {
        [self parseJSON];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.

    self.unpaidEvents = [[NSMutableArray alloc]init];
    self.paidEvents = [[NSMutableArray alloc]init];
    self.tableView.dataSource = self;

    [self.tableView registerNib:[UINib nibWithNibName:@"EventTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];


    self.tableView.estimatedRowHeight = 200;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    CLLocationManager* myLocationManager = [[CLLocationManager alloc] init];
    [myLocationManager requestAlwaysAuthorization];
}

//-(void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    CLLocationManager* myLocationManager = [[CLLocationManager alloc] init];
//    [myLocationManager requestAlwaysAuthorization];
//}

-(void)parseJSON{
    [self.activityIndicator startAnimating];
    [[AuthManager shared]fetchDataWithCompletion:^(NSArray *dataObjects) {
        for (NSDictionary *eventObject in dataObjects) {
            Event *newEvent = [[Event alloc] initWithDictionary:eventObject];

            if ([newEvent.paid isEqual:@1]) {
                [self.paidEvents addObject:newEvent];
            } else {
                [self.unpaidEvents addObject:newEvent];
            }
        }
        [self paidEventSegment:nil];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"cell";
    EventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier forIndexPath:indexPath];
    Event *currentEvent = self.currentDataSource[indexPath.row];

    cell.eventName.text = currentEvent.name;
    cell.eventTime.text = currentEvent.start;
    cell.eventCategory.text = currentEvent.category;
    cell.eventLocation.text = currentEvent.address;

    NSString *imageString = currentEvent.img;
    NSURL *imageURL = [NSURL URLWithString:imageString];
    NSData *imgData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *eventImage = [[UIImage alloc] initWithData:imgData];
    cell.eventImage.image = eventImage;

    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.currentDataSource.count;
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
            break;
        default:
            break;
    }

}

@end
