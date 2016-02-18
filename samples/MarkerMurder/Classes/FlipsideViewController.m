//
//  FlipsideViewController.m
//  SampleMap : Diagnostic map
//

#import "FlipsideViewController.h"
#import "MarkerMurderAppDelegate.h"
#import "MainViewController.h"
#import "RootViewController.h"

@implementation FlipsideViewController

@synthesize centerLatitude;
@synthesize centerLongitude;
@synthesize zoomLevel;
@synthesize minZoom;
@synthesize maxZoom;

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];    
}

- (void)didReceiveMemoryWarning
{
	RMLog(@"didReceiveMemoryWarning %@", self);
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (RMMapView *)mapView
{
	return [[[(MarkerMurderAppDelegate *)[[UIApplication sharedApplication] delegate] rootViewController] mainViewController] mapView];
}


- (void)viewDidAppear:(BOOL)animated
{	
    CLLocationCoordinate2D mapCenter = [[self mapView] centerCoordinate];

    [centerLatitude setText:[NSString stringWithFormat:@"%f", mapCenter.latitude]];
    [centerLongitude setText:[NSString stringWithFormat:@"%f", mapCenter.longitude]];
    [zoomLevel setText:[NSString stringWithFormat:@"%.1f", [self mapView].zoom]];
    [maxZoom setText:[NSString stringWithFormat:@"%.1f", [self mapView].maxZoom]];
    [minZoom setText:[NSString stringWithFormat:@"%.1f", [self mapView].minZoom]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    CLLocationCoordinate2D newMapCenter;

    newMapCenter.latitude = [[centerLatitude text] doubleValue];
    newMapCenter.longitude = [[centerLongitude text] doubleValue];
    [[self mapView] setCenterCoordinate:newMapCenter animated:NO];
    [[self mapView] setZoom:[[zoomLevel text] floatValue]];
    [[self mapView] setMaxZoom:[[maxZoom text] floatValue]];
    [[self mapView] setMinZoom:[[minZoom text] floatValue]];
}


- (IBAction)clearSharedNSURLCache
{
	[[NSURLCache sharedURLCache] removeAllCachedResponses];
}

- (IBAction)clearMapContentsCachedImages
{
	[[self mapView] removeAllCachedImages];
}

@end
