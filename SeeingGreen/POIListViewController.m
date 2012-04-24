//
//  POIListViewController.m
//  SeeingGreen
//
//  Created by JONATHAN B MORGAN on 3/28/12.
//  Copyright (c) 2012 Team Segway Extreme. All rights reserved.
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [[[POIManager sharedPOIManager] poiArray] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	POITableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"POICell"];
	PointOfInterest *poi = [[[POIManager sharedPOIManager] poiArray] objectAtIndex:indexPath.row];

	cell.poi = poi;
	cell.nameLabel.text = poi.name;
	cell.distanceLabel.text = [NSString stringWithFormat:@"%.1f mi", [poi distanceTo]];
	cell.descriptionLabel.text = poi.description;
	if(poi.image)
		cell.thumbnailImageView.image = poi.image;

    return cell;
}

//Called when a POI button is pressed
//passes POI information to the POIDetailViewController being loaded
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	NSLog(@"%@",@"prepareForSegue");
	
	NSLog(@"%@", [[sender class] description]);
	
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
