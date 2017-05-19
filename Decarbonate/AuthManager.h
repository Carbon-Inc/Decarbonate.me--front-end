//
//  AuthManager.h
//  Decarbonate
//
//  Created by Adrian Kenepah-Martin on 5/16/17.
//  Copyright © 2017 Austin Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"

@interface AuthManager : NSObject

+ (instancetype)shared;
- (void)fetchUserEventsWithCompletion:(void(^)(NSArray* dataObjects))completion;

- (void)calculateCarbonFootprintForEvent:(Event *)event
                          transportation:(NSString *)transportation
                            withDistance:(NSNumber *)distance
                              completion:(void(^)(NSDictionary* dataObject))completion;

@property(strong, nonatomic) NSArray *jsonArray;

@end
