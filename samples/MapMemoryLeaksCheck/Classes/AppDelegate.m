//
//  ProgrammaticMapAppDelegate.m
//  ProgrammaticMap
//
//  Created by Hal Mueller on 3/25/09.
//  Copyright Route-Me Contributors 2009. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"

@implementation AppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(UIApplication *)application
{    
    navigationController = [[UINavigationController alloc] initWithRootViewController:[[RootViewController alloc] initWithNibName:nil bundle:nil]];

    window.rootViewController = navigationController;
    [window makeKeyAndVisible];
}


@end
