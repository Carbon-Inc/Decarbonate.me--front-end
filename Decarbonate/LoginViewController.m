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

@interface LoginViewController () <SFSafariViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *loginWithEventbriteButton;

@end

@implementation LoginViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"kToken"] != nil) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
