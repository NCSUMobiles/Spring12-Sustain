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
	
	//create the request.
	NSURLRequest *poiImageRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:imageURL]
												   cachePolicy:NSURLRequestUseProtocolCachePolicy
											   timeoutInterval:60.0];
	
	//create the connection with the request and start loading the data
	NSURLConnection *poiImageConnection=[[NSURLConnection alloc] initWithRequest:poiImageRequest delegate:self];
	
	if (poiImageConnection) {
		// Create the NSMutableData to hold the received data.
		poiImageData = [NSMutableData data];
	} else {
		// Inform the user that the connection failed.
	}
	
	/*
	NSData *imageData = [NSData dataWithContentsOfURL:imageNSURL];
	UIImage *imageFromURL = [[UIImage alloc] initWithData:imageData];
	
	//updates the image in the view if the url was valid
	if(imageFromURL)
		poiImageView.image = imageFromURL;
	*/
	
	NSLog(@"%@",@"POIDetailViewController loaded");

	[self setTitle:name];
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

-(IBAction)backButtonPressed:(id)sender {
	[self dismissModalViewControllerAnimated:TRUE];
}

#pragma mark -
#pragma mark Async data loading methods

// This method is called when the server has determined that it has enough information to create the NSURLResponse.	
// It can be called multiple times, for example in the case of a redirect, so each time we reset the data.
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [poiImageData setLength:0];
}

// Appends newly received data to poiImageData.
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [poiImageData appendData:data];
}

// inform the user of any error while loading the poi image data
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {	
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
	poiImageView.image = [UIImage imageNamed:@"imageNotFound.png"]; 
}

// update the POI image in the view once the data is finished loading
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {	
	UIImage *imageFromURL = [[UIImage alloc] initWithData:poiImageData];
	
	//updates the image in the view if the url was valid
	if(imageFromURL)
		poiImageView.image = imageFromURL;
	else
		poiImageView.image = [UIImage imageNamed:@"imageNotFound.png"]; 
}


@end
