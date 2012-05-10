//
//  POIListViewController.m
//  SeeingGreen
//
//  Created by JONATHAN B MORGAN on 3/28/12.
//  Copyright (c) 2012 Jonathan B Morgan. All rights reserved.
//

#import "POIListViewController.h"
#import "POIManager.h"
#import "PointOfInterest.h"
#import "POITableCell.h"
#import "POIDetailViewController.h"

@interface POIListViewController ()

@end

@implementation POIListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		selectedPOI = nil;
	}
    return self;
}

//the POI list currently only has one section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

//returns the number of rows, i.e. the number of POIs
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [[[POIManager sharedPOIManager] poiArray] count];
}

//loads each POI into a cell in the order that they are returned from the POIManager
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	POITableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"POICell"];
	PointOfInterest *poi = [[[POIManager sharedPOIManager] poiArray] objectAtIndex:indexPath.row];

	cell.poi = poi;
	cell.nameLabel.text = poi.name;
	cell.distanceLabel.text = [NSString stringWithFormat:@"%.1f mi", [poi distanceTo]];
	cell.headingImageView.autoresizingMask = UIViewAutoresizingNone;	//prevents the rotation transform from making the heading deformed

	cell.headingImageView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS * [poi userHeadingTo]);
	
	
	if(indexPath.row == 0) {
		[cell.topConnector setHidden:TRUE];
	} else if(indexPath.row == [[[POIManager sharedPOIManager] poiArray] count] - 1) {
		[cell.bottomConnector setHidden:TRUE];
	} else {
		[cell.topConnector setHidden:FALSE];
		[cell.bottomConnector setHidden:FALSE];
	}
	
	if(poi.listImage)
		cell.thumbnailImageView.image = poi.listImage;

	if(poi == [[POIManager sharedPOIManager] closestPOI])
		cell.closestLabel.hidden = NO;
	else
		cell.closestLabel.hidden = YES;

    return cell;
}

//Called when a POI button is pressed
//passes POI information to the POIDetailViewController being loaded
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	POITableCell *selectedCell = (POITableCell *)sender;
	 
    if ([[segue identifier] isEqualToString:@"ShowPOIDetails"]) {
        POIDetailViewController *detailViewController = (POIDetailViewController *)[[segue destinationViewController] visibleViewController];
		PointOfInterest *poi = selectedCell.poi;
		detailViewController.poi = poi;
		detailViewController.name = poi.name;
		detailViewController.address = poi.address;
		detailViewController.description = poi.description;
		detailViewController.imageURL = poi.imageURL;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
