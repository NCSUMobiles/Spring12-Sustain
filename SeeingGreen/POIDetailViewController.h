//
//  POIDetailViewController.h
//  SeeingGreen
//
//  Created by JONATHAN B MORGAN on 3/28/12.
//  Copyright (c) 2012 Jonathan B Morgan. All rights reserved.
//

#import "ARViewController.h"

@interface POIDetailViewController : UIViewController {
	
	PointOfInterest *poi;
	
	NSString *name;
	NSString *shortName;
	NSString *address;
	NSString *description;
	NSString *imageURL;
	
	UIImageView *poiImageView;
	UILabel *nameLabel;
	UILabel *addressLabel;
	UITextView *descriptionTextView;
	UIButton *backButton;
	
	UIBarButtonItem *mapItBarButtonItem;
	
}
-(IBAction)backButtonPressed:(id)sender;
-(IBAction)mapIt:(id)sender;

@property (nonatomic, retain) IBOutlet UIBarButtonItem *mapItBarButtonItem;

@property (nonatomic, retain) IBOutlet UIImageView *poiImageView;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *addressLabel;
@property (nonatomic, retain) IBOutlet UITextView *descriptionTextView;
@property (nonatomic, retain) IBOutlet UIButton *backButton;
@property (nonatomic, retain) PointOfInterest *poi;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *imageURL;
@end
