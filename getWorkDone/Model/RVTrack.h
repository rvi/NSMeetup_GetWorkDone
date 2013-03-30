//
//  RVTrack.h
//  getWorkDone
//
//  Created by Rémy on 30/03/13.
//  Copyright (c) 2013 R√©my Virin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RVTrack : NSObject

/**************************************************************************************************/
#pragma mark - Getters & Setters

@property (nonatomic, strong) NSString *trackID;
@property (nonatomic, strong) NSString *artistName;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) CGFloat bpm;


/**************************************************************************************************/
#pragma mark - Birth & Death

+ (RVTrack *)trackWithDictionnary:(NSDictionary *)json;


@end