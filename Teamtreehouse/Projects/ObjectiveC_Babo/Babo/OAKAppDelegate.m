//
//  OAKAppDelegate.m
//  Babo
//
//  Created by Onur Akpolat on 25.11.13.
//  Copyright (c) 2013 Onur Akpolat. All rights reserved.
//

#import "OAKAppDelegate.h"
#import <Parse/Parse.h>

@implementation OAKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Extend Splash Screen Time
    [NSThread sleepForTimeInterval:1.5];
    
    [Parse setApplicationId:@""
                  clientKey:@""];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    // Style Navigation Controller
    [self customizeUserInferface];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Helper methods

- (void) customizeUserInferface {
    //Custmoize the navigation bar
    //[[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.204 green:0.596 blue:0.859 alpha:1]; /*#3498db*/
    
    // Set Image as Background
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navBarBackground"] forBarMetrics:UIBarMetricsDefault];
    
    // Set Title Attributes
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil]];
    
    // Set Buttons Attributes
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    //Customize Tab Bar
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
}

@end
