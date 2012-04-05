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
@synthesize nameLabel, addressLabel, poiImageView, descriptionTextView, backButton, imageURL;
@synthesize name, address, description;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		nameLabel.text = name;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	nameLabel.text = name;
	addressLabel.text = address;
	descriptionTextView.text = description;

	//load the image from a URL
	//this should probably be done at app launch, right?
	//and cached somewhere?
	//probably?
	NSURL *imageNSURL = [NSURL URLWithString:imageURL];
	NSData *imageData = [NSData dataWithContentsOfURL:imageNSURL];
	UIImage *imageFromURL = [[UIImage alloc] initWithData:imageData];
	
	//updates the image in the view if the url was valid
	if(imageFromURL)
		poiImageView.image = imageFromURL;
	
	NSLog(@"%@",@"POIDetailViewController loaded");

}
-(IBAction)backButtonPressed:(id)sender {
	[self dismissModalViewControllerAnimated:TRUE];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
