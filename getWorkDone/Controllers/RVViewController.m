//
//  RVViewController.m
//  getWorkDone
//
//  Created by Rémy on 30/03/13.
//  Copyright (c) 2013 Rémy Virin. All rights reserved.
//

#import "RVViewController.h"

// Managers
#import "RVRdioManager.h"

// Model
#import "RVTrack.h"

@interface RVViewController ()

@property (nonatomic, strong) NSArray *tracks;

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
    NSMutableArray *tmpTracks = [NSMutableArray array];
    if ([data isKindOfClass:[NSArray class]])
    {
        for (NSDictionary *dict in data)
        {
            RVTrack *track = [RVTrack trackWithDictionnary:dict];
            [tmpTracks addObject:track];
            
        }
    }
    
    self.tracks = [NSArray arrayWithArray:tmpTracks];
}

- (void)rdioRequest:(RDAPIRequest *)request didFailWithError:(NSError *)error
{
    
}


@end
