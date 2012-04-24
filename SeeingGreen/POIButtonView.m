//
//  POIButtonView.m
//  SeeingGreen
//
//  Created by JONATHAN B MORGAN on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "POIButtonView.h"
#import "PointOfInterest.h"

@implementation POIButtonView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id) initWithPOI:(PointOfInterest *)point {
	if(self = [super init]) {
		
	}
	return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
