//
//  POITableCell.m
//  SeeingGreen
//
//  Created by JONATHAN B MORGAN on 4/10/12.
//  Copyright (c) 2012Jonathan B Morgan. All rights reserved.
//

#import "POITableCell.h"

@implementation POITableCell

@synthesize nameLabel, distanceLabel, thumbnailImageView, headingImageView, topConnector, bottomConnector, closestLabel;
@synthesize poi;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
		headingImageView.autoresizingMask = UIViewAutoresizingNone;	//prevents the rotation transform from making the heading deformed
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
