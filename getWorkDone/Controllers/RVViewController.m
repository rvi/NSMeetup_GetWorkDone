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
{
    RVTrack *currentlyPlayed;
}

@property (nonatomic, strong) NSMutableArray *tracks;
@property (nonatomic, strong) RVTrack *currentlyPlayed;

@end

@implementation RVViewController

/**************************************************************************************************/
#pragma mark - Getters & Setters

-(void)setCurrentlyPlayed:(RVTrack *)inCurrentlyPlayed
{
    if (currentlyPlayed != inCurrentlyPlayed)
    {
        currentlyPlayed = inCurrentlyPlayed;
        
        // Play song :
        [[[[RVRdioManager sharedManager] rdio] player] playSource:currentlyPlayed.trackID];

    }
}

-(RVTrack *)currentlyPlayed
{
    return currentlyPlayed;
}

/**************************************************************************************************/
#pragma mark - View Management

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tracks = [NSMutableArray array];
    self.currentlyPlayed = nil;
    [[RVRdioManager sharedManager] getTracksWithDelegate:self];
    
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
                                  
                               
                                  NSArray *sortedTracks = [RVTrack sortTracksByBPMForArray:self.tracks];
                                  self.tracks = [NSMutableArray arrayWithArray:sortedTracks];
                                  
                                  DLog(@"--------------------------------------------");
                                  DLog(@"\n\n\n tracks : %@",self.tracks);
                                  
                                  if (!self.currentlyPlayed && self.tracks.count > 1)
                                  {
                                      
                                      self.currentlyPlayed = [self.tracks objectAtIndex:self.tracks.count/2];
                                  }
                                  
                              }
                                 failed:^(RVTrack *track, NSError *error) {
                                     
                                     [self.tracks removeObject:track];
                                 }];
}

- (void)rdioRequest:(RDAPIRequest *)request didFailWithError:(NSError *)error
{
    DLog(@"failure for request : %@ with error : %@",request,error);
}


@end
