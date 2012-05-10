//
//  POIManager.h
//  SeeingGreen
//
//  Created by JONATHAN B MORGAN on 4/4/12.
//  Copyright (c) 2012Jonathan B Morgan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PointOfInterest.h"
#import "LocationServicesManager.h"

@interface POIManager : NSObject {
	NSMutableArray *poiArray;
	PointOfInterest *currentTarget;

}

+(POIManager *)sharedPOIManager;
-(void)createButtonsInViewController:(UIViewController *)viewController;
-(NSArray *)sortedByDistance;
-(NSArray *)sortedByHeading;
-(void)setTargetWithButton:(UIButton *)button;
-(PointOfInterest *)getPOIWithButton:(UIButton *)button;
-(PointOfInterest *)closestPOI;
-(PointOfInterest *)previousPOI;
-(PointOfInterest *)nextPOI;

@property (nonatomic, retain) NSMutableArray *poiArray;
@property (nonatomic, retain) PointOfInterest *currentTarget;

@end
