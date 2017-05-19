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
        _allEvents = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)fetchUserEventsWithCompletion:(void(^)(NSArray* dataObjects))completion {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"kToken"];
    NSString *stringURL = [NSString stringWithFormat:@"https://decarbonate-me-staging.herokuapp.com/decarbonate/events"];
    
    NSDictionary *tokenDictionary = @{@"token": token};
    NSURL *url = [NSURL URLWithString:stringURL];
        
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    NSData *tokenData = [NSJSONSerialization dataWithJSONObject:tokenDictionary options:0 error:nil];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:tokenData];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) { 
            NSLog(@"Error Post: %@", error.localizedDescription);
        }
        
        NSLog(@"Response: %@", response);
        NSError *jsonError;
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
        NSLog(@"%@", jsonArray);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(jsonArray);
        });
    }];
    [dataTask resume];
}

- (void)calculateCarbonFootprintForEvent:(Event *)event transportation:(NSString *)transportation withDistance:(NSNumber *)distance completion:(void(^)(NSDictionary* dataObject))completion {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSString *eventDate = event.start;
    NSString *urlString = [NSString stringWithFormat:@"https://decarbonate-me-staging.herokuapp.com/decarbonate/footprint/%@/%@/%@", transportation, eventDate, distance];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"URLSTRING: %@", urlString);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    [request setHTTPMethod:@"GET"];

    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error Post: %@", error.localizedDescription);
        }
        
        NSLog(@"Response: %@", response);
        NSError *jsonError;
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(jsonDictionary);
        });
    }];
    [dataTask resume];
    
}

//- (void)updateEventPayState:(Event *)event {
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
//    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"kToken"];
//    NSString *stringURL = [NSString stringWithFormat:@"https://decarbonate-me-staging.herokuapp.com/decarbonate/events"];
//    
//    NSDictionary *tokenDictionary = @{@"token": token};
//    NSURL *url = [NSURL URLWithString:stringURL];
//    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
//    
//    [request setHTTPMethod:@"POST"];
//    NSData *tokenData = [NSJSONSerialization dataWithJSONObject:tokenDictionary options:0 error:nil];
//    
//    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [request setHTTPBody:tokenData];
//    
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        if (error) {
//            NSLog(@"Error Post: %@", error.localizedDescription);
//        }
//        
//        NSLog(@"Response: %@", response);
//        NSError *jsonError;
//        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
//        NSLog(@"%@", jsonArray);
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            completion(jsonArray);
//        });
//    }];
//    [dataTask resume];
//}

//+ (void)processOAuthStep1Response: (NSURL *)url {
//    NSLog(@"%@", url);
//    NSURLComponents *components = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
//    NSString *code;
//    NSArray *queryItems = components.queryItems;
//    for (NSURLQueryItem *queryItem in queryItems) {
//        if ([queryItem.name.lowercaseString  isEqual: @"code"]) {
//            code = queryItem.value;
//        }
//    }
//    
//    NSLog(@"%@", code);
//}

@end
