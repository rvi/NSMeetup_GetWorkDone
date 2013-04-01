//
//  RVRdio.h
//  getWorkDone
//
//  Created by Rémy on 30/03/13.
//  Copyright (c) 2013 R√©my Virin. All rights reserved.
//


#import <Foundation/Foundation.h>

// Rdio

#import <Rdio/Rdio.h>

@interface RVRdioManager : NSObject

/**************************************************************************************************/
#pragma mark - Getters & Setters

@property (nonatomic, strong) Rdio *rdio;


/**************************************************************************************************/
#pragma mark - Singleton

+ (RVRdioManager *)sharedManager;

/**************************************************************************************************/
#pragma mark - get tracks

- (void)getTracksWithDelegate:(id<RDAPIRequestDelegate>)delegate;


@end
