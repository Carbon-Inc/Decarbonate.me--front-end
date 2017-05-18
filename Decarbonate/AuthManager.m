//
//  AuthManager.m
//  Decarbonate
//
//  Created by Adrian Kenepah-Martin on 5/16/17.
//  Copyright © 2017 Austin Rogers. All rights reserved.
//

#import "AuthManager.h"
#import "Credentials.h"
//#import <AFOAuth2Manager/AFOAuth2Manager.h>

@implementation AuthManager

+ (id)shared{
    static AuthManager *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

-(instancetype)init {
    self = [super init];
    
    if (self) {
        
    }
    return self;
}

- (void)fetchDataWithCompletion:(void(^)(NSArray* dataObjects))completion {
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    NSString *urlString = [NSString stringWithFormat:@"https://decarbonate-me-staging.herokuapp.com/decarbonate/events"];
    
    NSURL *urlForAPI = [[NSURL alloc]initWithString:urlString];

    
    [[session dataTaskWithURL:urlForAPI completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error receiving response: %@", error.localizedDescription);
        }
        
        if (data) {
            NSError *jsonError;
            NSArray *dataObjects = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(dataObjects);
            });
        }
    }]resume];
}

//- (void)postToken {
//    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"kToken"];
//    NSURL *url = [NSURL URLWithString:@"https://www.eventbrite.com/oauth/authorize?response_type=code&client_id=5GTVCH7ISZNXR5CSK7"];
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
//    
//    [request setHTTPMethod:@"POST"];
//    [request setValue:token forHTTPHeaderField:<#(nonnull NSString *)#>]
//}

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
