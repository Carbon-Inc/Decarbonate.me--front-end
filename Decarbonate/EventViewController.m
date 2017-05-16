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

@property(strong, nonatomic)NSArray *allEvents;

@property(strong, nonatomic)UITableView *tableView;

@end

@implementation EventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"EventTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier forIndexPath:indexPath];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.allEvents.count;
}

@end
