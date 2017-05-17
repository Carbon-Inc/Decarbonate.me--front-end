//
//  LocationManager.m
//  Decarbonate
//
//  Created by Kent Rogers on 5/17/17.
//  Copyright © 2017 Austin Rogers. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationManager

+ (id)shared{
    static LocationManager *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

@end
