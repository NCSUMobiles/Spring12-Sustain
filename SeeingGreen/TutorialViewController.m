//
//  TutorialViewController.m
//  SeeingGreen
//
//  Created by JONATHAN B MORGAN on 5/1/12.
//  Copyright (c) 2012Jonathan B Morgan. All rights reserved.
//

#import "TutorialViewController.h"

@interface TutorialViewController ()

@end

@implementation TutorialViewController
@synthesize tutorialImageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	
	pageNumber++;
	
	if(pageNumber >= pages.count) {
		[self performSegueWithIdentifier:@"ExitTutorial" sender:self];
	} else {
		tutorialImageView.image = [pages objectAtIndex:pageNumber];
	}
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	
	pages = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"camera1.jpg"],
			 [UIImage imageNamed:@"camera2.jpg"],
			 [UIImage imageNamed:@"camera3.jpg"],
			 [UIImage imageNamed:@"map1.jpg"],
			 [UIImage imageNamed:@"map2.jpg"],
			 [UIImage imageNamed:@"map3.jpg"],
			 [UIImage imageNamed:@"list1.jpg"],
			 [UIImage imageNamed:@"list2.jpg"],
			 [UIImage imageNamed:@"list3.jpg"],
			 [UIImage imageNamed:@"details1.jpg"],
			 [UIImage imageNamed:@"details2.jpg"],
			 [UIImage imageNamed:@"readagain.jpg"], nil];
	pageNumber = 0;
}

- (void)viewDidUnload
{
	[self setTutorialImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
