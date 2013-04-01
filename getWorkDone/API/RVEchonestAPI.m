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

// JSON KEYs
#define ECHONEST_ENDPOINT @"http://developer.echonest.com"
#define API_KEY @"api_key"
#define RESPONSE_KEY @"response"
#define TRACK_KEY @"track"
#define AUDIO_SUMMARY_KEY @"audio_summary"
#define TEMPO_KEY @"tempo"
#define ID_KEY @"id"
#define BUCKET_KEY @"bucket"
#define ECHONEST_PATH @"/api/v4/track/profile"

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
    NSURL *url = [NSURL URLWithString:ECHONEST_ENDPOINT];
    
    NSString *trackRequest = [NSString stringWithFormat:@"rdio-US:track:%@",track.trackID];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"GXGYQRGTSMZLAFWWQ", API_KEY,
                            trackRequest, ID_KEY,
                            AUDIO_SUMMARY_KEY, BUCKET_KEY, nil];

    
    AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:url];
    
    
    [client getPath:ECHONEST_PATH
         parameters:params
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSDictionary *json = [responseObject objectFromJSONData];
                NSDictionary *response = [json objectForKey:RESPONSE_KEY];
                NSDictionary *trackDict = [response objectForKey:TRACK_KEY];
                NSDictionary *audioSummary = [trackDict objectForKey:AUDIO_SUMMARY_KEY];
                
                NSString *bpm = [audioSummary objectForKey:TEMPO_KEY];
                
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
