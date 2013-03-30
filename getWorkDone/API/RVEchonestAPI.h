//
//  RVEchonestAPI.h
//  getWorkDone
//
//  Created by Rémy on 30/03/13.
//  Copyright (c) 2013 R√©my Virin. All rights reserved.
//

#import <Foundation/Foundation.h>

// Model
#import "RVTrack.h"

@interface RVEchonestAPI : NSObject

/**************************************************************************************************/
#pragma mark - All songs

+(void)getMoreInfoForTracks:(NSArray *)tracks
                  succeeded:(void (^) (RVTrack *track))success
                     failed:(void (^) (RVTrack *track, NSError *error))failure;


/**************************************************************************************************/
#pragma mark - HTTP Calls

+(void)getMoreInfoForTrack:(RVTrack *)track
                 succeeded:(void (^) (RVTrack *track))success
                    failed:(void (^) (RVTrack *track, NSError *error))failure;

@end
