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
		
	UIView *cameraView;
	
	UIImageView *compassImage;
	UIImageView *poiCompassImage;
	
	UIButton *loadMapViewButton;
	UIButton *loadListViewButton;
}

-(void)initCaptureSession;
-(IBAction)poiButtonTouched:(id)sender;
-(IBAction)mapButtonTouched:(id)sender;
-(IBAction)listButtonTouched:(id)sender;

@property (nonatomic, retain) IBOutlet UIView *cameraView;
@property (nonatomic, retain) IBOutlet UIImageView *compassImage;
@property (nonatomic, retain) IBOutlet UIImageView *poiCompassImage;
@property (nonatomic, retain) IBOutlet UIButton *loadMapViewButton;
@property (nonatomic, retain) IBOutlet UIButton *loadListViewButton;
@end
