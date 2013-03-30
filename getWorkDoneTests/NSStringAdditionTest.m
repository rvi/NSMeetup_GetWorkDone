//
//  NSString+NSStringAdditionTest.m
//  getWorkDone
//
//  Created by Rémy on 30/03/13.
//  Copyright (c) 2013 R√©my Virin. All rights reserved.
//


#import "NSStringAdditionTest.h"

#import "NSString+GetWorkDone.h"

@implementation NSStringAdditionTest

- (void)testStringFromSecondsWithO
{
    // GIVEN
    CGFloat seconds = 0;
    
    // WHEN
    NSString * result = [NSString stringWithSecondsInString:seconds];
    
    // THEN
    STAssertEqualObjects(result, @"0:00", nil);
}

- (void)testStringFromSecondsWith_1
{
    // GIVEN
    CGFloat seconds = -1;
    
    // WHEN
    NSString * result = [NSString stringWithSecondsInString:seconds];
    
    // THEN
    STAssertNil(result, nil);
}


- (void)testStringFromSecondsWith123
{
    // GIVEN
    CGFloat seconds = 123;
    
    // WHEN
    NSString * result = [NSString stringWithSecondsInString:seconds];
    
    // THEN
    STAssertEqualObjects(result, @"2:03", nil);
}

@end
