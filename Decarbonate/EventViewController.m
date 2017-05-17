//
//  EventViewController.m
//  Decarbonate
//
//  Created by Kent Rogers on 5/16/17.
//  Copyright © 2017 Austin Rogers. All rights reserved.
//

#import "EventViewController.h"
#import "EventTableViewCell.h"

@interface EventViewController () <UITableViewDataSource>

//@property(strong, nonatomic)NSArray *allEvents;

@property(weak, nonatomic) IBOutlet UITableView *tableView;

@property(strong, nonatomic)NSArray *allEvents;

@end

@implementation EventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"EventTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    
    self.tableView.estimatedRowHeight = 200;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self parseJSON];
}

-(void)parseJSON{
    
    
    
    NSString* path  = [[NSBundle mainBundle] pathForResource:@"example" ofType:@"json"];
    
    NSString* jsonString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *jsonError;
    NSArray *allKeys = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
    //NSLog(@"%@", allKeys);
    
    self.allEvents = allKeys;
    [self.tableView reloadData];
    //NSMutableDictionary *allEvents = [[NSMutableDictionary alloc]init];
    
    for (int i=0; i<[allKeys count]; i++) {
        NSDictionary *arrayResult = [allKeys objectAtIndex:i];
        //NSLog(@"name=%@",[arrayResult objectForKey:@"eventId"]);
        
        
        
    }
    
    //return allEvents;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"cell";
    EventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier forIndexPath:indexPath];
    NSDictionary *event = self.allEvents[indexPath.row];
    
    cell.eventName.text = [event objectForKey:@"name"];
    cell.eventTime.text = [event objectForKey:@"start"];
    //NSString *startDate = [event objectForKey:@"start"];
    //NSString *otherDate = [event objectForKey:@"end"];
    //cell.eventTime.text = [@"%@ - %@", startDate, otherDate];
    
    cell.eventCategory.text = [event objectForKey:@"category"];
    cell.eventLocation.text = [event objectForKey:@"address"];
    
    NSString *imageString = [event objectForKey:@"img"];
    NSURL *imageURL = [NSURL URLWithString:imageString];
    NSData *imgData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *eventImage = [[UIImage alloc] initWithData:imgData];
    cell.eventImage.image = eventImage;
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.allEvents.count;
}

@end
