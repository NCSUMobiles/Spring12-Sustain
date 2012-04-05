//
//  PointOfInterest.m
//  LocationTest
//
//  Created by JONATHAN B MORGAN on 3/22/12.
//  Copyright (c) 2012 Team Segway Extreme. All rights reserved.
//

#import "PointOfInterest.h"

@implementation PointOfInterest 

@synthesize latitude;
@synthesize longitude;
@synthesize name;
@synthesize shortName;
@synthesize address;
@synthesize description;
@synthesize button;

//creates a POI with the given latitude, longitude, name, and description
-(id)initWithLatitude:(double)lat longitude:(double)lon andName:(NSString *)locName {
	if(self = [super init]) {
		latitude = lat;
		longitude = lon;
		name = locName;
		button = nil;
	}
	
	return self;
}

-(id)initWithLatitude:(double)lat longitude:(double)lon name:(NSString *)locName address:(NSString *)addr andDescription:(NSString *)desc {
	if(self = [super init]) {
		latitude = lat;
		longitude = lon;
		name = locName;
		description = desc;
		address = addr;
		button = nil;
	}
	
	return self;	
}

-(double)distanceTo {
	return [[[LocationServicesManager sharedLSM] distanceToPOI:self] doubleValue];
}

-(double)headingTo {
	return [[[LocationServicesManager sharedLSM] headingToPOIInDegrees:self] doubleValue];
}

@end
