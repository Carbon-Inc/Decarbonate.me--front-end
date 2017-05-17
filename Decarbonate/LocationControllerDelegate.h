//
//  LocationControllerDelegate.h
//  LocationReminders
//
//  Created by Kent Rogers on 5/2/17.
//  Copyright © 2017 Austin Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreLocation;

@protocol LocationControllerDelegate <NSObject>

- (void)locationControllerUpdatedLocation:(CLLocation *)location;

@end

