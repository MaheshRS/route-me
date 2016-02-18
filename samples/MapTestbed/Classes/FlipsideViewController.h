//
//  FlipsideViewController.h
//  MapTestbed : Diagnostic map
//

#import <UIKit/UIKit.h>
#import "RMMapView.h"

@interface FlipsideViewController : UIViewController
{
	IBOutlet UITextField *centerLatitude;
	IBOutlet UITextField *centerLongitude;
	IBOutlet UITextField *zoomLevel;
	IBOutlet UITextField *minZoom;
	IBOutlet UITextField *maxZoom;
    RMMapView *mapView;
}

@property(nonatomic,strong) IBOutlet UITextField *centerLatitude;
@property(nonatomic,strong) IBOutlet UITextField *centerLongitude;
@property(nonatomic,strong) IBOutlet UITextField *zoomLevel;
@property(nonatomic,strong) IBOutlet UITextField *minZoom;
@property(nonatomic,strong) IBOutlet UITextField *maxZoom;

@end
