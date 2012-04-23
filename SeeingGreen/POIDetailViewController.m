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
@synthesize poi, name, address, description;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		nameLabel.text = name;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	nameLabel.text = name;
	addressLabel.text = address;
	descriptionTextView.text = description;
	poiImageView.image = poi.image;

	//[self updateImage:nil];
	
	NSLog(@"%@",@"POIDetailViewController loaded");

	[self setTitle:name];
}

/*
-(void)updateImage:(NSTimer*)theTimer {
	NSLog(@"updateImage");
	if(poi.image == nil) {
		[NSTimer scheduledTimerWithTimeInterval:.3 target:self selector:@selector(updateImage:) userInfo:nil repeats:NO];
	} else {
		poiImageView.image = poi.image;
		[[poiImageView superview] setNeedsDisplay];
	}
}
 */

- (void)viewDidUnload
{
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
