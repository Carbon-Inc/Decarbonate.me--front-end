//
//  LocationManager.m
//  Decarbonate
//
//  Created by Kent Rogers on 5/17/17.
//  Copyright © 2017 Austin Rogers. All rights reserved.
//

#import "LocationManager.h"
//#import "LocationControllerDelegate.h"

@import UserNotifications;

@implementation LocationManager

+ (id)shared{
    static LocationManager *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (id)init {
    self = [super init];
    
    _locationManager.delegate = self;
    
    return self;
}

- (void)requestPermissions {
    
    self.locationManager = [[CLLocationManager alloc]init];
    
    [self.locationManager requestAlwaysAuthorization];
    
}

@end
