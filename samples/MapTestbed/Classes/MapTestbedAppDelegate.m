//
//  MapTestbedAppDelegate.m
//  MapTestbed : Diagnostic map
//

#import "MapTestbedAppDelegate.h"
#import "RootViewController.h"
#import "MainViewController.h"

#import "RMAnnotation.h"

@implementation MapTestbedAppDelegate

@synthesize window;
@synthesize rootViewController;

- (RMMapView *)mapView
{
    return [[[(MapTestbedAppDelegate *)[[UIApplication sharedApplication] delegate] rootViewController] mainViewController] mapView];
}

-(void)performTestPart2
{
	CLLocationCoordinate2D pt;
	pt.latitude = 48.86600492029781f;
	pt.longitude = 2.3194026947021484f;

	[[self mapView] setCenterCoordinate:pt animated:NO];
}

-(void)performTestPart3
{
	// path returns to correct position after this zoom
	CLLocationCoordinate2D northeast, southwest;
	northeast.latitude = 48.885875363989435f;
	northeast.longitude = 2.338285446166992f;
	southwest.latitude = 48.860406466081656f;
	southwest.longitude = 2.2885894775390625;

	[[self mapView] zoomWithLatitudeLongitudeBoundsSouthWest:southwest northEast:northeast animated:NO];
}	

- (void)performTest
{
	NSLog(@"testing paths");
    RMMapView *mapView = [self mapView];

	UIImage *xMarkerImage = [UIImage imageNamed:@"marker-X.png"];

	// if we zoom with bounds after the paths are created, nothing is displayed on the map
	CLLocationCoordinate2D northeast = CLLocationCoordinate2DMake(48.885875363989435f, 2.338285446166992f),
                           southwest = CLLocationCoordinate2DMake(48.860406466081656f, 2.2885894775390625);

	[mapView zoomWithLatitudeLongitudeBoundsSouthWest:southwest northEast:northeast animated:NO];

    NSArray *linePoints = [NSArray arrayWithObjects:
                           [[CLLocation alloc] initWithLatitude:48.884238608729035f longitude:2.297086715698242f],
                           [[CLLocation alloc] initWithLatitude:48.878481319827735f longitude:2.294340133666992f],
                           [[CLLocation alloc] initWithLatitude:48.87351371451778f longitude:2.2948551177978516f],
                           [[CLLocation alloc] initWithLatitude:48.86600492029781f longitude:2.3194026947021484f],
                           nil];

	// draw a green path south down an avenue and southeast on Champs-Elysees
    RMAnnotation *pathAnnotation = [RMAnnotation annotationWithMapView:mapView coordinate:((CLLocation *)[linePoints objectAtIndex:0]).coordinate andTitle:nil];
    pathAnnotation.annotationType = @"path";
    pathAnnotation.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                               linePoints,@"linePoints",
                               [UIColor greenColor],@"lineColor",
                               [UIColor clearColor],@"fillColor",
                               [NSNumber numberWithFloat:20.0f],@"lineWidth",
                               nil];
    [pathAnnotation setBoundingBoxFromLocations:linePoints];
    [mapView addAnnotation:pathAnnotation];

    for (NSUInteger i=0; i<[linePoints count]; ++i)
    {
        CLLocation *currentLocation = [linePoints objectAtIndex:i];

        RMAnnotation *markerAnnotation = [RMAnnotation annotationWithMapView:mapView coordinate:currentLocation.coordinate andTitle:[NSString stringWithFormat:@"R %lu", i+1]];
        markerAnnotation.annotationType = @"marker";
        markerAnnotation.annotationIcon = xMarkerImage;
        markerAnnotation.anchorPoint = CGPointMake(0.5, 1.0);
        [mapView addAnnotation:markerAnnotation];
    }

    linePoints = [NSArray arrayWithObjects:
                  [[CLLocation alloc] initWithLatitude:48.86637615203047f longitude:2.3236513137817383f],
                  [[CLLocation alloc] initWithLatitude:48.86372241857954f longitude:2.321462631225586f],
                  [[CLLocation alloc] initWithLatitude:48.86087090984738f longitude:2.330174446105957f],
                  [[CLLocation alloc] initWithLatitude:48.86369418661614f longitude:2.332019805908203f],
                  nil];

    pathAnnotation = [RMAnnotation annotationWithMapView:mapView coordinate:((CLLocation *)[linePoints objectAtIndex:0]).coordinate andTitle:nil];
    pathAnnotation.annotationType = @"path";
    pathAnnotation.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                               linePoints,@"linePoints",
                               [UIColor blueColor],@"lineColor",
                               [UIColor colorWithRed:0.1 green:0.1 blue:0.8 alpha:0.5],@"fillColor",
                               [NSNumber numberWithFloat:10.0f],@"lineWidth",
                               [NSNumber numberWithBool:YES],@"closePath",
                               nil];
    [pathAnnotation setBoundingBoxFromLocations:linePoints];
    [mapView addAnnotation:pathAnnotation];

    for (NSUInteger i=0; i<[linePoints count]; ++i)
    {
        CLLocation *currentLocation = [linePoints objectAtIndex:i];

        RMAnnotation *markerAnnotation = [RMAnnotation annotationWithMapView:mapView coordinate:currentLocation.coordinate andTitle:[NSString stringWithFormat:@"S %lu", i+1]];
        markerAnnotation.annotationType = @"marker";
        markerAnnotation.annotationIcon = xMarkerImage;
        markerAnnotation.anchorPoint = CGPointMake(0.5, 0.5);
        [mapView addAnnotation:markerAnnotation];
    }

//	[self performSelector:@selector(performTestPart2) withObject:nil afterDelay:3.0f];
//	[self performSelector:@selector(performTestPart3) withObject:nil afterDelay:7.0f];
}

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
    [window addSubview:[rootViewController view]];
    [window makeKeyAndVisible];

	[self performSelector:@selector(performTest) withObject:nil afterDelay:0.25f];
}


@end
