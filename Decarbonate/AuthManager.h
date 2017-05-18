//
//  AuthManager.h
//  Decarbonate
//
//  Created by Adrian Kenepah-Martin on 5/16/17.
//  Copyright © 2017 Austin Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthManager : NSObject

+ (instancetype) shared;
- (void)fetchDataWithCompletion:(void(^)(NSArray* dataObjects))completion;

@property(strong, nonatomic) NSArray *jsonArray;

@end
