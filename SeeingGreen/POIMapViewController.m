//
//  POIMapViewController.m
//  SeeingGreen
//
//  Created by JONATHAN B MORGAN on 3/28/12.
//  Copyright (c) 2012 Team Segway Extreme. All rights reserved.
//

#import "POIMapViewController.h"
#import "POIDetailViewController.h"
#import <MapKit/MapKit.h>
#define METERS_PER_MILE 1609.344

@interface POIMapViewController ()

@end

@implementation POIMapViewController
@synthesize mapView;
@synthesize backButton;
@synthesize selectedPOI;

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


#pragma mark -
#pragma mark MKMapViewDelegate

- (void)showDetails:(id)sender
{
	/*
    // the detail view does not want a toolbar so hide it
    [self.navigationController setToolbarHidden:YES animated:NO];
    
    [self.navigationController pushViewController:self.detailViewController animated:YES];
	 */
	
	//PointOfInterest *poi = (PointOfInterest *)sender;
	
	[self performSegueWithIdentifier:@"ShowPOIDetails" sender:sender];
	
}

//Called when a POI button is pressed
//passes POI information to the POIDetailViewController being loaded
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	NSLog(@"%@",@"prepareForSegue");
	
	NSLog(@"%@", [[sender class] description]);
	
	//POITableCell *selectedCell = (POITableCell *)sender;
	PointOfInterest *poi = [[mapView selectedAnnotations] objectAtIndex:0];
	
    if ([[segue identifier] isEqualToString:@"ShowPOIDetails"]) {
        POIDetailViewController *detailViewController = (POIDetailViewController *)[[segue destinationViewController] visibleViewController];
		detailViewController.poi = poi;
		detailViewController.name = poi.name;
		detailViewController.address = poi.address;
		detailViewController.description = poi.description;
		detailViewController.imageURL = poi.imageURL;
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // if it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // handle our two custom annotations
    //
    if ([annotation isKindOfClass:[PointOfInterest class]])
    {		
        // try to dequeue an existing pin view first
		NSString *annotationIdentifier = selectedPOI.name;
        MKPinAnnotationView* pinView = (MKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
        if (!pinView)
        {
            // if an existing pin view was not available, create one
            MKPinAnnotationView* customPinView = [[MKPinAnnotationView alloc]
												   initWithAnnotation:annotation reuseIdentifier:annotationIdentifier];
            customPinView.pinColor = MKPinAnnotationColorRed;
            customPinView.animatesDrop = YES;
            customPinView.canShowCallout = YES;
            
            // add a detail disclosure button to the callout which will open a new view controller page
            //
            // note: you can assign a specific call out accessory view, or as MKMapViewDelegate you can implement:
            //  - (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control;
            //
            UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [rightButton addTarget:self
                            action:@selector(showDetails:)
                  forControlEvents:UIControlEventTouchUpInside];
            customPinView.rightCalloutAccessoryView = rightButton;
			
            return customPinView;
        }
        else
        {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    
    return nil;
}

@end
