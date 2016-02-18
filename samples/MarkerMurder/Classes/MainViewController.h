//
//  MainViewController.h
//  SampleMap : Diagnostic map
//

#import <UIKit/UIKit.h>
#import "RMMapView.h"

@interface MainViewController : UIViewController <RMMapViewDelegate>

@property (nonatomic, strong) IBOutlet RMMapView *mapView;
@property (nonatomic, strong) IBOutlet UITextView *infoTextView;
@property (nonatomic, strong) IBOutlet UILabel *mppLabel;
@property (nonatomic, strong) IBOutlet UIImageView *mppImage;

- (void)updateInfo;

@end
