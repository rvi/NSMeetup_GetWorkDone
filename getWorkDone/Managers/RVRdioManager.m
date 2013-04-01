//
//  RVRdio.m
//  getWorkDone
//
//  Created by Rémy on 30/03/13.
//  Copyright (c) 2013 R√©my Virin. All rights reserved.
//

#import "RVRdioManager.h"

#define GET_TOP_CHART_KEY @"getTopCharts"
#define TYPE_KEY @"type"
#define TRACK_KEY @"track"
#define COUNT_KEY @"count"
#define NUMBER_OF_DESIRED_TRACKS @"100"

@implementation RVRdioManager

/**************************************************************************************************/
#pragma mark - Singleton method

+ (RVRdioManager *) sharedManager
{
    static dispatch_once_t _singletonPredicate;
    static RVRdioManager *_singleton = nil;
    
    dispatch_once(&_singletonPredicate, ^{
        _singleton = [[super allocWithZone:nil] init];
        
        _singleton.rdio = [[Rdio alloc] initWithConsumerKey:@"vkwweq8d3qpgxzd9s383vje2"
                                                  andSecret:@"cGGZXcgapR"
                                                   delegate:nil];

    });
    
    return _singleton;
}

/**************************************************************************************************/
#pragma mark - Get Tracks

- (void)getTracksWithDelegate:(id<RDAPIRequestDelegate>)delegate
{
    // Download 100 hot tracks from Rdio.
    
    [self.rdio callAPIMethod:GET_TOP_CHART_KEY
          withParameters:@{TYPE_KEY : TRACK_KEY, COUNT_KEY : NUMBER_OF_DESIRED_TRACKS}
                delegate:delegate];
}

@end
