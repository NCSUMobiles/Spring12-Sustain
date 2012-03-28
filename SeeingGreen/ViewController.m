//
//  ViewController.m
//  LocationTest
//
//  Contains all of the main functionality of the application.  Most of this
//  should really be moved to a secondary class.
//  
//  Created by JONATHAN B MORGAN on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#define DEGREES_TO_RADIANS (M_PI / 180.0)

@interface ViewController ()

@end

@implementation ViewController

@synthesize latLabel;
@synthesize longLabel;
@synthesize headingLabel;
@synthesize poiHeadingLabel;
@synthesize distanceLabel;
@synthesize compassImage;
@synthesize poiCompassImage;

@synthesize cameraView;

//initializes location services and video capture functions
- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	poiButtons = [[NSMutableArray alloc] initWithCapacity:30];
	
	poiArray = [[NSMutableArray alloc] initWithCapacity:30];
	
	
	[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.780204 longitude:-78.639214 andName:@"State Capitol"]];
	[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.773605 longitude:-78.640831 andName:@"Raleigh Convention Center"]];
	[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.773609 longitude:-78.640541 andName:@"R-Line Hybrid Electric Bus"]];
	[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.773132 longitude:-78.640602 andName:@"Big Belly Solar Trash Compactor"]];
	[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.772404 longitude:-78.640617 andName:@"Solar EV Charging Stations"]];
	[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.771580 longitude:-78.639587 andName:@"Progress Energy Center"]];
	
	
	[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.771621 longitude:-78.675048 andName:@"EB I"]];
	[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.771969 longitude:-78.673847 andName:@"EB II"]];
	[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.770925 longitude:-78.673804 andName:@"EB III"]];
	[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.773588 longitude:-78.673375 andName:@"Innovation Cafe"]];
	[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.773088 longitude:-78.673943 andName:@"BTEC"]];
	[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.77358 longitude:-78.676014 andName:@"RedHat"]];
	[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.774019 longitude:-78.675778 andName:@"Partners III"]];
	[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.770516 longitude:-78.677339 andName:@"Partners I"]];

	// programmatically add a button for the POIs	
	for(PointOfInterest *poi in poiArray) {
		UIButton *poiButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[poiButton addTarget:self 
					  action:@selector(poiButtonTouched:)
			forControlEvents:UIControlEventTouchUpInside];
		[poiButton setTitle:[poi name] forState:UIControlStateNormal];
		poiButton.frame = CGRectMake(-1000, 240, 157, 67);
		poiButton.alpha = 0.5;
		poiButton.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
		[[self view] addSubview:poiButton];
		[poiButtons addObject:poiButton];
		[poi setButton:poiButton];
	}
	
	[self initLocationServices];
	[self initCaptureSession];
}

//initializes the location services used to get GPS coordinates and compass heading
-(void)initLocationServices { 
	locationServicesManager = [[LocationServicesManager alloc] init];
	
	if( [CLLocationManager locationServicesEnabled]) {
		
		locationManager = [[CLLocationManager alloc] init];
		locationManager.delegate = self;
		
		locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
		
		//set the distance filter to 10 meters
		locationManager.distanceFilter = 10;
		
		[locationManager startUpdatingLocation];
		[locationManager startUpdatingHeading];	
		
		[self updatePOICompass];
	}	
}

//initializes the capture session used to display the camera feed
-(void)initCaptureSession {
	captureSession = [[AVCaptureSession alloc] init];
	
	AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
	if (videoDevice) {
		NSError *error;
		AVCaptureDeviceInput *videoIn = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
		if (!error) {
			if ([captureSession canAddInput:videoIn])
				[captureSession addInput:videoIn];
			else
				NSLog(@"Couldn't add video input");
		} else
			NSLog(@"Couldn't create video input");
	} else
		NSLog(@"Couldn't create video capture device");
	
	[captureSession startRunning];
	
	AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:captureSession];
	previewLayer.frame = cameraView.bounds;
	previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
	[[cameraView layer] addSublayer:previewLayer];
}

//returns the heading to a POI from the current location and orientation
-(double)headingToInDegrees:(PointOfInterest *)poi {
	/*
	double dLongitude = locationServicesManager.latitude-poi.longitude;
	double yDistance = sin(DEGREES_TO_RADIANS * dLongitude) * cos(DEGREES_TO_RADIANS * poi.latitude);
	double xDistance = cos(DEGREES_TO_RADIANS * locationServicesManager.latitude)*sin(DEGREES_TO_RADIANS * poi.latitude) 
						- sin(DEGREES_TO_RADIANS * locationServicesManager.latitude)*cos(DEGREES_TO_RADIANS * poi.latitude)*cos(DEGREES_TO_RADIANS * dLongitude);
	 
	 */
	double lon1, lon2, lat1, lat2;
	lon1 = DEGREES_TO_RADIANS * locationServicesManager.longitude;
	lat1 = DEGREES_TO_RADIANS * locationServicesManager.latitude;
	lon2 = DEGREES_TO_RADIANS * poi.longitude;
	lat2 = DEGREES_TO_RADIANS * poi.latitude;
	
	double dLon = lon2 - lon1;
    double y = sin(dLon) * cos(lat2);
    double x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
	
	double bearingInDegrees = atan2(y, x) / DEGREES_TO_RADIANS;
	
	while(bearingInDegrees > 180)
		bearingInDegrees -= 360;
	while(bearingInDegrees < -180)
		bearingInDegrees += 360;
	
	//NSLog(@"%f", bearingInDegrees);
	return bearingInDegrees;
}

