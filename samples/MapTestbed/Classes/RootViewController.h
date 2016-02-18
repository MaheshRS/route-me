//
//  RootViewController.h
//  MapTestbed : Diagnostic map
//

#import <UIKit/UIKit.h>

@class MainViewController;
@class FlipsideViewController;

@interface RootViewController : UIViewController
{
    UIButton *infoButton;
    MainViewController *mainViewController;
    FlipsideViewController *flipsideViewController;
    UINavigationBar *flipsideNavigationBar;
}

@property (nonatomic, strong) IBOutlet UIButton *infoButton;
@property (nonatomic, strong) MainViewController *mainViewController;
@property (nonatomic, strong) UINavigationBar *flipsideNavigationBar;
@property (nonatomic, strong) FlipsideViewController *flipsideViewController;

- (IBAction)toggleView;

@end
