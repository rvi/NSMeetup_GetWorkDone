//
//  RVTrack.m
//  getWorkDone
//
//  Created by Rémy on 30/03/13.
//  Copyright (c) 2013 R√©my Virin. All rights reserved.
//

#import "RVTrack.h"

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
        
        result.artistName = [json objectForKey:@"albumArtist"];
        
        result.title = [json objectForKey:@"name"];
        result.trackID = [json objectForKey:@"key"];
        
        result.duration = [[json objectForKey:@"duration"] floatValue];
        result.iconURL = [json objectForKey:@"icon"];
    }
    
    return result;
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
    NSArray *sortedArray;
    sortedArray = [arrayToSort sortedArrayUsingComparator:^NSComparisonResult(RVTrack *first, RVTrack *second)
                   {
                       return first.bpm > second.bpm;
                   }];
    
    return sortedArray;
}

@end