//returns the distance to a POI from the current location
-(double)distanceTo:(PointOfInterest *)poi {
	return [self haversineMilesToPOI:poi];
}

//calculates the distance to a POI from the current location
-(double)haversineMilesToPOI:(PointOfInterest *)poi {
	
    double dLongitude = (poi.longitude - locationServicesManager.longitude) * DEGREES_TO_RADIANS;
    double dLatitude = (poi.latitude - locationServicesManager.latitude) * DEGREES_TO_RADIANS;
	
	//I didn't name these variables, I don't know what they signify, I'm a terrible person
    double a = pow(sin(dLatitude/2.0), 2) + cos(locationServicesManager.latitude*DEGREES_TO_RADIANS) * cos(poi.latitude*DEGREES_TO_RADIANS) * pow(sin(dLongitude/2.0), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1-a));
    double distanceInMiles = 3956 * c; 
	
    return distanceInMiles;
}

//rotates the POI compass and moves the POI overlay
-(void)updatePOICompass {
	
	//UIButton *poiButton = [poiButtons objectAtIndex:0];
	
	//CLLocationDirection headingToPOI = [self headingTo:[poiArray objectAtIndex:0]];
	poiCompassImage.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS * ([self headingToInDegrees:[poiArray objectAtIndex:0]]-[locationServicesManager getHeading]));
		
	for(PointOfInterest *poi in poiArray) {
		UIButton *poiButton = [poi button];
		double headingToPOI = [self headingToInDegrees:poi];
		//NSLog(@"Heading to POI %@: %f", poiButton.titleLabel.text, headingToPOI-[locationServicesManager getHeading]);
		if(fabs(headingToPOI-[locationServicesManager getHeading]) < 90)
			poiButton.center = CGPointMake(160 + 230*sin(DEGREES_TO_RADIANS * (headingToPOI-[locationServicesManager getHeading])), poiButton.center.y);
		else
			poiButton.center = CGPointMake(-1000,poiButton.center.y);
	}
	
}

// Delegate method from the CLLocationManagerDelegate protocol.
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation {
	
    // If it's a relatively recent event, turn off updates to save power
    NSDate* eventDate = newLocation.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
	
    if (abs(howRecent) < 15.0) {		
		[locationServicesManager addLatitude:newLocation.coordinate.latitude andLongitude:newLocation.coordinate.longitude];
		latLabel.text = [NSString stringWithFormat:@"%+.6f", locationServicesManager.latitude];
		longLabel.text = [NSString stringWithFormat:@"%+.6f", locationServicesManager.longitude];
		distanceLabel.text = [NSString stringWithFormat:@"%d feet", (int)(5280 * [self distanceTo:[poiArray objectAtIndex:0]])];
		[self updatePOICompass];
    }
    // else skip the event and process the next one.
}

//handles the user touching a POI button
//this should push a new view controller (not yet implemented)
-(void)poiButtonTouched:(id)sender {
	UIButton *sendingButton = (UIButton *)sender;
	NSLog(@"%@", [sendingButton titleForState:UIControlStateNormal]);
}

//called when the magnetometer heading changes
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
	if (newHeading.headingAccuracy < 0)
		return;
	
	// Use the true heading if it is valid.
	CLLocationDirection  theHeading = ((newHeading.trueHeading > 0) ?
									   newHeading.trueHeading : newHeading.magneticHeading);
	
	[locationServicesManager addHeading:theHeading];
	
	headingLabel.text = [NSString stringWithFormat:@"%d", (int)[locationServicesManager getHeading]];
	poiHeadingLabel.text = [NSString stringWithFormat:@"%d", (int)([self headingToInDegrees:[poiArray objectAtIndex:0]]-[locationServicesManager getHeading])];
	
	compassImage.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS * -[locationServicesManager getHeading]);
	[self updatePOICompass];
} 

//called when the location manager experiences a failure
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	NSLog(@"teh errorz :(");
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

//keep the device in portrait orientation
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
	    return (interfaceOrientation == UIInterfaceOrientationPortrait);
	} else {
	    return YES;
	}
}

@end
