//
//  PointOfInterest.h
//  LocationTest
//
//  Created by JONATHAN B MORGAN on 3/22/12.
//  Copyright (c) 2012 Team Segway Extreme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "LocationServicesManager.h"

@interface PointOfInterest : NSObject <MKAnnotation> {
	double latitude;
	double longitude;
	CLLocationCoordinate2D coordinate;
	
	NSString *name;
	NSString *shortName;
	NSString *address;
	NSString *description;
	NSString *imageURL;
	UIButton *button;
	UIImageView *poiDot;
	UIImage *image;
	
	NSMutableData *poiImageData;

}

-(id)initWithLatitude:(double)lat longitude:(double)lon andName:(NSString *)locName;
-(id)initWithLatitude:(double)lat longitude:(double)lon name:(NSString *)locName address:(NSString *)addr description:(NSString *)desc andImageURL:(NSString *)imgURL;
-(double)distanceTo;
-(double)headingTo;
-(double)userHeadingTo;
-(void)loadImage;

@property double latitude;
@property double longitude;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *shortName;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *imageURL;
@property (nonatomic, retain) UIButton *button;
@property (nonatomic, retain) UIImageView *poiDot;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@end
