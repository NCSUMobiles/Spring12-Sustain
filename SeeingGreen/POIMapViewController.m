//
//  POIMapViewController.m
//  SeeingGreen
//
//  Created by JONATHAN B MORGAN on 3/28/12.
//  Copyright (c) 2012 Team Segway Extreme. All rights reserved.
//

#import "POIMapViewController.h"
#import <MapKit/MapKit.h>
#define METERS_PER_MILE 1609.344

@interface POIMapViewController ()

@end

@implementation POIMapViewController
@synthesize mapView;
@synthesize backButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//loads the map centered at the latitude and longitude coordinates selected
- (void)viewWillAppear:(BOOL)animated {  
	
	//clear any existing annotations
	for (id<MKAnnotation> annotation in mapView.annotations)
        [mapView removeAnnotation:annotation];
	
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 35.778306;
    zoomLocation.longitude= -78.640974;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    MKCoordinateRegion adjustedRegion = [mapView regionThatFits:viewRegion];                
    [mapView setRegion:adjustedRegion animated:YES];      
	
	for(PointOfInterest *poi in [[POIManager sharedPOIManager] poiArray])
		[mapView addAnnotation:poi];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.	
}

-(IBAction)backButtonPressed:(id)sender {
	[self dismissModalViewControllerAnimated:TRUE];
}

- (void)viewDidUnload {
    [self setMapView:nil];
	[self setBackButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
