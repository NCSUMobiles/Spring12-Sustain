//
//  POIManager.m
//  SeeingGreen
//
//  Created by JONATHAN B MORGAN on 4/4/12.
//  Copyright (c) 2012Jonathan B Morgan. All rights reserved.
//

#import "POIManager.h"

#define DEFAULT_BUTTON_HEIGHT 56
#define DEFAULT_BUTTON_WIDTH 256

@implementation POIManager

@synthesize poiArray, currentTarget;

static POIManager *_sharedPOIManager = nil;

//returns the singleton instance of the class or creates one if one does not exist
+(POIManager *) sharedPOIManager {
	if(!_sharedPOIManager)
		_sharedPOIManager = [[self alloc] init];
	return _sharedPOIManager;
}

-(id) init {
	if(self = [super init]) {
		poiArray = [[NSMutableArray alloc] initWithCapacity:30];
		
		//Add POIs for the walking tour
		//This really needs to be coming from CoreData (ok) or a web service (ideal)
		//I'm not making the formatting on this prettier/usable because hopefully this won't be hard coded forever.
		[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.773605 longitude:-78.640831 name:@"Raleigh Convention Center" address:@"500 E. Salisbury Street" description:@"Raleigh Convention Center is one of only two LEED® Silver Certified new construction convention centers in the United States. Sustainability features include rainwater harvesting systems, recycled paper products, light dimming systems, restroom occupancy light sensors, perimeter parking Light Emitting Diodes (LEDs), and low-flow toilets and faucets. The exhibit hall connects to a 100% LED-lit underground parking deck.A 500-kilowatt (KW) roof-top solar photovoltaic (PV) array is under construction." andImageURL:@"http://www.raleighnc.gov/content/AdminServSustain/Images/SusTour1.jpg"]];
		[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.773609 longitude:-78.640541 name:@"R-Line Hybrid Electric Bus" address:@"" description:@"These hybrid electric buses connect riders to restaurants, retail, entertainment venues,museums, hotels, and parking facilities in downtown Raleigh. Cost: FREE. (919) 485-RIDE. View a real-time bus schedule." andImageURL:@"http://www.raleighnc.gov/content/AdminServSustain/Images/SusTour2.jpg"]];
		[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.773132 longitude:-78.640602 name:@"Big Belly Solar Trash Compactor" address:@"" description:@"Big Belly compactors are powered by solar energy and hold 4x as much trash as regular containers. \"Smart\" technology transmits a message to City of Raleigh Solid Waste Services when the compactor is full. Fewer trash truck pick-ups mean less wear on the road, reduced fuel use and reduced carbon emissions. 20 Big Belly solar trash compactors will be installed in the Glenwood South district later this year." andImageURL:@"http://www.raleighnc.gov/content/AdminServSustain/Images/SusTour3.jpg"]];
		[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.772404 longitude:-78.640617 name:@"Solar EV Charging Stations" address:@"614 S. Salisbury St." description:@"Level I & Level II electric vehicle (EV) charging stations with integrated solarphotovoltaic cell equipment and battery storage capability. The solar stations are connected to the grid so extra energy can be sold back to Progress Energy. The two solar panels are a 2.88 kilowatt (KW) array combined, and are from different manufacturers to allow direct comparison of panel production. This is an example of a private/public partnership." andImageURL:@"http://www.raleighnc.gov/content/AdminServSustain/Images/DowntownSustPhotos/SolarEVChargingStations.jpg"]];
		[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.771580 longitude:-78.639587 name:@"Progress Energy Center" address:@"2 E. South Street" description:@"Progress Energy Center for the Peforming Arts is an example of building re-use; originally a Depression-era arena for basketball games, etc. The glass lobby was added in the 1980s. Both wings with 3 theaters were added in the 1990s. Other sustainability features: Light Emitting Diodes (LED), occupancy sensor lights, \"Green Certified\" cleaning products, low-flow toilet and faucets, and low emissions carpets." andImageURL:@"http://www.raleighnc.gov/content/AdminServSustain/Images/DowntownSustPhotos/ProgressCtrForPerformingArts.jpg"]];
		[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.771572 longitude:-78.638351 name:@"Shaw University" address:@"118 E. South Street" description:@"Founded 1865; first historically Black college of the South. Shaw Universityis a private liberal arts college that awards degrees at both the undergraduate and graduate levels. Two university buildings are listed in the National Registry of Historic Places: Estey Hall, erected in 1873 as the nation's first dormitoryto house women on a coeducational campus; and the Leonard School of Medicine, founded in 1885. In the realm of sustainability, Shaw University is an example of building reuse and integration of education into downtown economic development." andImageURL:@"http://www.raleighnc.gov/content/AdminServSustain/Images/SusTour6.jpg"]];
		[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.773933 longitude:-78.639587 name:@"Marriott Hotel" address:@"500 Fayetteville Street" description:@"This Marriott Hotel is an example of local business embracing sustainability concepts. Features include paperless check-in and check-out, recycle bins, water conservation methods, low-flow toilets and faucets, and occupancy sensor lights in administrative areas. Underneath is a City-owned 100% LED-lit parking deck with an EV charging station.  The deck connects to the Raleigh Convention Center." andImageURL:@"http://www.raleighnc.gov/content/AdminServSustain/Images/SusTour7.jpg"]];
		[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.774502 longitude:-78.639595 name:@"LED (Ornamental) Light Towers" address:@"Fayetteville Street Plaza" description:@"These Light Towers are public art pieces that include Light Emitting Diodes (LED) lights, which use less energy and are lower cost to the City. At night, the multi-colored LED lights add excitement, fun and dimension to City Plaza." andImageURL:@"http://www.raleighnc.gov/content/AdminServSustain/Images/DowntownSustPhotos/OrnamentalLightTowers.jpg"]];
		[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.775085 longitude:-78.639587 name:@"Downtown Raleigh Farmer's Market" address:@"400 Block of Fayetteville Street" description:@"The Downtown Raleigh Farmers Market operates each Wednesday, April through October, in City Plaza from 10am until 2pm. The market, organized by the Downtown Raleigh Alliance, features local farmers, ranchers, bakers, artists and specialty food producers. These are examples of the sustainability concepts of promoting and using local produce and resources, as well as providing local access to healthy nutrition." andImageURL:@"http://www.raleighnc.gov/content/AdminServSustain/Images/DowntownSustPhotos/FarmersMktStrawberries.jpg"]];
		[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.775219 longitude:-78.639244 name:@"Progress Energy" address:@"Fayetteville Street toward Davie Street" description:@"This local electricity provider was the catalyst for much of the downtown Raleigh redevelopment and economic revitalization.  The company committed to construction of its corporate headquarters in downtown Raleigh if the City undertook a major infrastructure overhaul like the reopening of Fayetteville Street. Additional ventures led to Red Hat, Inc., the world's leading provider of open source technology, moving its global headquarters to downtown Raleigh at 100 E. Davie Street. The resulting influx of business, commerce, major events and visitors to downtown Raleigh are examples of sustainability concepts of public/private partnerships and economic development." andImageURL:@"http://www.raleighnc.gov/content/AdminServSustain/Images/SusTour10a.jpg"]];
		[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.775372 longitude:-78.639549 name:@"Sir Walter Raleigh Hotel" address:@"400-412 Fayetteville Street" description:@"This 10-story Neoclassical Revival building dates back to 1924. It was long a center of Raleigh's social scene and was once known as the \"Third House of the Legislature\" because so many legislators gathered there. The hotel was renovated as apartments for the elderly in the late 1970s. These are examples of the sustainability concepts of building reuse and social equity." andImageURL:@"http://www.raleighnc.gov/content/AdminServSustain/Images/SirWalterHotel2_2012.jpg"]];
		[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.776886 longitude:-78.639389 name:@"NC 10% Campaign" address:@"" description:@"Look for this \"NC 10% Campaign\" sign in restaurants throughout your visit. It designates North Carolina restaurants, businesses and individuals that have pledged to spend 10% of their food dollars on locally grown food." andImageURL:@"http://www.raleighnc.gov/content/AdminServSustain/Images/NC10percent.png"]];
		[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.777649 longitude:-78.639374 name:@"Briggs Hardware Building" address:@"220 Fayetteville Street" description:@"The Briggs Hardware Building is a designated Raleigh Historic Landmark. Constructed in 1874, it is downtown Raleigh's only 19th century commercial building that survives essentially unaltered since its construction.  The four story masonry building was the city's first skyscraper. Today, the building is home to Raleigh City Museum, the only home and educational center for artifacts of the city and its people. These are examples of sustainability concepts of building reuse and integration of education." andImageURL:@"http://www.raleighnc.gov/content/AdminServSustain/Images/BriggsHardware.jpg"]];
		[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.780204 longitude:-78.639214 name:@"North Carolina State Capitol" address:@"1 E. Edenton Street" description:@"The North Carolina State Capitol building was completed in 1840 and is Greek Revival architecture style. Sustainability concepts of utilizing local resources and local labor were used in the construction of the building. The exterior walls are built of gneiss, a form of granite. The stone was locally quarried in southeastern Raleigh and hauled to the site on the horse-drawn Experimental Railroad, North Carolina's first railway. Today, the governor, the lieutenant governor and their immediate staff occupy offices on the first floor of the Capitol. This is an example of the sustainability practice of building reuse." andImageURL:@"http://www.raleighnc.gov/content/AdminServSustain/Images/DowntownSustPhotos/CapitolBldgSouthView.png"]];
		[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.782520 longitude:-78.640129 name:@"Green Square" address:@"" description:@"A 2-block, multi-use, sustainable, LEED® Gold Certified development; a cooperative venture with N.C. Dept. of Environment & Natural Resources and the State Employees Credit Union." andImageURL:@"http://northstatesteel.com/wp-content/themes/northstatesteel/news_images/NRC_1.jpg"]]; //image link being used w/o permission. whoops.
		[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.782562 longitude:-78.641052 name:@"NC Museum of Natural Sciences" address:@"11 W. Jones Street" description:@"The centerpiece of Green Square is a major expansion of the NC Museum of Natural Sciences. It features the Daily Planet, a 3-story high-definition multimedia space that displays ongoing nature research from across every continent." andImageURL:@"http://www.raleighnc.gov/content/AdminServSustain/Images/SusTour13a.jpg"]];
		[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.782604 longitude:-78.642609 name:@"The Dept. of Environment & Natural Resources" address:@"217 W. Jones Street" description:@"The N.C. Dept. of Environment & Natural Resources (DENR) headquarters and the Daily Planet, both part of Green Square, feature solar energy, daylighting, LED-lit parking deck, urban stormwater management, cisterns to capture rainwater, low emissions paint & carpentry, and locally produced building materials. " andImageURL:@"http://www.raleighnc.gov/content/AdminServSustain/Images/DowntownSustPhotos/DENRBldg.jpg"]];
		[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.780861 longitude:-78.643600 name:@"Solar panel LED street lights" address:@"Corner of Dawson & Morgan Streets" description:@"These City-owned solar panel LED street lights are  temporary fixtures in the parking lot leased to Campbell University Law School. The solar LEDs (light emitting diodes) were installed to avoid underground infrastructure costs.  Since the LEDs are not connected to the grid, they can be easily moved elsewhere when the property is redeveloped." andImageURL:@"http://www.raleighnc.gov/content/AdminServSustain/Images/SolarLEDlights2_2012.jpg"]];
		[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.779316 longitude:-78.643059 name:@"Raleigh Municipal Bldg. Parking Deck" address:@"Dawson St. between Morgan & Hargett" description:@"The 2nd level of the deck features LED lighting.  It is the City's LED pilot project in partnership with Cree, Inc. of Research Triangle Park and was completed January 2007.  This is one of the first installations of LED lights, launching City of Raleigh's role as \"First LED City in the World.\"  LEDs are less expensive, brighter, and safer despite casting about 11% less lumens. The deck also features two wall-mount Level II electric vehicle charging stations." andImageURL:@"http://www.raleighnc.gov/content/AdminServSustain/Images/DowntownSustPhotos/RMBParkingDeck.jpg"]];
		[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.778362 longitude:-78.643295 name:@"2 EV Plug-in Charging Stations" address:@"285 W. Hargett Street" description:@"These are the first two electric vehicle charging stations installed by the City of Raleigh; they are Level II. As with all City installed EV charging stations, patrons pay to park but charge for free." andImageURL:@"http://www.raleighnc.gov/content/AdminServSustain/Images/DowntownSustPhotos/TeslaAtChargingStation.jpg"]];
		[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.777760 longitude:-78.642609 name:@"Nash Square Park" address:@"" description:@"One of five open spaces designed in 1792 as part of the original layout of the State Capitol City. Two spaces remain as parks (Nash Square and Moore Square) without buildings. The current landscape design dates back to 1940. Nash Square Park is an example of sustainability concepts of protecting and maintenance of greenways and open spaces." andImageURL:@"http://www.raleighnc.gov/content/AdminServSustain/Images/DowntownSustPhotos/NashSquare.png"]];
		[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.776733 longitude:-78.641754 name:@"Wake County Justice Center" address:@"Corner of Martin & McDowell Streets" description:@"Wake Co. Justice Center is LEED® certification pending.  It is built with erosion control practices, basic pollution prevention, water efficiency, refrigerant management, storage and collection of recyclables, improved indoor air quality, safer building construction materials and products, use of natural daylight, recycled storm water for irrigation, bike racks and digitally controlled thermostats." andImageURL:@"http://www.raleighnc.gov/content/AdminServSustain/Images/SusTour18.jpg"]];
		[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.774624 longitude:-78.642143 name:@"Poole's Diner" address:@"426 S. McDowell Street" description:@"Although recently renovated, Poole's opened in 1945 and still maintains its \"retro-chic charm\" with original double horseshoe bar and red leather banquettes. Seasonal produce from local growers dictates nearly everything on the menu. These are examples of the sustainability practices of building reuse and using local produce." andImageURL:@"http://www.raleighnc.gov/content/AdminServSustain/Images/DowntownSustPhotos/PoolesRestaurant.jpg"]];
		[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.774284 longitude:-78.642281 name:@"EV charging station" address:@"Corner of McDowell & Cabarrus Street" description:@"Located on the southwest corner, this City installed Level II station allows patrons to charge electric vehicles for free. However, they must pay to park." andImageURL:@"http://www.raleighnc.gov/content/AdminServSustain/Images/SusTour20.jpg"]];
		[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.773628 longitude:-78.641808 name:@"Cree Shimmer Wall" address:@"West side of Raleigh Convention Ctr on McDowell Street" description:@"Cree Shimmer Wall is an example of a public/private partnership with a focus on art. The 9,284-square-foot art wall depicts an oak tree in homage to Raleigh's \"City of Oaks\" designation for its many oak trees. The wall is made up of 79,464 light and dark aluminum squared powered by wind.  The 56 LED fixtures flash and display the design in multiple colors." andImageURL:@"http://www.raleighnc.gov/content/AdminServSustain/Images/SusTour21.jpg"]];
		[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.773239 longitude:-78.642334 name:@"Raleigh Amphitheater" address:@"500 S. McDowell Street" description:@"Raleigh Amphitheater was built on a brownfield redevelopment site.  Other sustainability features include LED lights, concrete used instead of asphalt to reflect the sun, 60% of trash recycled, green friendly cleaning products, and use of recycled products." andImageURL:@"http://www.raleighnc.gov/content/AdminServSustain/Images/DowntownSustPhotos/RaleighAmphitheater.jpg"]];
		[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.772694 longitude:-78.641685 name:@"Performing Arts Parking Deck" address:@"Lenoir & McDowell Streets" description:@"Located on the right side of the street, this City-owned parking deck features a Level II Electric Vehicle charging station. Patrons charge for free, but must pay to park." andImageURL:@"http://www.raleighnc.gov/content/AdminServSustain/Images/DowntownSustPhotos/LenoirDeckChargingStation.jpg"]];
		[poiArray addObject:[[PointOfInterest alloc] initWithLatitude:35.773041 longitude:-78.641212 name:@"Permeable Pavement" address:@"Lenoir Street side of Convention Ctr." description:@"These concrete squares allow the capture of stormwater so that it can seep into the ground. This process reduces stormwater run-off and recharges groundwater." andImageURL:@"http://www.raleighnc.gov/content/AdminServSustain/Images/DowntownSustPhotos/PerviousPavement.jpg"]];
		
		currentTarget = [poiArray objectAtIndex:0];
	}
	
	for(int i = 0; i < poiArray.count; i++) {
		PointOfInterest *poi = [poiArray objectAtIndex:i];
		poi.index = i;
		poi.detailImage = [UIImage imageNamed:[NSString stringWithFormat:@"%i_detail.jpg", i]];
		poi.thumbnailImage = [UIImage imageNamed:[NSString stringWithFormat:@"%i_thumbnail.png", i]];
		poi.listImage = [UIImage imageNamed:[NSString stringWithFormat:@"%i_list.png", i]];
	}
	
	return self;
}

