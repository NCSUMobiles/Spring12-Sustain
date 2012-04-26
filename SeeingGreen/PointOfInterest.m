//
//  PointOfInterest.m
//  LocationTest
//
//  Created by JONATHAN B MORGAN on 3/22/12.
//  Copyright (c) 2012 Team Segway Extreme. All rights reserved.
//

#import "PointOfInterest.h"

@implementation PointOfInterest 

@synthesize latitude, longitude, name, shortName, address, description, imageURL, image, button, poiDot, coordinate;

//creates a POI with the given latitude, longitude, name, address, description, and image
-(id)initWithLatitude:(double)lat longitude:(double)lon name:(NSString *)locName address:(NSString *)addr description:(NSString *)desc andImageURL:(NSString *)imgURL {
	if(self = [super init]) {
		latitude = lat;
		longitude = lon;
		name = locName;
		description = desc;
		address = addr;
		imageURL = imgURL;
		button = nil;
		poiDot = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"radar_poi.png"]];
		poiDot.center = CGPointMake(-1000, -1000);
		coordinate = CLLocationCoordinate2DMake(lat, lon);
		image = nil;
		imageLoading = FALSE;
		
		[self loadImage];
	}
	
	return self;	
}

//begins the async loading of the POI image
-(void)loadImage {
	
	if(imageLoading)
		return;
	
	imageLoading = TRUE;
	
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
}

//returns the name of the POI
//implements MKAnnotation
- (NSString *)title {
    if ([name isKindOfClass:[NSNull class]]) 
        return @"Unknown charge";
    else
        return name;
}

//returns the address of the POI
//implements MKAnnotation
- (NSString *)subtitle {
    return address;
}

//get the distance from the user's current location to the POI
-(double)distanceTo {
	return [[[LocationServicesManager sharedLSM] distanceToPOI:self] doubleValue];
}

//get the compass heading from the user's current location to the POI
//doesn't take the user's heading into account
-(double)headingTo {
	return [[[LocationServicesManager sharedLSM] headingToPOIInDegrees:self] doubleValue];
}

//get the compass heading from the user's current location to the POI
//takes into account the user's own heading
-(double)userHeadingTo {
	return [self headingTo] - [[LocationServicesManager sharedLSM] getHeading];
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
	image = [UIImage imageNamed:@"imageNotFound.png"]; 
}

// update the POI image in the view once the data is finished loading
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {	
	UIImage *imageFromURL = [[UIImage alloc] initWithData:poiImageData];
	
	//updates the image in the view if the url was valid
	if(imageFromURL) {
		image = imageFromURL;
		UIImageView *thumbnailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 9, 35, 34)];
		[thumbnailImageView setContentMode:UIViewContentModeScaleAspectFill];
		[thumbnailImageView setClipsToBounds:TRUE];
		[button addSubview:thumbnailImageView];

		thumbnailImageView.image = image;

	} else {
		image = [UIImage imageNamed:@"imageNotFound.png"]; 
	}
}


@end
