//
//  EventTableViewCell.h
//  Decarbonate
//
//  Created by Kent Rogers on 5/16/17.
//  Copyright © 2017 Austin Rogers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *eventImage;
@property (weak, nonatomic) IBOutlet UIImageView *eventImageFilter;
@property (weak, nonatomic) IBOutlet UILabel *eventCategory;
@property (weak, nonatomic) IBOutlet UILabel *eventName;
@property (weak, nonatomic) IBOutlet UILabel *eventTime;
@property (weak, nonatomic) IBOutlet UILabel *eventLocation;
@property (weak, nonatomic) IBOutlet UILabel *eventOffsetStatus;

@end
