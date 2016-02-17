//
//  ProgrammaticMapViewController.m
//  ProgrammaticMap
//
//  Created by Hal Mueller on 3/25/09.
//  Copyright Route-Me Contributors 2009. All rights reserved.
//

#import "ProgrammaticMapViewController.h"
#import "RMMapView.h"

@implementation ProgrammaticMapViewController

@synthesize mapView;

- (void)viewDidLoad
{
    NSLog(@"viewDidLoad");
    [super viewDidLoad];

    CLLocationCoordinate2D firstLocation;
    firstLocation.latitude = 51.2795;
    firstLocation.longitude = 1.082;

    self.mapView = [[RMMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.adjustTilesForRetinaDisplay = NO;
    self.mapView.minZoom = 1.0f;
    [self.mapView setBackgroundColor:[UIColor greenColor]];
    [[self view] addSubview:mapView];
    [[self view] sendSubviewToBack:mapView];
}

- (void)dealloc
{
    [mapView removeFromSuperview];
}

- (void)beforeMapMove:(RMMapView *)map byUser:(BOOL)wasUserAction {
    [map removeAllCachedImages];
}

- (IBAction)doTheTest:(id)sender
{
    CLLocationCoordinate2D secondLocation;
    secondLocation.latitude = -43.50;
    secondLocation.longitude = 172.56;
    [self.mapView setCenterCoordinate:secondLocation];
}

- (IBAction)takeSnapshot:(id)sender
{
    UIImage *snapshot = [self.mapView takeSnapshot];
    [UIImagePNGRepresentation(snapshot) writeToFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"snap.png"] atomically:YES];
}

@end
