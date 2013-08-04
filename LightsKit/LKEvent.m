//
//  LKEvent.m
//  LightsKit
//
//  Created by Evan Coleman on 8/3/13.
//  Copyright (c) 2013 Evan Coleman. All rights reserved.
//

#import "LKEvent.h"
#import "LKColor.h"
#import "LKX10Device.h"

@interface LKEvent ()

@property (nonatomic) LKEventType type;
@property (nonatomic) LKColor *color;
@property (nonatomic) LKX10Device *device;
@property (nonatomic) LKX10Command command;
@property (nonatomic) NSUInteger index;
@property (nonatomic) CGFloat speed;
@property (nonatomic) CGFloat brightness;

@end

@implementation LKEvent

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - Convenience constructors

+ (instancetype)eventFromDictionary:(NSDictionary *)dictionary {
    LKEventType type = [dictionary[LKEventTypeKey] integerValue];
    
    if (type == LKEventTypeSolid) {
        LKColor *color = [LKColor colorWithRGB:dictionary[LKColorKey]];
        return [LKEvent colorEventWithColor:color];
    } else if (type == LKEventTypeX10Command) {
        LKX10Device *device = [LKX10Device deviceWithDictionary:dictionary];
        return [LKEvent x10EventWithDevice:device command:[dictionary[LKX10CommandKey] integerValue]];
    } else if (dictionary[LKSpeedKey] || dictionary[LKBrightnessKey]) {
        return [LKEvent animationEventWithType:type speed:[dictionary[LKSpeedKey] floatValue] brightness:[dictionary[LKBrightnessKey] floatValue]];
    } else {
        return [LKEvent eventWithType:type];
    }
}

+ (instancetype)eventWithType:(LKEventType)type {
    LKEvent *event = [[self alloc] init];
    event.type = type;
    return event;
}

+ (instancetype)colorEventWithColor:(LKColor *)color {
    LKEvent *event = [[self alloc] init];
    event.type = LKEventTypeSolid;
    event.color = color;
    return event;
}

+ (instancetype)animationEventWithType:(LKEventType)type speed:(CGFloat)speed brightness:(CGFloat)brightness {
    LKEvent *event = [[self alloc] init];
    event.type = type;
    event.speed = speed;
    event.brightness = brightness;
    return event;
}

+ (instancetype)x10EventWithDevice:(LKX10Device *)device command:(LKX10Command)command {
    LKEvent *event = [[self alloc] init];
    event.type = LKEventTypeX10Command;
    event.device = device;
    event.command = command;
    return event;
}

+ (instancetype)presetEventAtIndex:(NSUInteger)index {
    LKEvent *event = [[self alloc] init];
    event.type = LKEventTypeExecutePreset;
    event.index = index;
    return event;
}

#pragma mark - Public methods

- (NSString *)bodyString {
    NSMutableDictionary *eventDict = [NSMutableDictionary dictionary];
    eventDict[LKEventTypeKey] = @(self.type);
    
    if (self.type == LKEventTypeSolid) {
        eventDict[LKColorKey] = self.color.rgb;
    } else if (self.type == LKEventTypeX10Command) {
        eventDict[LKX10DeviceIDKey] = @(self.device.deviceID);
        eventDict[LKX10HouseCodeKey] = @(self.device.houseCode);
        eventDict[LKX10CommandKey] = @(self.command);
    } else if (self.type == LKEventTypeExecutePreset) {
        eventDict[LKIndexKey] = @(self.index);
    } else {
        eventDict[LKSpeedKey] = @(self.speed);
        eventDict[LKBrightnessKey] = @(self.brightness);
    }
    
    return [self jsonStringWithDictionary:eventDict];
}

- (NSString *)description {
    NSMutableString *string = [NSMutableString string];
    [string appendFormat:@"%@: %ld\r", LKEventTypeKey, self.type];
    if (self.type == LKEventTypeSolid) {
        [string appendFormat:@"%@: %@\r", LKColorKey, self.color];
    } else if (self.type == LKEventTypeX10Command) {
        [string appendFormat:@"%@: %@\r", LKX10DeviceIDKey, self.device];
        [string appendFormat:@"%@: %ld\r", LKX10CommandKey, self.command];
    }
    return string;
}

#pragma mark - Private methods

- (NSString *)jsonStringWithDictionary:(NSDictionary *)dict {
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *retVal = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return retVal;
}

@end
