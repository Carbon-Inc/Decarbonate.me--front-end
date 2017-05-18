//
//  CarbonCalcViewController.h
//  Decarbonate
//
//  Created by Kent Rogers on 5/18/17.
//  Copyright © 2017 Austin Rogers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface CarbonCalcViewController : UIViewController

@property(strong, nonatomic) Event *selectedEvent;

@property (weak, nonatomic) IBOutlet UISegmentedControl *transportTypeSegment;


@property (weak, nonatomic) IBOutlet UITextField *startPointTextField;
@property (weak, nonatomic) IBOutlet UITextField *endPointTextField;
@property (weak, nonatomic) IBOutlet UILabel *offsetCostLabel;

@property (weak, nonatomic) IBOutlet UIButton *calculateButton;
@property (weak, nonatomic) IBOutlet UIButton *payButton;

@end
