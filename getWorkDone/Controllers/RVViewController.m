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

// API
#import "RVEchonestAPI.h"

@interface RVViewController ()

@property (nonatomic, strong) NSMutableArray *tracks;

@end

@implementation RVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tracks = [NSMutableArray array];
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
    if ([data isKindOfClass:[NSArray class]])
    {
        for (NSDictionary *dict in data)
        {
            RVTrack *track = [RVTrack trackWithDictionnary:dict];
            [self.tracks addObject:track];
            
        }
    }
    
    [RVEchonestAPI getMoreInfoForTracks:self.tracks
                              succeeded:^(RVTrack *track) {
                                  
                                  DLog(@"track : %@",track);
                                  
                              }
                                 failed:^(RVTrack *track, NSError *error) {
                                     
                                     //DLog(@"remove track : %@",track);
                                     [self.tracks removeObject:track];
                                 }];
}

- (void)rdioRequest:(RDAPIRequest *)request didFailWithError:(NSError *)error
{
    
}


@end
