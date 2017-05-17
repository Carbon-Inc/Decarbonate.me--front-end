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

@interface LoginViewController () <SFSafariViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *loginWithEventbriteButton;

@end

@implementation LoginViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"kToken"] != nil) {
        [self removeFromParentViewController];
        [self.view removeFromSuperview];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)safariViewControllerDidFinish:(SFSafariViewController *)controller {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)getEventbriteToken {
    NSString  *authPath = @"https://www.eventbrite.com/oauth/authorize?response_type=token&client_id=BYIVXD4JETVK43D22T";
    NSURL *authURL = [NSURL URLWithString:authPath];
    
    //    SFSafariViewController *authVC = [[SFSafariViewController alloc]initWithURL:authURL];
    //    authVC.delegate = self;
    //    [self presentViewController:authVC animated:YES completion:nil];
    
    //    [[UIApplication sharedApplication] openURL:authURL options:@{} completionHandler:nil];
    
    AuthViewController *authController = [[AuthViewController alloc]init];
    authController.url = authURL;
    [self presentViewController:authController animated:YES completion:nil];
    
}

- (IBAction)loginButtonPressed:(UIButton *)sender {
    //    [ebClient getAuthorizationCode:^(NSString *code) {
    //        // Run your code here
    //
    //    } cancel:^{
    //        // Session is closed
    //        NSLog(@"Error");
    //
    //    } failure:^(NSError *error) {
    //        // Session is closed
    //        NSLog(@"Error");
    //    }];
    
    //UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"Event" bundle:nil];
    
    //UIViewController *eventViewController = [secondStoryBoard instantiateInitialViewController];
    
    //[self.navigationController pushViewController:eventViewController animated:YES];
    
    [self getEventbriteToken];
}

@end
