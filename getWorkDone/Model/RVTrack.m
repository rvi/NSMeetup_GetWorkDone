//
//  RVTrack.m
//  getWorkDone
//
//  Created by Rémy on 30/03/13.
//  Copyright (c) 2013 R√©my Virin. All rights reserved.
//

#import "RVTrack.h"

@implementation RVTrack

+ (RVTrack *)trackWithDictionnary:(NSDictionary *)json
{
    RVTrack *result = nil;
    if ([json isKindOfClass:[NSDictionary class]])
    {
        result = [[RVTrack alloc] init];
        
        result.artistName = [json objectForKey:@"albumArtist"];
        
        result.title = [json objectForKey:@"name"];
        
        DLog(@"Artist : %@   title : %@",result.artistName, result.title);
    }
    
    return result;
}

@end
