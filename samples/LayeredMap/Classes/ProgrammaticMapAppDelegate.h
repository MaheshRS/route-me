//
//  ProgrammaticMapAppDelegate.h
//  ProgrammaticMap
//
//  Created by Hal Mueller on 3/25/09.
//  Copyright Route-Me Contributors 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProgrammaticMapViewController;

@interface ProgrammaticMapAppDelegate : NSObject <UIApplicationDelegate>
{
    UIWindow *window;
    ProgrammaticMapViewController *viewController;
}

@property (nonatomic, strong) IBOutlet UIWindow *window;
@property (nonatomic, strong) IBOutlet ProgrammaticMapViewController *viewController;

@end

