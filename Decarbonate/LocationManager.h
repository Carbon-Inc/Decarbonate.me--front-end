//
//  LocationManager.h
//  Decarbonate
//
//  Created by Kent Rogers on 5/17/17.
//  Copyright © 2017 Austin Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LocationControllerDelegate.h"

@import CoreLocation;

@interface LocationManager : NSObject

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;
@property (weak, nonatomic) id<LocationControllerDelegate> delegate;

+ (id)shared;

@end
