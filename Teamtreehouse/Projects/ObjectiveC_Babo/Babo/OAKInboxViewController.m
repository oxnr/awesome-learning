//
//  OAKInboxViewController.m
//  Babo
//
//  Created by Onur Akpolat on 25.11.13.
//  Copyright (c) 2013 Onur Akpolat. All rights reserved.
//

#import "OAKInboxViewController.h"
#import "OAKImageViewController.h"
#import "MSCellAccessory.h"

@interface OAKInboxViewController ()

@end

@implementation OAKInboxViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.moviePlayer = [[MPMoviePlayerController alloc] init];
    
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser){
        
    }
    else {
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }
    
    // Show username in Navigation title
    NSString *title = [NSString stringWithFormat:@"Hej, %@", [currentUser objectForKey:@"username"]];
    self.navigationItem.title = title;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(retrieveMessages) forControlEvents:UIControlEventValueChanged];

}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Show Navigation Bar
    [self.navigationController.navigationBar setHidden:NO];
    
    [self retrieveMessages];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    PFObject *message = [self.messages objectAtIndex:indexPath.row];
    cell.textLabel.text = [message objectForKey:@"senderName"];
    
    UIColor *disclosureColour = [UIColor colorWithRed:0.553 green:0.439 blue:0.718 alpha:1.0];
    cell.accessoryView = [MSCellAccessory accessoryWithType:FLAT_DISCLOSURE_INDICATOR color:disclosureColour];
    
    NSString *fileType = [message objectForKey:@"fileType"];
    if ([fileType isEqualToString:@"image"]) {
        cell.imageView.image = [UIImage imageNamed:@"icon_image"];
    }
    else {
        cell.imageView.image = [UIImage imageNamed:@"icon_video"];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedMessage = [self.messages objectAtIndex:indexPath.row];
    NSString *fileType = [self.selectedMessage objectForKey:@"fileType"];
    if ([fileType isEqualToString:@"image"]) {
        
        // Perform Segue to ImgageViewController if Image
        [self performSegueWithIdentifier:@"showImage" sender:self];
    }
    else {
        
        // Perform MoviePlayerController if Video
        PFFile *videoFile = [self.selectedMessage objectForKey:@"file"];
        NSURL *fileUrl = [NSURL URLWithString:videoFile.url];
        self.moviePlayer.contentURL = fileUrl;
        [self.moviePlayer prepareToPlay];
        
        // Add it to the view controller so it shows
        [self.view addSubview:self.moviePlayer.view];
        [self.moviePlayer setFullscreen:YES animated:YES];
    }
    
    // Delete it!
    NSMutableArray *recipientIds = [NSMutableArray arrayWithArray:[self.selectedMessage objectForKey:@"recipientIds"]];
    //NSLog(@"Recipients: %@", recipientIds);
    
    if ([recipientIds count] == 1) {
        // Delete files from Parse.com
        [self.selectedMessage deleteInBackground];
    }
    else {
        // Remove recipient from recipientIds
        [recipientIds removeObject:[[PFUser currentUser] objectId]];
        [self.selectedMessage setObject:recipientIds forKey:@"recipientIds"];
        [self.selectedMessage saveInBackground];
    }
    
}

- (IBAction)logout:(id)sender {
    [PFUser logOut];
    [self performSegueWithIdentifier:@"showLogin" sender:self];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showLogin"]){
        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
    }
    else if ([segue.identifier isEqualToString:@"showImage"]){
        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
        OAKImageViewController *imageViewController = (OAKImageViewController *) segue.destinationViewController;
        imageViewController.message = self.selectedMessage;
    }
}

#pragma mark - Helper methods


- (void) retrieveMessages {
    PFQuery *query = [PFQuery queryWithClassName:@"Messages"];
   
    [query whereKey:@"recipientIds" equalTo:[[PFUser currentUser] objectId]];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            
        }
        else {
            self.messages = objects;
            [self.tableView reloadData];
        }
        
        if ([self.refreshControl isRefreshing]){
            [self.refreshControl endRefreshing];
        }
    }];
    
}
@end
