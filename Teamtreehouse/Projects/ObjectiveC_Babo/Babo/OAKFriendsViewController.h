//
//  OAKFriendsViewController.h
//  Babo
//
//  Created by Onur Akpolat on 28.11.13.
//  Copyright (c) 2013 Onur Akpolat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface OAKFriendsViewController : UITableViewController

@property (strong, nonatomic) PFRelation *friendsRelation;
@property (strong, nonatomic) NSArray *friends;

@end
