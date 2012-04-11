//
//  LocationServicesManager.m
//  LocationTest
//
//  Created by JONATHAN B MORGAN on 3/27/12.
//  Copyright (c) 2012 Team Segway Extreme. All rights reserved.
//

#import "LocationServicesManager.h"
#import "PointOfInterest.h"

#define HEADINGS_TO_SAVE 1
#define TEST

#ifdef TEST
#define SPOOF_LOCATION
#endif

@implementation LocationServicesManager

@synthesize latitude, longitude;

static LocationServicesManager *_sharedLocationServicesManager = nil;

//gets the singleton instance of the LSM or creates one if one hasn't yet been creates
+(LocationServicesManager *)sharedLSM {
	if(!_sharedLocationServicesManager)
		_sharedLocationServicesManager = [[self alloc] init];
	return _sharedLocationServicesManager;
}

-(id)init {
	if(self = [super init]) {
		headings = [[NSMutableArray alloc] initWithCapacity:20];
	}
	return self;
}

//update the user's current location
-(void)addLatitude:(double)lat andLongitude:(double)lon {
	latitude = lat;
	longitude = lon;
	
	#ifdef SPOOF_LOCATION
		latitude = 35.77754;
		longitude = -78.640952;
	#endif
}

//add a compass heading to the list of headings
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

//returns the distance to a POI from teh user's current location
-(NSNumber *)distanceToPOI:(PointOfInterest *)poi {
	double dLongitude = (poi.longitude - [LocationServicesManager sharedLSM].longitude) * DEGREES_TO_RADIANS;
    double dLatitude = (poi.latitude - [LocationServicesManager sharedLSM].latitude) * DEGREES_TO_RADIANS;
	
	//I didn't name these variables, I don't know what they signify, I'm a terrible person
    double a = pow(sin(dLatitude/2.0), 2) + cos([LocationServicesManager sharedLSM].latitude*DEGREES_TO_RADIANS) * cos(poi.latitude*DEGREES_TO_RADIANS) * pow(sin(dLongitude/2.0), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1-a));
    double distanceInMiles = 3956 * c; 
	
    return [NSNumber numberWithDouble:distanceInMiles];
}

//returns the heading to a POI from the current location and orientation
-(NSNumber *)headingToPOIInDegrees:(PointOfInterest *)poi {
	
	double lon1, lon2, lat1, lat2;
	lon1 = DEGREES_TO_RADIANS * longitude;
	lat1 = DEGREES_TO_RADIANS * latitude;
	lon2 = DEGREES_TO_RADIANS * poi.longitude;
	lat2 = DEGREES_TO_RADIANS * poi.latitude;
	
	double dLon = lon2 - lon1;
    double y = sin(dLon) * cos(lat2);
    double x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
	
	double bearingInDegrees = atan2(y, x) / DEGREES_TO_RADIANS;
	
	while(bearingInDegrees > 180)
		bearingInDegrees -= 360;
	while(bearingInDegrees < -180)
		bearingInDegrees += 360;
	
	return [NSNumber numberWithDouble:bearingInDegrees];
}

@end
