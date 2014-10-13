//
//  OAKImageViewController.m
//  Babo
//
//  Created by Onur Akpolat on 30.11.13.
//  Copyright (c) 2013 Onur Akpolat. All rights reserved.
//

#import "OAKImageViewController.h"

@interface OAKImageViewController ()

@end

@implementation OAKImageViewController

int countdownCount;

- (void)viewDidLoad
{
    [super viewDidLoad];
	PFFile *imageFile = [self.message objectForKey:@"file"];
    NSURL *imageFileUrl = [[NSURL alloc] initWithString:imageFile.url];
    NSData *imageData = [NSData dataWithContentsOfURL:imageFileUrl];
    
    self.imageView.image = [UIImage imageWithData:imageData];
    
    // Change name of Navigation Button
    
    NSString *senderName = [self.message objectForKey:@"senderName"];
    NSString *title = [NSString stringWithFormat:@"Sent from %@", senderName];
    self.navigationItem.title = title;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self customizeTimer];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if ([self respondsToSelector:@selector(timeout)]) {
    
        // Start first timer (10 Seconds)
        [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(timeout) userInfo:nil repeats:NO];
        
        // Set Countdown to 10 seconds
        countdownCount = 10;
        
        // Start countdownTimer
        self.countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countdown) userInfo:nil repeats:YES];
    }
    else {
        // Display error show Log
    }
}

# pragma mark - Helper methods

-(void) countdown {
    countdownCount--;
    int *newCount = (int *)countdownCount;
    self.timer.text = [NSString stringWithFormat:@"%i", (int)newCount];
}

- (void) timeout {
    [self.countdownTimer invalidate];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void) customizeTimer {
    self.timer.text = @"10";
    self.timer.textColor = [UIColor whiteColor];
    self.timer.backgroundColor = [UIColor colorWithRed:0.173 green:0.243 blue:0.314 alpha:0.5];
    self.timer.layer.cornerRadius = self.timer.frame.size.width/2;
}


@end
