# Seeing Green
Seeing Green is a augmented reality walking tour of the sustainability features in downtown Raleigh, NC.  More information can be found about the walking tour at the [Raleigh Sustainability Walking Tour Website](http://www.raleighnc.gov/news/content/CorNews/Articles/SustainabilityWalkingTour.html).

## Features
1.  Seeing Green's main view is an augmented reality viewer which displays overlays on the camera feed with the names of points of interest (POIs) in downtown Raleigh, NC.  There is also a "radar" view in the upper-right corner of the screen which displays a top-down display of the positions of POIs relative to the user within a certain distance (currently .2 miles). Tapping the overlay for a POI loads a second view (feature 2). There are also buttons to load a list of all POIs (feature 3), a map of POIs (feature 4), and a brief tutorial (feature 5).
2.  Tapping the overlay for a POI loads a view containing the name, address, description, and a picture of the POI. The user can tap a button labeled "Map it!" to load walking directions to the POI in the Maps app.
3.  A list of the POIs for the walking tour is displayed in order. The list displays the name, description, and distance to each POI. Clicking on a POI in the list loads the POI detail view (2).
4.  A map is displayed which displays a the user's location and pins at the location of each POI. Tapping a pin displays the name and address of the POI selected.
5.  Tapping the info button displays a short tutorial explaining how the app is used.  An alert is displayed the first time the app is run to ask the user if they want to see the tutorial as well.

## To do
1.  Loading the map view can take a bit and freezes the UI. Find out if this can be done async.
2.  Change tutorial to a PageViewController rather than a series of UIImages.
