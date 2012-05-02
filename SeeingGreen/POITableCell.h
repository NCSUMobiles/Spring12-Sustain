//
//  POITableCell.h
//  SeeingGreen
//
//  Created by JONATHAN B MORGAN on 4/10/12.
//  Copyright (c) 2012Jonathan B Morgan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PointOfInterest;

@interface POITableCell : UITableViewCell {
	PointOfInterest *poi;
}

@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *distanceLabel;
@property (nonatomic, strong) IBOutlet UIImageView *thumbnailImageView;
@property (nonatomic, strong) IBOutlet UIImageView *headingImageView;
@property (nonatomic, strong) IBOutlet UIImageView *topConnector;
@property (nonatomic, strong) IBOutlet UIImageView *bottomConnector;
@property (nonatomic, retain) PointOfInterest *poi;

@end
