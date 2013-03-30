//
//  NSString+GetWorkDone.m
//  getWorkDone
//
//  Created by Rémy on 30/03/13.
//  Copyright (c) 2013 R√©my Virin. All rights reserved.
//

#import "NSString+GetWorkDone.h"

@implementation NSString (GetWorkDone)

+(NSString *)stringWithSecondsInString:(double)secs
{
    int seconds = (int)secs;
    
    div_t result = div(seconds, 60);
    
    return [NSString stringWithFormat:@"%d:%.2d",result.quot,result.rem];
}


@end
