//
//  PointOfInterest.m
//  LocationTest
//
//  Created by JONATHAN B MORGAN on 3/22/12.
//  Copyright (c) 2012 Team Segway Extreme. All rights reserved.
//

#import "PointOfInterest.h"

@implementation PointOfInterest 

@synthesize latitude, longitude, name, shortName, address, description, imageURL, button, poiDot, coordinate;

//creates a POI with the given latitude, longitude, name, and description
-(id)initWithLatitude:(double)lat longitude:(double)lon andName:(NSString *)locName {
	if(self = [super init]) {
		latitude = lat;
		longitude = lon;
		name = locName;
		button = nil;
		coordinate = CLLocationCoordinate2DMake(lat, lon);
		poiDot = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"radar_poi.png"]];
		poiDot.center = CGPointMake(-1000, -1000);
	}
	
	return self;
}

//creates a POI with the given latitude, longitude, name, address, description, and image
-(id)initWithLatitude:(double)lat longitude:(double)lon name:(NSString *)locName address:(NSString *)addr description:(NSString *)desc andImageURL:(NSString *)imgURL {
	if(self = [super init]) {
		latitude = lat;
		longitude = lon;
		name = locName;
		description = desc;
		address = addr;
		imageURL = imgURL;
		button = nil;
		poiDot = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"radar_poi.png"]];
		poiDot.center = CGPointMake(-1000, -1000);
		coordinate = CLLocationCoordinate2DMake(lat, lon);
	}
	
	return self;	
}

//returns the name of the POI
//implements MKAnnotation
- (NSString *)title {
    if ([name isKindOfClass:[NSNull class]]) 
        return @"Unknown charge";
    else
        return name;
}

//returns the address of the POI
//implements MKAnnotation
- (NSString *)subtitle {
    return address;
}

//get the distance from the user's current location to the POI
-(double)distanceTo {
	return [[[LocationServicesManager sharedLSM] distanceToPOI:self] doubleValue];
}

//get the compass heading from the user's current location to the POI
-(double)headingTo {
	return [[[LocationServicesManager sharedLSM] headingToPOIInDegrees:self] doubleValue];
}

@end
