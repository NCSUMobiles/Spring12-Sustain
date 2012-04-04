//
//  POIManager.m
//  SeeingGreen
//
//  Created by JONATHAN B MORGAN on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "POIManager.h"

#define DEFAULT_BUTTON_HEIGHT 50
#define DEFAULT_BUTTON_WIDTH 150

@implementation POIManager

@synthesize poiArray;
@synthesize currentTarget;

static POIManager *_sharedPOIManager = nil;

//returns the singleton instance of the class or creates one if one does not exist
+(POIManager *) sharedPOIManager {
	if(!_sharedPOIManager)
		_sharedPOIManager = [[self alloc] init];
	return _sharedPOIManager;
}

-(id) init {
	if(self = [super init]) {
		poiArray = [[NSMutableArray alloc] initWithCapacity:30];
		
		/*
		 //add POIs for Centennial Campus
		 [poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.771621 longitude:-78.675048 andName:@"EB I"]];
		 [poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.771969 longitude:-78.673847 andName:@"EB II"]];
		 [poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.770925 longitude:-78.673804 andName:@"EB III"]];
		 [poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.773588 longitude:-78.673375 andName:@"Innovation Cafe"]];
		 [poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.773088 longitude:-78.673943 andName:@"BTEC"]];
		 [poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.77358 longitude:-78.676014 andName:@"RedHat"]];
		 [poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.774019 longitude:-78.675778 andName:@"Partners III"]];
		 [poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.770516 longitude:-78.677339 andName:@"Partners I"]];
		 */
		
		//Add POIs for the walking tour
		[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.780204 longitude:-78.639214 andName:@"State Capitol"]];
		[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.773605 longitude:-78.640831 andName:@"Raleigh Convention Center"]];
		[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.773609 longitude:-78.640541 andName:@"R-Line Hybrid Electric Bus"]];
		[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.773132 longitude:-78.640602 andName:@"Big Belly Solar Trash Compactor"]];
		[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.772404 longitude:-78.640617 andName:@"Solar EV Charging Stations"]];
		[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.771580 longitude:-78.639587 andName:@"Progress Energy Center"]];
		
		currentTarget = [poiArray objectAtIndex:0];
	}
	
	return self;
}

-(void)createButtonsInViewController:(UIViewController *)viewController {
	//add a UIButton for each POI
	for(PointOfInterest *poi in [[POIManager sharedPOIManager] poiArray]) {
		UIButton *poiButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[poiButton addTarget:viewController 
					  action:@selector(poiButtonTouched:)
			forControlEvents:UIControlEventTouchUpInside];
		[poiButton setTitle:[poi name] forState:UIControlStateNormal];
		poiButton.frame = CGRectMake(-1000, 240, DEFAULT_BUTTON_WIDTH, DEFAULT_BUTTON_HEIGHT);
		poiButton.alpha = 1.0;
		poiButton.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
		[poi setButton:poiButton];
		[[viewController view] addSubview:poi.button];
	}
}

-(NSArray *)sortedByDistance {
	NSArray *sortedArray;
	sortedArray = [poiArray sortedArrayUsingComparator:^(id a, id b) {
		NSNumber *first = [[LocationServicesManager sharedLSM] distanceToPOI:(PointOfInterest*)a];
		NSNumber *second = [[LocationServicesManager sharedLSM] distanceToPOI:(PointOfInterest*)b];
		return [first compare:second];
	}];
	return sortedArray;
}

-(NSArray *)sortedByHeading {
	NSArray *sortedArray;
	sortedArray = [poiArray sortedArrayUsingComparator:^(id a, id b) {
		NSNumber *first = [[LocationServicesManager sharedLSM] headingToPOIInDegrees:(PointOfInterest*)a];
		NSNumber *second = [[LocationServicesManager sharedLSM] headingToPOIInDegrees:(PointOfInterest*)b];
		return [first compare:second];
	}];
	return sortedArray;
}
@end
