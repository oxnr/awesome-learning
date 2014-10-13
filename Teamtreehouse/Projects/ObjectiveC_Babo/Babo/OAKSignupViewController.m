//
//  OAKSignupViewController.m
//  Babo
//
//  Created by Onur Akpolat on 26.11.13.
//  Copyright (c) 2013 Onur Akpolat. All rights reserved.
//

#import "OAKSignupViewController.h"
#import <Parse/Parse.h>

@interface OAKSignupViewController ()

@end

@implementation OAKSignupViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Add padding to usernameField
    UIView *usernamePadding = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    self.usernameField.leftView = usernamePadding;
    self.usernameField.leftViewMode = UITextFieldViewModeAlways;
    
    // Add padding to emailField
    UIView *emailPadding = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    self.emailField.leftView = emailPadding;
    self.emailField.leftViewMode = UITextFieldViewModeAlways;
    
    // Add padding to passwordField
    UIView *passwordPadding = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    self.passwordField.leftView = passwordPadding;
    self.passwordField.leftViewMode = UITextFieldViewModeAlways;
}

- (IBAction)signup:(id)sender {
    NSString *username = [self.usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *email = [self.emailField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([username length] == 0 || [password length] == 0 || [email length] == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Make sure you enter a username, password and email address!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        
    }
    else {
        PFUser *newUser = [PFUser user];
        newUser.username = username;
        newUser.password = password;
        newUser.email = email;
        
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
            }
            else {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
        
        //more code
    }
}

- (IBAction)dismiss:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
