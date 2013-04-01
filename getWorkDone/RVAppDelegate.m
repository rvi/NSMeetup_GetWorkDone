//
//  RVAppDelegate.m
//  getWorkDone
//
//  Created by Rémy on 30/03/13.
//  Copyright (c) 2013 Rémy Virin. All rights reserved.
//

#import "RVAppDelegate.h"

#import "RVViewController.h"

#import "RVRdioManager.h"


@implementation RVAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // allocate Rdio instance
    [RVRdioManager sharedManager];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        self.viewController = [[RVViewController alloc] initWithNibName:@"RVViewController_iPhone" bundle:nil];
    } else
    {
        self.viewController = [[RVViewController alloc] initWithNibName:@"RVViewController_iPad" bundle:nil];
    }
    
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];

    return YES;
}

@end
