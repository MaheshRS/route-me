//
//  Sample2AppDelegate.m
//  SampleMap : Diagnostic map
//

#import "MarkerMurderAppDelegate.h"
#import "RootViewController.h"
#import "MainViewController.h"

@implementation MarkerMurderAppDelegate

@synthesize window;
@synthesize rootViewController;

- (void)applicationDidFinishLaunching:(UIApplication *)application
{    
    window.rootViewController = [[MainViewController    alloc] init];
    [window makeKeyAndVisible];
}


@end
