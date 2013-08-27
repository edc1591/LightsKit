//
//  LKScheduledEvent.h
//  LightsKit
//
//  Created by Evan Coleman on 8/3/13.
//  Copyright (c) 2013 Evan Coleman. All rights reserved.
//

#import "LKEvent.h"

static NSString * const LKRepeatKey = @"repeat";
static NSString * const LKDateKey = @"time";
static NSString * const LKStateKey = @"state";
static NSString * const LKTimeZoneKey = @"timeZone";

@interface LKScheduledEvent : LKEvent

@property (nonatomic) NSString *repeat;
@property (nonatomic) NSDate *date;
@property (nonatomic) BOOL state;
@property (nonatomic) NSTimeZone *timeZone;

- (void)setDate:(NSDate *)date timeZone:(NSTimeZone *)timeZone andRepeat:(NSString *)repeat;

@end
