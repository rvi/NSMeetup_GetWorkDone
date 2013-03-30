//
//  RVRdio.m
//  getWorkDone
//
//  Created by Rémy on 30/03/13.
//  Copyright (c) 2013 R√©my Virin. All rights reserved.
//

#import "RVRdioManager.h"

@interface RVRdioManager ()


@end

@implementation RVRdioManager

+ (RVRdioManager *) sharedManager {
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
    [self.rdio callAPIMethod:@"getTopCharts"
          withParameters:@{@"type": @"track", @"count":@"100"}
                delegate:delegate];
}

@end
