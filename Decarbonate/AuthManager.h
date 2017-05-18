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

+ (instancetype) shared;
- (void)fetchDataWithCompletion:(void(^)(NSArray* dataObjects))completion;
- (void)fetchUserEvents;
- (void)calculateCarbonFootprintForEvent:(Event *)event withDistance:(NSString *)distance;

@property(strong, nonatomic) NSArray *jsonArray;

@end
