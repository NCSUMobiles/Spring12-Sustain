//
//  ViewController.h
//  LocationTest
//
//  Created by JONATHAN B MORGAN on 3/22/12.
//  Copyright (c) 2012 Jonathan B Morgan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AVFoundation/AVFoundation.h>
#import "PointOfInterest.h"
#import "POIManager.h"
#import "LocationServicesManager.h"

@interface ARViewController : UIViewController <CLLocationManagerDelegate, UIAlertViewDelegate> {
	CLLocationManager *locationManager;
	
	AVCaptureSession *captureSession;
		
	UIView *cameraView;
	
	UIImageView *userFOVImage;
	UIImageView *userFOVCompassImage;
	UIImageView *poiCompassImage;
	
	UIButton *loadMapViewButton;
	UIButton *loadListViewButton;
	
	double currentViewHeading;
	double targetViewHeading;
}

-(void)initCaptureSession;
-(IBAction)poiButtonTouched:(id)sender;
-(IBAction)mapButtonTouched:(id)sender;
-(IBAction)listButtonTouched:(id)sender;

@property (nonatomic, retain) IBOutlet UIView *cameraView;
@property (nonatomic, retain) IBOutlet UIImageView *userFOVImage;
@property (nonatomic, retain) IBOutlet UIImageView *userFOVCompassImage;
@property (nonatomic, retain) IBOutlet UIImageView *poiCompassImage;
@property (nonatomic, retain) IBOutlet UIButton *loadMapViewButton;
@property (nonatomic, retain) IBOutlet UIButton *loadListViewButton;
@end
