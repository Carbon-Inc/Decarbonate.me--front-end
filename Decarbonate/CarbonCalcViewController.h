//
//  CarbonCalcViewController.h
//  Decarbonate
//
//  Created by Kent Rogers on 5/18/17.
//  Copyright © 2017 Austin Rogers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarbonCalcViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *transportTypeSegment;

@property (weak, nonatomic) IBOutlet UILabel *startPointLabel;
@property (weak, nonatomic) IBOutlet UILabel *endPointLabel;
@property (weak, nonatomic) IBOutlet UILabel *offsetCostLabel;

@property (weak, nonatomic) IBOutlet UIButton *calculateButton;
@property (weak, nonatomic) IBOutlet UIButton *payButton;

@end
