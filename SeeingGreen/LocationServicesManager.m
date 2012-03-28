//
//  LocationServicesManager.m
//  LocationTest
//
//  Created by JONATHAN B MORGAN on 3/27/12.
//  Copyright (c) 2012 Team Segway Extreme. All rights reserved.
//

#import "LocationServicesManager.h"

#define HEADINGS_TO_SAVE 5

@implementation LocationServicesManager

@synthesize latitude;
@synthesize longitude;

-(id)init {
	if(self = [super init]) {
		headings = [[NSMutableArray alloc] initWithCapacity:20];
	}
	return self;
}

-(void)addLatitude:(double)lat andLongitude:(double)lon {
	latitude = lat;
	longitude = lon;
}

-(void)addHeading:(double)heading {
	
	while(heading < 0)
		heading += 360;
		
	[headings addObject:[NSNumber numberWithDouble:heading]];
	if([headings count] > HEADINGS_TO_SAVE)
		[headings removeObjectAtIndex:0];
}

//returns a box average of all retained headings
//you can't just average angles (clock math lolz), so you sum up their vectors and get the angle of that
-(CLLocationDirection)getHeading {
	double xDistance = 0;
	double yDistance = 0;
	
	for(NSNumber *heading in headings) {
		xDistance += cos([heading doubleValue]*DEGREES_TO_RADIANS);
		yDistance += sin([heading doubleValue]*DEGREES_TO_RADIANS);
	}
	
	return atan2(yDistance,xDistance)/DEGREES_TO_RADIANS;
}

@end
