//
//  AppDelegate.m
//  Decarbonate
//
//  Created by Kent Rogers on 5/15/17.
//  Copyright © 2017 Austin Rogers. All rights reserved.
//

#import "AppDelegate.h"
#import "AuthManager.h"
#import "AppAppearance.h"
#import "EventViewController.h"
#import "LoginViewController.h"
#import "LocationManager.h"

@interface AppDelegate ()

@property(strong, nonatomic) LoginViewController *loginVC;
@property(strong, nonatomic) EventViewController *eventsVC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:[AppAppearance defaultColor]];
    [[UINavigationBar appearance] setTranslucent:NO];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

    [[LocationManager shared] requestPermissions];
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
