//
//  TutorialViewController.h
//  SeeingGreen
//
//  Created by JONATHAN B MORGAN on 5/1/12.
//  Copyright (c) 2012Jonathan B Morgan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TutorialViewController : UIViewController {
	NSArray *pages;
	short pageNumber;
}

@property (weak, nonatomic) IBOutlet UIImageView *tutorialImageView;
@end