//creates a button for each POI to be displayed in the AR View Controller
-(void)createButtonsInViewController:(UIViewController *)viewController {
	//add a UIButton for each POI
	for(PointOfInterest *poi in [[POIManager sharedPOIManager] poiArray]) {
		
		if(!poi.button) {
			UIButton *poiButton = [UIButton buttonWithType:UIButtonTypeCustom];
			[poiButton addTarget:viewController 
						  action:@selector(poiButtonTouched:)
				forControlEvents:UIControlEventTouchUpInside];
			[poiButton setImage:[UIImage imageNamed:@"poiButtonBackground"] forState:UIControlStateNormal];
			
			//frame the title such that it lives in the empty part of the button image
			[poiButton setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -206.0, 0.0, 33.0)];
			[poiButton setTitle:[poi name] forState:UIControlStateNormal];
			[poiButton.titleLabel setTextAlignment:UITextAlignmentLeft];
			[poiButton.titleLabel setAdjustsFontSizeToFitWidth:TRUE];
			[poiButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
			[poiButton setTitleShadowColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
			poiButton.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
			
			poiButton.frame = CGRectMake(-1000, 240, DEFAULT_BUTTON_WIDTH, DEFAULT_BUTTON_HEIGHT);
			
			
			UIImageView *thumbnailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 9, 34, 34)];
			[thumbnailImageView setContentMode:UIViewContentModeScaleAspectFill];
			[thumbnailImageView setClipsToBounds:TRUE];
			[poiButton addSubview:thumbnailImageView];
			
			thumbnailImageView.image = poi.thumbnailImage;
			
			[poi setButton:poiButton];
		}
		
		[[viewController view] addSubview:poi.button];
		
		//add the POI's dot while we're here
		[[viewController view] addSubview:poi.poiDot];
	}
}

