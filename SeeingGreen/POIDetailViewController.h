//
//  POIDetailViewController.h
//  SeeingGreen
//
//  Created by JONATHAN B MORGAN on 3/28/12.
//  Copyright (c) 2012 Team Segway Extreme. All rights reserved.
//

#import "ARViewController.h"

@interface POIDetailViewController : UIViewController {
	NSString *name;
	NSString *shortName;
	NSString *address;
	NSString *description;
	
	UIImageView *poiImageView;
	UILabel *nameLabel;
	UILabel *addressLabel;
	UITextView *descriptionTextView;
	UIButton *backButton;
}
-(IBAction)backButtonPressed:(id)sender;

@property (nonatomic, retain) IBOutlet UIImageView *poiImageView;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *addressLabel;
@property (nonatomic, retain) IBOutlet UITextView *descriptionTextView;
@property (nonatomic, retain) IBOutlet UIButton *backButton;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *description;
@end
