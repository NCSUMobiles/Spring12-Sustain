//
//  ViewController.h
//  LocationTest
//
//  Created by JONATHAN B MORGAN on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AVFoundation/AVFoundation.h>
#import "PointOfInterest.h"
#import "LocationServicesManager.h"

@interface ViewController : UIViewController <CLLocationManagerDelegate> {
	CLLocationManager *locationManager;
	
	AVCaptureSession *captureSession;
	
	UILabel *latLabel;
	UILabel *longLabel;
	UILabel *headingLabel;
	UILabel *poiHeadingLabel;
	UILabel *distanceLabel;
	
	UIView *cameraView;
	
	UIImageView *compassImage;
	UIImageView *poiCompassImage;
	
	NSMutableArray *poiButtons;

	PointOfInterest *capitolBuilding;
	LocationServicesManager *locationServicesManager;
}

-(void)initCaptureSession;
-(double)distanceTo:(PointOfInterest *)poi;
-(double)headingTo:(PointOfInterest *)poi;

@property (nonatomic, retain) IBOutlet UILabel *latLabel;
@property (nonatomic, retain) IBOutlet UILabel *longLabel;
@property (nonatomic, retain) IBOutlet UILabel *headingLabel;
@property (nonatomic, retain) IBOutlet UILabel *poiHeadingLabel;
@property (nonatomic, retain) IBOutlet UILabel *distanceLabel;
@property (nonatomic, retain) IBOutlet UIView *cameraView;
@property (nonatomic, retain) IBOutlet UIImageView *compassImage;
@property (nonatomic, retain) IBOutlet UIImageView *poiCompassImage;

-(IBAction)poiButtonTouched:(id)sender;

@end
