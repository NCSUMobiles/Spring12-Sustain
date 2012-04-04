//
//  ViewController.m
//  LocationTest
//
//  Contains all of the main functionality of the AR view for the application.  Most of this
//  should really be moved to a secondary class.
//  
//  Created by JONATHAN B MORGAN on 3/22/12.
//  Copyright (c) 2012 Team Segway Extreme. All rights reserved.
//

#import "ARViewController.h"
#define DEGREES_TO_RADIANS (M_PI / 180.0)

@interface ARViewController ()

@end

@implementation ARViewController

@synthesize latLabel;
@synthesize longLabel;
@synthesize headingLabel;
@synthesize poiHeadingLabel;
@synthesize distanceLabel;
@synthesize compassImage;
@synthesize poiCompassImage;

@synthesize cameraView;

#define DEFAULT_BUTTON_HEIGHT 50
#define DEFAULT_BUTTON_WIDTH 150

//initializes location services and video capture functions
- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	poiButtons = [[NSMutableArray alloc] initWithCapacity:30];
	
	//add a UIButton for each POI
	for(PointOfInterest *poi in [[POIManager sharedPOIManager] poiArray]) {
		UIButton *poiButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[poiButton addTarget:self 
					  action:@selector(poiButtonTouched:)
			forControlEvents:UIControlEventTouchUpInside];
		[poiButton setTitle:[poi name] forState:UIControlStateNormal];
		poiButton.frame = CGRectMake(-1000, 240, DEFAULT_BUTTON_WIDTH, DEFAULT_BUTTON_HEIGHT);
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



//rotates the POI compass and moves the POI overlay
-(void)updatePOICompass {
	
	double headingToTarget = [[[POIManager sharedPOIManager] currentTarget] distanceTo]-[[LocationServicesManager sharedLSM] getHeading];
	poiCompassImage.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS * headingToTarget);
		
	for(PointOfInterest *poi in [[POIManager sharedPOIManager] poiArray]) {
		UIButton *poiButton = [poi button];
		double headingToPOI = [poi headingTo];

		if(fabs(headingToPOI-[[LocationServicesManager sharedLSM] getHeading]) < 90)
			poiButton.center = CGPointMake(160 + 230*sin(DEGREES_TO_RADIANS * (headingToPOI-[[LocationServicesManager sharedLSM] getHeading])), poiButton.center.y);
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
		[[LocationServicesManager sharedLSM] addLatitude:newLocation.coordinate.latitude andLongitude:newLocation.coordinate.longitude];
		latLabel.text = [NSString stringWithFormat:@"%+.6f", [LocationServicesManager sharedLSM].latitude];
		longLabel.text = [NSString stringWithFormat:@"%+.6f", [LocationServicesManager sharedLSM].longitude];
		
		double distanceToTarget = [[[POIManager sharedPOIManager] currentTarget] distanceTo];
		distanceLabel.text = [NSString stringWithFormat:@"%d feet", (int)(5280 * distanceToTarget)];
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
	
	[[LocationServicesManager sharedLSM] addHeading:theHeading];
	
	double headingToTarget = [[[POIManager sharedPOIManager] currentTarget] distanceTo]-[[LocationServicesManager sharedLSM] getHeading];

	headingLabel.text = [NSString stringWithFormat:@"%d", (int)[[LocationServicesManager sharedLSM] getHeading]];
	poiHeadingLabel.text = [NSString stringWithFormat:@"%d", (int)headingToTarget];
	
	compassImage.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS * -[[LocationServicesManager sharedLSM] getHeading]);
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
