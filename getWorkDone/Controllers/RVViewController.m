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

// Utils
#import "NSString+GetWorkDone.h"

#import "UIImageView+AFNetworking.h"

@interface RVViewController ()
{
    RVTrack *currentlyPlayed;
}

@property (nonatomic, strong) NSMutableArray *tracks;
@property (nonatomic, strong) RVTrack *currentlyPlayed;
@property (nonatomic, strong) NSTimer *secondsTimer;
@property (nonatomic, assign) CGFloat currentSeconds;

@end

@implementation RVViewController

/**************************************************************************************************/
#pragma mark - Getters & Setters

-(void)setCurrentlyPlayed:(RVTrack *)inCurrentlyPlayed
{
    if (currentlyPlayed != inCurrentlyPlayed)
    {
        currentlyPlayed = inCurrentlyPlayed;
        
        [self updatePlayerandUI];
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

    
    self.progressView.trackImage = [UIImage imageNamed:@"PlayScreen_progress-bar-base"];
    self.progressView.progressImage = [UIImage imageNamed:@"PlayScreen_progress-bar-orange"];
    
}

/**************************************************************************************************/
#pragma mark - UI

- (void)updatePlayerandUI
{
    RDPlayer *player = [[[RVRdioManager sharedManager] rdio] player];
    [player playSource:self.currentlyPlayed.trackID];
 
    self.artistLabel.text = [self.currentlyPlayed.artistName uppercaseString];
    self.titleLabel.text = [self.currentlyPlayed.title uppercaseString];
    self.currentTimeLabel.text = [NSString stringWithSecondsInString:0.0];
    
    NSURL *url = [NSURL URLWithString:self.currentlyPlayed.iconURL];
    [self.jacketImageView setImageWithURL:url];
    
    [self.secondsTimer invalidate];
    self.secondsTimer = nil;
    self.currentSeconds = 0.0f;
    self.progressView.progress = 0.0;
    
    // We're in play mode, not in Pause
    [self.playButton setSelected:NO];
    
    self.secondsTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(refreshUITimer:) userInfo:nil repeats:YES];
    
    self.songDurationlabel.text = [NSString stringWithSecondsInString:self.currentlyPlayed.duration];
}

- (void)refreshUITimer:(id)sender
{
    if ([self.secondsTimer isValid])
    {
        self.currentSeconds++;
        
        self.currentTimeLabel.text =  [NSString stringWithSecondsInString:self.currentSeconds];
        
        self.progressView.progress =  self.currentSeconds / self.currentlyPlayed.duration;
    }
}

/**************************************************************************************************/
#pragma mark - Actions

- (IBAction)playButtonTapped:(id)sender
{
    [[[[RVRdioManager sharedManager] rdio] player] togglePause];

    // Selected style is on PAUSE
    BOOL isOnPause = [self.playButton isSelected];
    
    [self.playButton setSelected:!isOnPause];
    
    if(!isOnPause)
    {
        [self.secondsTimer invalidate];
        self.secondsTimer = nil;
    }
    else
    {
        self.secondsTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self
                                                           selector:@selector(refreshUITimer:)
                                                           userInfo:nil
                                                            repeats:YES];
    }
}

- (IBAction)nextButtonTapped:(id)sender
{
    NSUInteger currentIndex = [self.tracks indexOfObject:self.currentlyPlayed];
    
    // If last song, then restart from the first one.
    if(currentIndex == self.tracks.count - 1)
    {
        currentIndex = 0;
    }
    else
    {
        currentIndex++;
    }
    
    if (currentIndex < self.tracks.count)
    {
        RVTrack *nextTrack = [self.tracks objectAtIndex:currentIndex];
        self.currentlyPlayed = nextTrack;
    }
    
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
        
            DLog(@"get %d tracks from Rdio",[self.tracks count]);
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
                                     
                                     NSArray *sortedTracks = [RVTrack sortTracksByBPMForArray:self.tracks];
                                     self.tracks = [NSMutableArray arrayWithArray:sortedTracks];

                                 }];
}

- (void)rdioRequest:(RDAPIRequest *)request didFailWithError:(NSError *)error
{
    DLog(@"failure for request : %@ with error : %@",request,error);
}

@end
