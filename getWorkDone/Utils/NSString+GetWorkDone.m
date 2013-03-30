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
    NSString *result = nil;
    
    if (secs >= 0)
    {
        int seconds = (int)secs;
        
        div_t divResult = div(seconds, 60);
        
        result = [NSString stringWithFormat:@"%d:%.2d",divResult.quot,divResult.rem];
    }

    return result;
}


@end
