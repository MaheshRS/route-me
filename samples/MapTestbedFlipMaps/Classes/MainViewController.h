//
//  MainViewController.h
//  MapTestbed : Diagnostic map
//

#import <UIKit/UIKit.h>

#import "RMMapView.h"

@interface MainViewController : UIViewController <RMMapViewDelegate>
{
	IBOutlet RMMapView *mapView;
	IBOutlet UITextView *infoTextView;
	IBOutlet UISegmentedControl *mapSelectControl;
}

@property (nonatomic, strong) IBOutlet RMMapView *mapView;
@property (nonatomic, strong) IBOutlet UITextView *infoTextView;

- (IBAction) mapSelectChange;

- (void)updateInfo;

@end
