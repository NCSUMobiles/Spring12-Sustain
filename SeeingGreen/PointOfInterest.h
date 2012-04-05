//
//  PointOfInterest.h
//  LocationTest
//
//  Created by JONATHAN B MORGAN on 3/22/12.
//  Copyright (c) 2012 Team Segway Extreme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationServicesManager.h"

@interface PointOfInterest : NSObject {
	double latitude;
	double longitude;
	
	NSString *name;
	NSString *shortName;
	NSString *address;
	NSString *description;
	UIButton *button;
}

-(id)initWithLatitude:(double)lat longitude:(double)lon andName:(NSString *)locName;
-(id)initWithLatitude:(double)lat longitude:(double)lon name:(NSString *)locName address:(NSString *)addr andDescription:(NSString *)desc;
-(double)distanceTo;
-(double)headingTo;

@property double latitude;
@property double longitude;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *shortName;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) UIButton *button;
@end
