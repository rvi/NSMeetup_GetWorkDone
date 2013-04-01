//
//  RVTrack.m
//  getWorkDone
//
//  Created by Rémy on 30/03/13.
//  Copyright (c) 2013 R√©my Virin. All rights reserved.
//

#import "RVTrack.h"

#define ARTIST_KEY @"albumArtist"
#define NAME_KEY @"name"
#define TRACKID_KEY @"key"
#define DURATION_KEY @"duration"
#define ICON_KEY @"icon"

@implementation RVTrack

/**************************************************************************************************/
#pragma mark - Birth & Death

+ (RVTrack *)trackWithDictionnary:(NSDictionary *)json
{
    RVTrack *result = nil;
    if ([json isKindOfClass:[NSDictionary class]])
    {
        result = [[RVTrack alloc] init];

        result.bpm = 0.f;
        
        result.artistName = [json objectForKey:ARTIST_KEY];
        
        result.title = [json objectForKey:NAME_KEY];
        result.trackID = [json objectForKey:TRACKID_KEY];
        
        result.duration = [[json objectForKey:DURATION_KEY] floatValue];
        result.iconURL = [json objectForKey:ICON_KEY];
    }
    
    result = [result isValid] ? result : nil;
    
    return result;
    
}

/**************************************************************************************************/
#pragma mark - isValid

- (BOOL)isValid
{
    BOOL isValid = YES;
    
    isValid &= [self.artistName isKindOfClass:[NSString class]];
    isValid &= [self.title isKindOfClass:[NSString class]];
    isValid &= [self.trackID isKindOfClass:[NSString class]];
    isValid &= self.duration > 0;
    isValid &= [self.iconURL isKindOfClass:[NSString class]];
    
    return isValid;
}

/**************************************************************************************************/
#pragma mark - Description

-(NSString *)description
{
    return [NSString stringWithFormat:@"Track [\r\
            Artist : %@\r\
            Title : %@\r\
            BPM : %f]", self.artistName, self.title, self.bpm];
}



/**************************************************************************************************/
#pragma mark - Sorting

+ (NSArray *)sortTracksByBPMForArray:(NSArray *)arrayToSort
{
    // Do the sort only if all the tracks are valids
    for (RVTrack *track in arrayToSort)
    {
        if (![track isKindOfClass:[RVTrack class]])
        {
            return nil;
        }
    }
    
    NSArray *sortedArray;
    sortedArray = [arrayToSort sortedArrayUsingComparator:^NSComparisonResult(RVTrack *first, RVTrack *second)
                   {
                       return first.bpm > second.bpm;
                    
                   }];
    
    return sortedArray;
}

@end
