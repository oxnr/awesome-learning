//
//  OAKImageViewController.h
//  Babo
//
//  Created by Onur Akpolat on 30.11.13.
//  Copyright (c) 2013 Onur Akpolat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface OAKImageViewController : UIViewController {
}

@property   (strong, nonatomic) PFObject *message;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *timer;
@property (strong, nonatomic) NSTimer *countdownTimer;

@end
