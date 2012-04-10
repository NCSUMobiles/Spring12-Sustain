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
		poiDot = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"poiDot.png"]];
		poiDot.center = CGPointMake(-1000, -1000);
	}
	
	return self;
}

-(id)initWithLatitude:(double)lat longitude:(double)lon name:(NSString *)locName address:(NSString *)addr description:(NSString *)desc andImageURL:(NSString *)imgURL {
	if(self = [super init]) {
		latitude = lat;
		longitude = lon;
		name = locName;
		description = desc;
		address = addr;
		imageURL = imgURL;
		button = nil;
		poiDot = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"poiDot.png"]];
		poiDot.center = CGPointMake(-1000, -1000);
		coordinate = CLLocationCoordinate2DMake(lat, lon);
	}
	
	return self;	
}

- (NSString *)title {
    if ([name isKindOfClass:[NSNull class]]) 
        return @"Unknown charge";
    else
        return name;
}

- (NSString *)subtitle {
    return address;
}

-(double)distanceTo {
	return [[[LocationServicesManager sharedLSM] distanceToPOI:self] doubleValue];
}

-(double)headingTo {
	return [[[LocationServicesManager sharedLSM] headingToPOIInDegrees:self] doubleValue];
}

@end
