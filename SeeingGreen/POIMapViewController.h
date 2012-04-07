//
//  POIMapViewController.h
//  SeeingGreen
//
//  Created by JONATHAN B MORGAN on 3/28/12.
//  Copyright (c) 2012 Team Segway Extreme. All rights reserved.
//

#import "ARViewController.h"
#import <MapKit/MapKit.h>

@interface POIMapViewController : UIViewController

-(IBAction)backButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@end
