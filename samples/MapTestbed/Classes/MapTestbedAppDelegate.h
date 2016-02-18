//
//  MapTestbedAppDelegate.h
//  MapTestbed : Diagnostic map
//

#import <UIKit/UIKit.h>
#import "RMMapView.h"

@class RootViewController;
@class RMMapContents;

@interface MapTestbedAppDelegate : NSObject <UIApplicationDelegate>
{
    UIWindow *window;
    RootViewController *rootViewController;
}

@property (nonatomic, strong) IBOutlet UIWindow *window;
@property (nonatomic, strong) IBOutlet RootViewController *rootViewController;

@end

