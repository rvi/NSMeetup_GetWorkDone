//
//  RVViewController.m
//  getWorkDone
//
//  Created by Rémy on 30/03/13.
//  Copyright (c) 2013 Rémy Virin. All rights reserved.
//

#import "RVViewController.h"

#import "RVRdioManager.h"

@interface RVViewController ()

@end

@implementation RVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[RVRdioManager sharedManager] getTracksWithDelegate:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**************************************************************************************************/
#pragma mark - Rdio Delegate

- (void)rdioRequest:(RDAPIRequest *)request didLoadData:(id)data
{
    
}

- (void)rdioRequest:(RDAPIRequest *)request didFailWithError:(NSError *)error
{
    
}


@end
