//
//  LocationServicesManager.h
//  LocationTest
//
//  Created by JONATHAN B MORGAN on 3/27/12.
//  Copyright (c) 2012 Team Segway Extreme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@class PointOfInterest;

#define DEGREES_TO_RADIANS (M_PI / 180.0)

@interface LocationServicesManager : NSObject {
	double latitude;
	double longitude;
	NSMutableArray *headings;
}

+(LocationServicesManager *)sharedLSM;

-(void)addLatitude:(double)lat andLongitude:(double)lon;
-(void)addHeading:(double)heading;
-(CLLocationDirection)getHeading;
-(NSNumber *)distanceToPOI:(PointOfInterest *)poi;
-(NSNumber *)headingToPOIInDegrees:(PointOfInterest *)poi;

@property (readonly) double latitude;
@property (readonly) double longitude;

@end
