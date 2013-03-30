//
//  RVEchonestAPI.m
//  getWorkDone
//
//  Created by Rémy on 30/03/13.
//  Copyright (c) 2013 R√©my Virin. All rights reserved.
//

#import "RVEchonestAPI.h"

#import "AFHTTPClient.h"

// Parsing
#import "JSONKit.h"

@implementation RVEchonestAPI

/**************************************************************************************************/
#pragma mark - All songs


+(void)getMoreInfoForTracks:(NSArray *)tracks
                  succeeded:(void (^) (RVTrack *track))success
                     failed:(void (^) (RVTrack *track, NSError *error))failure
{
    for (RVTrack *track in tracks)
    {
        
        if ([track isKindOfClass:[RVTrack class]])
        {
            [RVEchonestAPI getMoreInfoForTrack:track succeeded:^(RVTrack *trackUpdated) {
             
                if (success)
                {
                    success(track);
                }
                
            } failed:^(RVTrack *track, NSError *error) {

                //DLog(@"failed : %@", error);

                if (failure)
                {
                    failure(track, error);
                }
            }];
        }
    }
}


/**************************************************************************************************/
#pragma mark - HTTP Calls

+(void)getMoreInfoForTrack:(RVTrack *)track
                 succeeded:(void (^) (RVTrack *track))success
                    failed:(void (^) (RVTrack *track, NSError *error))failure
{
    NSURL *url = [NSURL URLWithString:@"http://developer.echonest.com"];
    
    NSString *trackRequest = [NSString stringWithFormat:@"rdio-US:track:%@",track.trackID];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"GXGYQRGTSMZLAFWWQ", @"api_key",
                            trackRequest, @"id",
                            @"audio_summary",@"bucket", nil];

    
    AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:url];
    
    
    [client getPath:@"/api/v4/track/profile"
         parameters:params
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSDictionary *json = [responseObject objectFromJSONData];
                NSDictionary *response = [json objectForKey:@"response"];
                NSDictionary *trackDict = [response objectForKey:@"track"];
                NSDictionary *audioSummary = [trackDict objectForKey:@"audio_summary"];
                
                NSString *bpm = [audioSummary objectForKey:@"tempo"];
                
                if (bpm)
                {
                    track.bpm = [bpm floatValue];
                    
                    success(track);
                }
                else
                {
                    failure(track, nil);
                }
            }
            failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                if (failure)
                {
                    failure(nil, error);
                }
            }];
}
@end
