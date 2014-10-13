//
//  OAKLoginViewController.m
//  Babo
//
//  Created by Onur Akpolat on 26.11.13.
//  Copyright (c) 2013 Onur Akpolat. All rights reserved.
//

#import "OAKLoginViewController.h"
#import <Parse/Parse.h>

@interface OAKLoginViewController ()

@end

@implementation OAKLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Hide Navigation Bar
    [self.navigationController.navigationBar setHidden:YES];
    
    // Add padding to usernameField
    UIView *usernamePadding = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    self.usernameField.leftView = usernamePadding;
    self.usernameField.leftViewMode = UITextFieldViewModeAlways;
    
    // Add padding to passwordField
    UIView *passwordPadding = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    self.passwordField.leftView = passwordPadding;
    self.passwordField.leftViewMode = UITextFieldViewModeAlways;
    }

- (IBAction)login:(id)sender {
    NSString *username = [self.usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([username length] == 0 || [password length] == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Make sure you enter a username and password!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    else {
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
            if (error) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
            }
            else {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
    }
}


@end
