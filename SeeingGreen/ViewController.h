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
	UILabel *eb1headingLabel;
	UILabel *distanceLabel;
	
	UIView *cameraView;
	
	UIImageView *compassImage;
	UIImageView *eb1CompassImage;
	
	NSMutableArray *poiButtons;
	
	PointOfInterest *eb1;
	LocationServicesManager *locationServicesManager;
}

-(void)initCaptureSession;
-(double)distanceTo:(PointOfInterest *)poi;
-(double)headingTo:(PointOfInterest *)poi;

@property (nonatomic, retain) IBOutlet UILabel *latLabel;
@property (nonatomic, retain) IBOutlet UILabel *longLabel;
@property (nonatomic, retain) IBOutlet UILabel *headingLabel;
@property (nonatomic, retain) IBOutlet UILabel *eb1headingLabel;
@property (nonatomic, retain) IBOutlet UILabel *distanceLabel;
@property (nonatomic, retain) IBOutlet UIView *cameraView;
@property (nonatomic, retain) IBOutlet UIImageView *compassImage;
@property (nonatomic, retain) IBOutlet UIImageView *eb1CompassImage;

-(IBAction)poiButtonTouched:(id)sender;

@end
