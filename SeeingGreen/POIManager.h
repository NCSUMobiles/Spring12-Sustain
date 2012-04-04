//
//  POIManager.h
//  SeeingGreen
//
//  Created by JONATHAN B MORGAN on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PointOfInterest.h"

@interface POIManager : NSObject {
	NSMutableArray *poiArray;
	PointOfInterest *currentTarget;

}

@property (nonatomic, retain) NSMutableArray *poiArray;
@property (nonatomic, retain) PointOfInterest *currentTarget;

@end
