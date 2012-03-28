//
//  PointOfInterest.h
//  LocationTest
//
//  Created by JONATHAN B MORGAN on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PointOfInterest : NSObject {
	double latitude;
	double longitude;
	NSString *name;
	NSString *description;
}

-(id)initWithLatitude:(double)lat andLongitude:(double)lon andName:(NSString *)locName andDescription:(NSString *)desc;

@property double latitude;
@property double longitude;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *description;

@end
