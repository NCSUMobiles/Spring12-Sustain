//
//  POIDetailViewController.m
//  SeeingGreen
//
//  Created by JONATHAN B MORGAN on 3/28/12.
//  Copyright (c) 2012 Team Segway Extreme. All rights reserved.
//

#import "POIDetailViewController.h"

@interface POIDetailViewController ()

@end

@implementation POIDetailViewController
@synthesize mapItBarButtonItem;
@synthesize nameLabel, addressLabel, poiImageView, descriptionTextView, backButton, imageURL;
@synthesize poi, name, address, description;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		nameLabel.text = name;
    }
    return self;
}

//updates the view with information passed in the previous view controller's prepareForSegue method
- (void)viewDidLoad {
    [super viewDidLoad];

	nameLabel.text = name;
	addressLabel.text = address;
	descriptionTextView.text = description;
	poiImageView.image = poi.detailImage;

	//[self updateImage:nil];
	[mapItBarButtonItem setAction:@selector(mapIt:)];
	[mapItBarButtonItem setTarget:self];
}

//launches the Maps app to get walking directions to the targeted POI
-(IBAction)mapIt:(id)sender {
	NSString *routeString = [NSString stringWithFormat:@"http://maps.google.com/maps?saddr=%f,%f&daddr=%f,%f&dirflg=w",
							 [[LocationServicesManager sharedLSM] latitude], 
							 [[LocationServicesManager sharedLSM] longitude],
							 [poi latitude],
							 [poi longitude]];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:routeString]];
}

- (void)viewDidUnload
{
	[self setMapItBarButtonItem:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)backButtonPressed:(id)sender {
	[self dismissModalViewControllerAnimated:TRUE];
}



@end
