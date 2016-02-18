//
//  FlipsideViewController.h
//  SampleMap : Diagnostic map
//

#import <UIKit/UIKit.h>
#import "RMMapView.h"

@interface FlipsideViewController : UIViewController

@property(nonatomic,strong) IBOutlet UITextField *centerLatitude;
@property(nonatomic,strong) IBOutlet UITextField *centerLongitude;
@property(nonatomic,strong) IBOutlet UITextField *zoomLevel;
@property(nonatomic,strong) IBOutlet UITextField *minZoom;
@property(nonatomic,strong) IBOutlet UITextField *maxZoom;

- (IBAction)clearSharedNSURLCache;
- (IBAction)clearMapContentsCachedImages;

@end
