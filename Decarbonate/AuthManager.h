//
//  AuthManager.h
//  Decarbonate
//
//  Created by Adrian Kenepah-Martin on 5/15/17.
//  Copyright © 2017 Austin Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthManager : NSObject

+ (void)processOAuthStep1Response: (NSURL *)url;

@end