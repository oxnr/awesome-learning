//
//  OAKInboxViewController.h
//  Babo
//
//  Created by Onur Akpolat on 25.11.13.
//  Copyright (c) 2013 Onur Akpolat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <MediaPlayer/MediaPlayer.h>

@interface OAKInboxViewController : UITableViewController

@property (strong, nonatomic) NSArray *messages;
@property (strong, nonatomic) PFObject *selectedMessage;
@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

- (IBAction)logout:(id)sender;

@end
