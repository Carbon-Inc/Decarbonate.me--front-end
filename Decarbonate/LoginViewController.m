//
//  LoginViewController.m
//  Decarbonate
//
//  Created by Kent Rogers on 5/15/17.
//  Copyright © 2017 Austin Rogers. All rights reserved.
//

#import "LoginViewController.h"
#import "Credential.h"

@interface LoginViewController ()

@property(strong, nonatomic) NSString *oAuthBaseURLString;

@property(strong, nonatomic) NSString *clientID;
@property(strong, nonatomic) NSString *clientSecretID;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.oAuthBaseURLString = @"https://www.eventbrite.com/oauth/authorize";
    
    self.clientID = CLIENT_ID;
    self.clientSecretID = CLIENT_SECRET;
}

-(void)oAuthRequestWith {
    
}

- (IBAction)loginButtonPressed:(UIButton *)sender {
    
}

@end
