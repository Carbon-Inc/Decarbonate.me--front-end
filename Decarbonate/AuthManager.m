//
//  AuthManager.m
//  Decarbonate
//
//  Created by Adrian Kenepah-Martin on 5/16/17.
//  Copyright © 2017 Austin Rogers. All rights reserved.
//

#import "AuthManager.h"
#import "Credentials.h"
#import <AFOAuth2Manager/AFOAuth2Manager.h>

@implementation AuthManager

+ (void)processOAuthStep1Response: (NSURL *)url {
    NSLog(@"%@", url);
    NSURLComponents *components = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
    NSString *code;
    NSArray *queryItems = components.queryItems;
    for (NSURLQueryItem *queryItem in queryItems) {
        if ([queryItem.name.lowercaseString  isEqual: @"code"]) {
            code = queryItem.value;
        }
    }
    
    NSLog(@"%@", code);
}

@end
