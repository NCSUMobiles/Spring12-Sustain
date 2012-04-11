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
#import "POIDetailViewController.h"
#define DEGREES_TO_RADIANS (M_PI / 180.0)
#define FOV_ADJUSTMENT 4.0
#define RADAR_CUTOFF_IN_MILES 0.4

@interface ARViewController ()

@end

@implementation ARViewController

@synthesize compassImage, poiCompassImage, cameraView, loadMapViewButton, loadListViewButton;

//initializes location services and video capture functions
- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	[[POIManager sharedPOIManager] createButtonsInViewController:self];
	[self initLocationServices];
	[self initCaptureSession];
}

//initializes the location services used to get GPS coordinates and compass heading
-(void)initLocationServices { 
	
	if( [CLLocationManager locationServicesEnabled]) {
		
		locationManager = [[CLLocationManager alloc] init];
		locationManager.delegate = self;
		
		locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
		
		//set the distance filter to 5 meters
		locationManager.distanceFilter = 5;
		
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
	double headingToTarget = [[[POIManager sharedPOIManager] currentTarget] headingTo]-[[LocationServicesManager sharedLSM] getHeading];
	poiCompassImage.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS * headingToTarget);
	
	for(PointOfInterest *poi in [[POIManager sharedPOIManager] poiArray]) {
		UIButton *poiButton = [poi button];
		
		
		//the rest of this block can almost certainly be reduced to 1 line of code
		//trigonometry lolz
		double compassHeadingToPOI = [poi headingTo];
		double userHeadingToPOI = compassHeadingToPOI - [[LocationServicesManager sharedLSM] getHeading];
		
		while(userHeadingToPOI < -180)
			userHeadingToPOI += 360;
		while(userHeadingToPOI > 180)
			userHeadingToPOI -= 360;
		double distanceToPOI = [poi distanceTo];
		CGFloat poiButtonXPosition = 160.0f; //center of the screen
		double theta = 0.0;
		
		if(0 <= userHeadingToPOI && userHeadingToPOI <= 90) {
			theta = (90.0 - userHeadingToPOI) * DEGREES_TO_RADIANS;
			poiButtonXPosition += 160 * cos(theta) * FOV_ADJUSTMENT;
		} else if(-90 <= userHeadingToPOI && userHeadingToPOI < 0) {
			theta = (90.0 + userHeadingToPOI) * DEGREES_TO_RADIANS;
			poiButtonXPosition -= 160 * cos(theta) * FOV_ADJUSTMENT;
		} else {
			poiButtonXPosition = -1000;
		}
		poiButton.center = CGPointMake(poiButtonXPosition, poiButton.center.y);
		
		if(distanceToPOI < RADAR_CUTOFF_IN_MILES) {			
			double poiDotTheta =  DEGREES_TO_RADIANS * userHeadingToPOI - M_PI/2;

			poi.poiDot.center = CGPointMake(compassImage.center.x + 40.0 / RADAR_CUTOFF_IN_MILES * distanceToPOI * cos(poiDotTheta),
											compassImage.center.y + 40.0 / RADAR_CUTOFF_IN_MILES * distanceToPOI * sin(poiDotTheta));
		} else {
			poi.poiDot.center = CGPointMake(-1000,-1000);
		}
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
		[self updatePOICompass];
    }
    // else skip the event and process the next one.
}

//handles the user touching a POI button
//this should push a new view controller (not yet implemented)
-(void)poiButtonTouched:(id)sender {
	UIButton *sendingButton = (UIButton *)sender;
	NSLog(@"%@", [sendingButton titleForState:UIControlStateNormal]);
	
	//update the current target to the POI whose button was pressed
	[[POIManager sharedPOIManager] setTargetWithButton:sendingButton];
	[self performSegueWithIdentifier:@"ShowPOIDetails" sender:sender];
}

//load the POIMapViewController
-(void)mapButtonTouched:(id)sender {
	[self performSegueWithIdentifier:@"ShowPOIMap" sender:sender];
}

//load the POIMapViewController
-(void)listButtonTouched:(id)sender {
	[self performSegueWithIdentifier:@"ShowPOIList" sender:sender];
}

//called when the magnetometer heading changes
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
	if (newHeading.headingAccuracy < 0)
		return;
	
	// Use the true heading if it is valid.
	CLLocationDirection  theHeading = ((newHeading.trueHeading > 0) ?
									   newHeading.trueHeading : newHeading.magneticHeading);
	
	[[LocationServicesManager sharedLSM] addHeading:theHeading];
	
	compassImage.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS * -[[LocationServicesManager sharedLSM] getHeading]);
	[self updatePOICompass];
	
	//update the button z-orders
	NSArray *sortedByDistance = [[POIManager sharedPOIManager] sortedByDistance];
	NSEnumerator *enumerator = [sortedByDistance reverseObjectEnumerator];
	
	int maxDistanceYValue = 100;
    for (PointOfInterest *poi in enumerator) {
		[poi.button.superview bringSubviewToFront:poi.button];
		poi.button.center = CGPointMake(poi.button.center.x,maxDistanceYValue);
		maxDistanceYValue+=5;
	}
}

//called when the location manager experiences a failure
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	NSLog(@"teh errorz :(");
}

//Called when a POI button is pressed
//passes POI information to the POIDetailViewController being loaded
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	NSLog(@"%@",@"prepareForSegue");
	
    if ([[segue identifier] isEqualToString:@"ShowPOIDetails"]) {
        POIDetailViewController *detailViewController = (POIDetailViewController *)[[segue destinationViewController] visibleViewController];
		PointOfInterest *poi = [[POIManager sharedPOIManager] getPOIWithButton:(UIButton *)sender];
		detailViewController.name = poi.name;
		detailViewController.address = poi.address;
		detailViewController.description = poi.description;
		detailViewController.imageURL = poi.imageURL;
    }
}

//stops and hides the activity indicator when the new view loads
-(void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

//keep the device in portrait orientation
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
	    return (interfaceOrientation == UIInterfaceOrientationPortrait);
	else
	    return YES;
}

@end