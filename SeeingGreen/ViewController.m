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
@synthesize eb1headingLabel;
@synthesize distanceLabel;
@synthesize compassImage;
@synthesize eb1CompassImage;

@synthesize cameraView;

//initializes location services and video capture functions
- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	poiButtons = [[NSMutableArray alloc] initWithCapacity:30];
	
	eb1 = [[PointOfInterest alloc] initWithLatitude:35.780204 andLongitude:-78.639214 andName:@"State Capitol" andDescription:@"Capitol. With an O."];
	
	
	// programmatically add a button for the POI
	// it doesn't make sense to do this for just one POI,
	// but when they're all loaded via CoreData or JSON 
	// we can put this in a loop
	UIButton *poiButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[poiButton addTarget:self 
				  action:@selector(poiButtonTouched:)
		forControlEvents:UIControlEventTouchUpInside];
	[poiButton setTitle:[eb1 name] forState:UIControlStateNormal];
	poiButton.frame = CGRectMake(-1000, 240, 117, 37);
	poiButton.alpha = 0.7;
	[[self view] addSubview:poiButton];
	[poiButtons addObject:poiButton];

	
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
		
		[self updateEB1Compass];
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
-(double)headingTo:(PointOfInterest *)poi {
	double dLongitude = [locationServicesManager latitude]-poi.longitude;
	double yDistance = sin(dLongitude) * cos(poi.latitude);
	double xDistance = cos([locationServicesManager latitude])*sin(poi.latitude) - sin([locationServicesManager latitude])*cos(poi.latitude)*cos(dLongitude);
	double bearingInDegrees = atan2(yDistance, xDistance) / DEGREES_TO_RADIANS;
	
	while(bearingInDegrees > 180)
		bearingInDegrees -= 360;
	while(bearingInDegrees < -180)
		bearingInDegrees += 360;
	
	return bearingInDegrees;
}

//returns the distance to a POI from the current location
-(double)distanceTo:(PointOfInterest *)poi {
	return [self haversineMilesToPOI:poi];
}

//calculates the distance to a POI from the current location
-(double)haversineMilesToPOI:(PointOfInterest *)poi {
	
    double dLongitude = ([poi longitude] - [locationServicesManager longitude]) * DEGREES_TO_RADIANS;
    double dLatitude = ([poi latitude] - [locationServicesManager latitude]) * DEGREES_TO_RADIANS;
	
	//I didn't name these variables, I don't know what they signify, I'm a terrible person
    double a = pow(sin(dLatitude/2.0), 2) + cos([locationServicesManager latitude]*DEGREES_TO_RADIANS) * cos([poi latitude]*DEGREES_TO_RADIANS) * pow(sin(dLongitude/2.0), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1-a));
    double distanceInMiles = 3956 * c; 
	
    return distanceInMiles;
}

//rotates the EB1 compass and moves the EB1 overlay
-(void)updateEB1Compass {
	
	UIButton *eb1Button = [poiButtons objectAtIndex:0];
	
	eb1CompassImage.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS * ([self headingTo:eb1]-[locationServicesManager getHeading]));
	
	if(fabs([self headingTo:eb1]-[locationServicesManager getHeading]) < 90)
		eb1Button.center = CGPointMake(160 + 230*sin(DEGREES_TO_RADIANS * ([self headingTo:eb1]-[locationServicesManager getHeading])), eb1Button.center.y);
	else
		eb1Button.center = CGPointMake(-1000,eb1Button.center.y);
	
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
		latLabel.text = [NSString stringWithFormat:@"%+.6f", [locationServicesManager latitude]];
		longLabel.text = [NSString stringWithFormat:@"%+.6f", [locationServicesManager longitude]];
		distanceLabel.text = [NSString stringWithFormat:@"%d feet", (int)(5280 * [self distanceTo:eb1])];
		[self updateEB1Compass];
    }
    // else skip the event and process the next one.
}

//handles the user touching a POI button
//this should push a new view controller (not yet implemented)
-(void)poiButtonTouched:(id)sender {
	UIButton *sendingButton = (UIButton *)sender;
	NSLog([sendingButton titleForState:UIControlStateNormal]);
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
	eb1headingLabel.text = [NSString stringWithFormat:@"%d", (int)([self headingTo:eb1]-[locationServicesManager getHeading])];
	
	compassImage.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS * -[locationServicesManager getHeading]);
	[self updateEB1Compass];
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
