//
//  LoginViewController.m
//  Decarbonate
//
//  Created by Kent Rogers on 5/15/17.
//  Copyright © 2017 Austin Rogers. All rights reserved.
//

#import "LoginViewController.h"
#import "AuthManager.h"
#import "Credentials.h"
#import "AuthViewController.h"
#import <SafariServices/SafariServices.h>
#import "LocationManager.h"
#import "LocationControllerDelegate.h"
#import "AppAppearance.h"

@interface LoginViewController () <SFSafariViewControllerDelegate, NSCoding>

@property (weak, nonatomic) IBOutlet UIButton *loginWithEventbriteButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation LoginViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"kToken"] != nil) {
        self.loginWithEventbriteButton.enabled = NO;
        self.loginWithEventbriteButton.alpha = 0.6;
        [self.activityIndicator startAnimating];
        [[AuthManager shared].allEvents removeAllObjects];
        [[AuthManager shared] fetchUserEventsWithCompletion:^(NSArray *dataObjects) {
            for (NSDictionary *eventObject in dataObjects) {
                Event *newEvent = [[Event alloc]initWithDictionary:eventObject];
                
                if (newEvent != nil) {
                    newEvent.eventImage = [self getImageFromURL:newEvent.img];
                    [[AuthManager shared].allEvents addObject:newEvent];
                }
            }
            [self saveArrayToDisk];
            [self.activityIndicator stopAnimating];
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }
}

- (void)saveArrayToDisk {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:@"allEvents.txt"];
    
    [NSKeyedArchiver archiveRootObject:[AuthManager shared].allEvents toFile:appFile];
}

- (UIImage *)getImageFromURL:(NSString *)urlString {
    NSURL *imageURL = [NSURL URLWithString:urlString];
    NSData *imgData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *eventImage = [[UIImage alloc] initWithData:imgData];
    return eventImage;
}

//-(instancetype)initWithCoder:(NSCoder *)aDecoder {
//    if (self = [super initWithCoder:aDecoder]) {
//        [AuthManager shared].allEvents = [aDecoder decodeObjectForKey:@"kAllEvents"];
//    }
//    
//    return self;
//}
//
//-(void)encodeWithCoder:(NSCoder *)aCoder {
//    [aCoder encodeObject: [AuthManager shared].allEvents forKey:@"kAllEvents"];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginWithEventbriteButton.layer.cornerRadius = self.loginWithEventbriteButton.bounds.size.height / 2;
    self.loginWithEventbriteButton.layer.masksToBounds = YES;
    self.loginWithEventbriteButton.backgroundColor = [AppAppearance defaultColor];
}

- (void)getEventbriteToken {
    NSString  *authPath = @"https://www.eventbrite.com/oauth/authorize?response_type=token&client_id=BYIVXD4JETVK43D22T";
    
    NSURL *authURL = [NSURL URLWithString:authPath];
    
    AuthViewController *authController = [[AuthViewController alloc]init];
    authController.url = authURL;
    [self presentViewController:authController animated:NO completion:nil];
    
}

- (IBAction)loginButtonPressed:(UIButton *)sender {
    [self getEventbriteToken];
}

@end
