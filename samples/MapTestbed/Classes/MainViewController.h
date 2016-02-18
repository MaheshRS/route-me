//
//  MainViewController.h
//  MapTestbed : Diagnostic map
//

#import <UIKit/UIKit.h>
#import "RMMapView.h"

@interface MainViewController : UIViewController <RMMapViewDelegate>
{
	IBOutlet RMMapView * mapView;
	IBOutlet UITextView * infoTextView;
}

@property (nonatomic, strong) IBOutlet RMMapView *mapView;
@property (nonatomic, strong) IBOutlet UITextView *infoTextView;

- (void)updateInfo;

@end
