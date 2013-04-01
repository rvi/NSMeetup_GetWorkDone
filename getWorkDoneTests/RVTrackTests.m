//
//  RVTrackTests.m
//  getWorkDone
//
//  Created by Rémy on 31/03/13.
//  Copyright (c) 2013 R√©my Virin. All rights reserved.
//

#import "RVTrackTests.h"

#import "RVTrack.h"

@implementation RVTrackTests

/**************************************************************************************************/
#pragma mark - Birth & Death

-(void)setUp
{
    [super setUp];
    
    RVTrack *track1 = [[RVTrack alloc] init];
    track1.bpm = 100;
    RVTrack *track2 = [[RVTrack alloc] init];
    track2.bpm = 101;
    RVTrack *track3 = [[RVTrack alloc] init];
    track3.bpm = 90;
    RVTrack *track4 = [[RVTrack alloc] init];
    track4.bpm = 110;
    RVTrack *track5 = [[RVTrack alloc] init];
    track5.bpm = 100;
    
    self.tracks = [NSArray arrayWithObjects:track1, track2, track3, track4, track5, nil];
}


-(void)tearDown
{
    [super tearDown];
}

/**************************************************************************************************/
#pragma mark - test sort tracks

- (void)testsortTracksByBPMForArrayNilReturnNil
{
    // GIVEN
    NSArray *toSort = nil;
    
    // WHEN
    NSArray *result = [RVTrack sortTracksByBPMForArray:toSort];
    
    // THEN
    STAssertNil(result, nil);
}


- (void)testsortTracksByBPMForArrayWithWrongElementReturnNil
{
    // GIVEN
    NSArray *toSort = [NSArray arrayWithObjects:@"foo", @"bar", @"baz", nil];
    
    // WHEN
    NSArray *result = [RVTrack sortTracksByBPMForArray:toSort];
    
    // THEN
    STAssertNil(result, nil);
}

- (void)testsortTracksByBPMForArrayWithGoodElementReturnOk
{
    // GIVEN
    NSArray *toSort = self.tracks;
    
    // WHEN
    NSArray *result = [RVTrack sortTracksByBPMForArray:toSort];
    
    // THEN
    STAssertNotNil(result, nil);
    STAssertEquals((CGFloat)90, [[result objectAtIndex:0] bpm], nil);
}

@end
