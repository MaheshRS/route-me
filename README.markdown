Route-Me: iOS map library 
-----------------------------------------

Route-Me is an open source map library that runs natively on iOS.  It's designed to look and feel much like the built-in iOS map library, but it's entirely open, and works with any map source.

Currently, [OpenStreetMap][1], [OpenCycleMap][2], [OpenSeaMap][3], [MapQuest OSM][4], [MapQuest Open Aerial][5] and an offline, database-backed format called DBMap are supported as map sources.

Please note that you are responsible for getting permission to use the map data, and for ensuring your use adheres to the relevant terms of use.

   [1]: http://www.openstreetmap.org/index.html
   [2]: http://www.opencyclemap.org/
   [3]: http://www.openseamap.org/
   [4]: http://developer.mapquest.com/web/products/open/map
   [5]: http://developer.mapquest.com/web/products/open/map

Installation
------------

Clone a copy of the repository:

      https://github.com/MaheshRS/route-me.git

 Then, update the submodules:

      git submodule update --init

 After this, copy or alias all the resources in the MapView/Map/Resources folder to your project.

 *OR*

Add MapView.frame, copy or alias all the resources the MapView/Map/Resources folder to the project. 

See the 'samples' subdirectory for usage examples.

There are three subdirectories - MapView, Proj4, and samples. Proj4 is a support class used to do map projections. The MapView project contains only the route-me map library. "samples" contains some ready-to-build projects which you may use as starting points for your own applications, and also some engineering test cases. `samples/MarkerMurder` and `samples/ProgrammaticMap` are the best places to look, to see how to embed a Route-Me map in your application.

See License.txt for license details. In any app that uses the Route-Me library, include the following text on your "preferences" or "about" screen: "Uses Route-Me map library, (c) 2008-2013 Route-Me Contributors". Your data provider will have additional attribution requirements.

Integration Guide
-----------------
Once you have created a new iOS application, we will setup the Route-Me MapView as a subproject. The Header Search Paths and Link Binaries are the most important steps.

* Clone the [Repo][6] into a directory inside your project.
* Add the route-me/MapView/MapView.xcodeproj into your project.
* In your Project Settings, click the application target > Build Settings > Enter `Header` into the Search Box, and add vendor/route-me/MapView/Map to the `Header Search Paths` key
* Build Settings > Under `Other Linker Flags` > Add `-all_load` `-ObjC` `-lsqlite3`
* Go to Build Phases > Target Dependencies > Click +, Choose MapView > MapView
* Go to Build Phases > Link Binaries > For each of the following libraries, Click +, select the binary, and then click Add: `libMapView.a`, `CoreLocation.framework`, `QuartzCore.framework`, `Foundation.framework`, `UIKit.framework`, `CoreGraphics.framework`, `CoreFoundation.framework`
* In your Project Settings, select Build Settings and in Build Active Architecture Only select `YES` for `debug` and `NO` for `release`
* Add `App Transport Security Settings` to the project. 
   
[6]: https://github.com/MaheshRS/route-me.git   

Support and Contributing
------------------------------
To help fix bugs, please use [pull requests] and [tracker]

[pull requests]: https://github.com/MaheshRS/route-me/pulls
[tracker]: https://github.com/MaheshRS/route-me/issues


Major changes in this fork (MaheshRS/route-me)
----------------------------------------------
* Requires at least iOS 4.0 and Xcode 7.0
* Supports Automatic Reference Counting (ARC).
* Proj4 is now merged with MapView as a depedency. No need to compile the Proj4 library separately.
* Supports $(ARCHS_STANDARD) Architectures.


Major changes in the fork (Alpstein/route-me)
----------------------------------------------
* RMMapView and RMMapContents have been merged into one file
* The map uses an UIScrollView with a CATiledLayer for better performance
* Tile cache refactoring
* Tile source refactoring
* Support for tile sources with multiple layers (e.g. OpenSeaMap)
* Support for multiple tile sources on the map
* Numerous performance improvements
* Markers have been refactored into a MKMapView-like system, with annotations and on-demand markers
* Automatic annotation clustering
* Snapshots from the map
* Requires at least iOS 4.0 and Xcode 4.3


Dependent Libraries
-------------------

Route-Me makes use of several sub-libraries, listed below. See License.txt for more detailed information about Route-Me and Proj4 and see the individual license files in the sub-libraries for more information on each. 

 * [FMDB](https://github.com/MaheshRS/fmdb) Gus Mueller fork (SQLite for caching and MBTiles)
 * [SMCalloutView](https://github.com/MaheshRS/calloutview.git) Nick Farina fork  (annotation callouts)
 
 
![Shot 1](https://github.com/MaheshRS/route-me/blob/5a2812dcf2ff1422cbd9a9acccde4d031ae4fc2e/Screen%20Shots/Screen1.png)

![Shot 2](https://github.com/MaheshRS/route-me/blob/5a2812dcf2ff1422cbd9a9acccde4d031ae4fc2e/Screen%20Shots/Screen2.png)

![Shot 3](https://github.com/MaheshRS/route-me/blob/5a2812dcf2ff1422cbd9a9acccde4d031ae4fc2e/Screen%20Shots/Screen3.png)

