# Seeing Green
Seeing Green is a augmented reality walking tour of the sustainability features in downtown Raleigh, NC.  More information can be found about the walking tour at the [Raleigh Sustainability Walking Tour Website](http://www.raleighnc.gov/news/content/CorNews/Articles/SustainabilityWalkingTour.html).

## To do:
1.  The data is currently hardcoded into the app. This needs to be pulled from a JSON data service (service and data processing have not been started on).
2.  Support needs to be added to walk through the tour in order.
3.  The list view of the POIs needs to look better.
4.  The interface as a whole needs significant work.
5.  Async data loading of images needs to be moved to the PointOfInterest class.
6.  Images and compass headings need to be added to the list view.
7.  Clicking an entry in the list view should go to that POI's detail view.
8.  The detail view needs to be prettied up a bit (different background, for starters).
9.  Loading the map view can take a bit and freezes the UI. Find out if this can be done async.
10. POI buttons should only show up within the same distance as blips on the radar.
11. POI buttons should be transparent in proportion to their distance from the user.