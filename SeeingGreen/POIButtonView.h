//
//  POIButtonView.h
//  SeeingGreen
//
//  Created by JONATHAN B MORGAN on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PointOfInterest;

@interface POIButtonView : UIView {
	PointOfInterest *poi;
	UIImage *background;
	UIImage *thumbnail;
	UIImage *thumbnailBackground;
	UIImage *triangle;
}

@end
