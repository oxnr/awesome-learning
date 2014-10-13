//
//  OAKSignupViewController.h
//  Babo
//
//  Created by Onur Akpolat on 26.11.13.
//  Copyright (c) 2013 Onur Akpolat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OAKSignupViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

- (IBAction)signup:(id)sender;
- (IBAction)dismiss:(id)sender;

@end
