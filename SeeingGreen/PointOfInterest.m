//
//  PointOfInterest.m
//  LocationTest
//
//  Created by JONATHAN B MORGAN on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PointOfInterest.h"

@implementation PointOfInterest 

@synthesize latitude;
@synthesize longitude;
@synthesize name;
@synthesize description;

//creates a POI with the given latitude, longitude, name, and description
-(id)initWithLatitude:(double)lat andLongitude:(double)lon andName:(NSString *)locName andDescription:(NSString *)desc {
	if(self = [super init]) {
		latitude = lat;
		longitude = lon;
		name = locName;
		description = desc;
	}
	
	return self;
}
@end