//get the POI with the given button
-(PointOfInterest *)getPOIWithButton:(UIButton *)button {
	for(PointOfInterest *poi in poiArray)
		if(poi.button == button)
			return poi;
	return nil;
}

//set the current target POI to the poi with the given button
-(void)setTargetWithButton:(UIButton *)button {
	currentTarget = [self getPOIWithButton:button];
}

//returns an array of POIs sorted by distance from the user in ascending order 
-(NSArray *)sortedByDistance {
	NSArray *sortedArray;
	sortedArray = [poiArray sortedArrayUsingComparator:^(id a, id b) {
		NSNumber *first = [[LocationServicesManager sharedLSM] distanceToPOI:(PointOfInterest*)a];
		NSNumber *second = [[LocationServicesManager sharedLSM] distanceToPOI:(PointOfInterest*)b];
		return [first compare:second];
	}];
	return sortedArray;
}

//returns an array of POIs sorted by compass heading from the user in ascending order 
-(NSArray *)sortedByHeading {
	NSArray *sortedArray;
	sortedArray = [poiArray sortedArrayUsingComparator:^(id a, id b) {
		NSNumber *first = [[LocationServicesManager sharedLSM] headingToPOIInDegrees:(PointOfInterest*)a];
		NSNumber *second = [[LocationServicesManager sharedLSM] headingToPOIInDegrees:(PointOfInterest*)b];
		return [first compare:second];
	}];
	return sortedArray;
}
@end
