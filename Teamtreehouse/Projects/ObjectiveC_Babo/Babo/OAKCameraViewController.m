//
//  OAKCameraViewController.m
//  Babo
//
//  Created by Onur Akpolat on 28.11.13.
//  Copyright (c) 2013 Onur Akpolat. All rights reserved.
//

#import "OAKCameraViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "MSCellAccessory.h"

@interface OAKCameraViewController ()

@end

@implementation OAKCameraViewController

UIColor *disclosureColour;

- (void)viewDidLoad
{
    [super viewDidLoad];

    disclosureColour = [UIColor colorWithRed:0.204 green:0.596 blue:0.859 alpha:1]; /*#3498db*/
    self.recipients = [[NSMutableArray alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.friendsRelation = [[PFUser currentUser] objectForKey:@"friendsRelation"];
    
    PFQuery *query = [self.friendsRelation query];
    [query orderByAscending:@"username"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            
        }
        else {
            self.friends = objects;
            [self.tableView reloadData];
        }
    }];
    
    if (self.image == nil && [self.videoFilePath length] == 0) {
    
        // Initialize Camera
        self.imagePicker = [[UIImagePickerController alloc] init];
        self.imagePicker.delegate = self;
        self.imagePicker.allowsEditing = NO;
        self.imagePicker.videoMaximumDuration = 10;
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        else {
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        
        self.imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:self.imagePicker.sourceType];
        [self presentViewController:self.imagePicker animated:NO completion:nil];
    }
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
    return self.friends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PFUser *user = [self.friends objectAtIndex:indexPath.row];
    cell.textLabel.text = user.username;
    
    // Avoid reuse of cells and check if cells are checkmarked or not
    
    if ([self.recipients containsObject:user.objectId]) {
        cell.accessoryView = [MSCellAccessory accessoryWithType:FLAT_CHECKMARK color:disclosureColour];
    }
    else {
        cell.accessoryView = nil;
    }
    
    return cell;
}
#pragma  mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UITableViewCell *cell   = [self.tableView cellForRowAtIndexPath:indexPath];
    
    PFUser *user = [self.friends objectAtIndex:indexPath.row];
    
    if (cell.accessoryView == nil) {
        cell.accessoryView = [MSCellAccessory accessoryWithType:FLAT_CHECKMARK color:disclosureColour];
        [self.recipients addObject:user.objectId];
    }
    else {
        cell.accessoryView = nil;
        [self.recipients removeObject:user.objectId];
    }
    
}
#pragma mark - Image Picker Controller delegate

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:NO completion:nil];
    
    [self.tabBarController setSelectedIndex:0];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        // An Image was taken or selected
        self.image = [info objectForKey:UIImagePickerControllerOriginalImage];
        if (self.imagePicker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            // Save the image
            UIImageWriteToSavedPhotosAlbum(self.image, nil, nil, nil);
        }
    }
    else {
        // A Video was taken or selected
        self.videoFilePath = (__bridge NSString *)([[info objectForKey:UIImagePickerControllerMediaURL] path]);
        if (self.imagePicker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            // Save the video
            if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(self.videoFilePath)){
                UISaveVideoAtPathToSavedPhotosAlbum(self.videoFilePath, nil, nil, nil);
            }
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - IBActions

- (IBAction)cancel:(id)sender {
    
    [self clearData];
    [self.tabBarController setSelectedIndex:0];
}

- (IBAction)send:(id)sender {
    if (self.image == nil && [self.videoFilePath length] == 0){
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"Try again" message:@"Please capture or select a photo or a video to share" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alterView show];
        [self presentViewController:self.imagePicker animated:NO completion:nil];
    }
    else {
        
        // Check if recipients selected
        if (self.recipients.count != 0) {
            
            // Upload message on Parse.com
            
            [self uploadMessage];
            [self.tabBarController setSelectedIndex:0];
        }
        else {
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"Select Recipients" message:@"Please select one or more recipients" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alterView show];
        }
    }
}

#pragma mark - Helper methods

- (void) uploadMessage {
    
    NSData *fileData;
    NSString *fileName;
    NSString *fileType;
    
    // Check if image or video
    if (self.image != nil) {
        
        UIImage *newImage = [self resizeImage:self.image toWidth:320.0f andHeight:480.0f];
        fileData = UIImagePNGRepresentation(newImage);
        fileName = @"image.png";
        fileType = @"image";
    }
    else {
        fileData = [NSData dataWithContentsOfFile:self.videoFilePath];
        fileName = @"video.mov";
        fileType = @"video";
    }
    
    PFFile *file = [PFFile fileWithName:fileName data:fileData];
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"An error occured" message:@"Please try sending your message again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alterView show];
        }
        else {
            PFObject *message = [PFObject objectWithClassName:@"Messages"];
            [message setObject:file forKey:@"file"];
            [message setObject:fileType forKey:@"fileType"];
            [message setObject:self.recipients forKey:@"recipientIds"];
            [message setObject:[[PFUser currentUser] objectId] forKey:@"senderId"];
            [message setObject:[[PFUser currentUser] username] forKey:@"senderName"];
            [message saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (error) {
                    UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"An error occured" message:@"Please try sending your message again " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alterView show];
                }
                else {
                    // Reset all the data
                    [self clearData];
                }
            }];
        }
    }];
    
}

#pragma mark - Helper methods

- (void) clearData {
    self.image = nil;
    self.videoFilePath = nil;
    [self.recipients removeAllObjects];
}

- (UIImage *) resizeImage:(UIImage *)image toWidth:(float)width andHeight:(float)height {
    CGSize newSize = CGSizeMake(width, height);
    CGRect newRectangle = CGRectMake(0, 0, width, height);
    UIGraphicsBeginImageContext(newSize);
    [self.image drawInRect:newRectangle];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resizedImage;
}
@end