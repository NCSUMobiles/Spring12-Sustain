//
//  ViewController.h
//  LocationTest
//
//  Created by JONATHAN B MORGAN on 3/22/12.
//  Copyright (c) 2012 Team Segway Extreme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AVFoundation/AVFoundation.h>
#import "PointOfInterest.h"
#import "POIManager.h"
#import "LocationServicesManager.h"

@interface ARViewController : UIViewController <CLLocationManagerDelegate> {
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
	
	UIActivityIndicatorView *activityIndicator;
	
}

-(void)initCaptureSession;
-(IBAction)poiButtonTouched:(id)sender;

@property (nonatomic, retain) IBOutlet UILabel *latLabel;
@property (nonatomic, retain) IBOutlet UILabel *longLabel;
@property (nonatomic, retain) IBOutlet UILabel *headingLabel;
@property (nonatomic, retain) IBOutlet UILabel *poiHeadingLabel;
@property (nonatomic, retain) IBOutlet UILabel *distanceLabel;
@property (nonatomic, retain) IBOutlet UIView *cameraView;
@property (nonatomic, retain) IBOutlet UIImageView *compassImage;
@property (nonatomic, retain) IBOutlet UIImageView *poiCompassImage;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@end
