//
//  LKScheduledEvent.m
//  LightsKit
//
//  Created by Evan Coleman on 8/3/13.
//  Copyright (c) 2013 Evan Coleman. All rights reserved.
//

#import "LKScheduledEvent.h"

@interface LKScheduledEvent ()

@property (nonatomic) LKEventType type;
@property (nonatomic) NSInteger scheduleId;

@end

@implementation LKScheduledEvent

+ (instancetype)eventFromDictionary:(NSDictionary *)dictionary {
    LKScheduledEvent *event = [super eventFromDictionary:dictionary];
    event.repeat = dictionary[LKRepeatKey];
    event.date = [NSDate dateWithTimeIntervalSince1970:[dictionary[LKDateKey] doubleValue]];
    event.state = [dictionary[LKStateKey] boolValue];
    event.timeZone = [NSTimeZone timeZoneWithName:dictionary[LKTimeZoneKey]];
    event.scheduleId = [dictionary[@"id"] integerValue];
    return event;
}

#pragma mark - Public methods

- (void)setDate:(NSDate *)date timeZone:(NSTimeZone *)timeZone andRepeat:(NSArray *)repeat {
    self.date = date;
    self.timeZone = timeZone;
    self.repeat = repeat;
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[LKRepeatKey] = self.repeat;
    dict[LKDateKey] = @([self.date timeIntervalSince1970]);
    dict[LKStateKey] = @(self.state);
    dict[LKTimeZoneKey] = [self.timeZone name];
    [dict addEntriesFromDictionary:[super dictionaryRepresentation]];
    return dict;
}

- (NSString *)description {
    NSMutableString *string = [[super description] mutableCopy];
    [string appendFormat:@"%@: %@\r", LKRepeatKey, self.repeat];
    [string appendFormat:@"%@: %@\r", LKDateKey, self.date];
    [string appendFormat:@"%@: %d\r", LKStateKey, self.state];
    [string appendFormat:@"%@: %@\r", LKTimeZoneKey, self.timeZone.name];
    return string;
}

@end
