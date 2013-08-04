//
//  LKEvent.h
//  LightsKit
//
//  Created by Evan Coleman on 8/3/13.
//  Copyright (c) 2013 Evan Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const LKEventTypeKey = @"event";
static NSString * const LKColorKey = @"color";
static NSString * const LKDevicesKey = @"devices";
static NSString * const LKX10CommandKey = @"command";
static NSString * const LKX10HouseCodeKey = @"houseCode";
static NSString * const LKX10DeviceIDKey = @"device";
static NSString * const LKNameKey = @"name";
static NSString * const LKX10DeviceTypeKey = @"type";
static NSString * const LKSpeedKey = @"speed";
static NSString * const LKBrightnessKey = @"brightness";
static NSString * const LKIndexKey = @"index";
static NSString * const LKPresetsKey = @"presets";
static NSString * const LKActionsKey = @"actions";
static NSString * const LKEventsKey = @"events";

typedef NS_ENUM(NSUInteger, LKEventType) {
    LKEventTypeQuery = 0,
    LKEventTypeSolid = 1,
    LKEventTypeAnimateRainbow = 2,
    LKEventTypeAnimateColorWipe = 3,
    LKEventTypeQuerySchedule = 4,
    LKEventTypeFlushEvents = 5,
    LKEventTypeAnimateRainbowCycle = 6,
    LKEventTypeAnimateBounce = 7,
    LKEventTypeGetX10Devices = 8,
    LKEventTypeX10Command = 9,
    LKEventTypeQueryPresets = 10,
    LKEventTypeExecutePreset = 11,
};

typedef NS_ENUM(NSUInteger, LKX10Command) {
    LKX10CommandOff = 0,
    LKX10CommandOn = 1,
    LKX10CommandDim = 2,
    LKX10CommandBright = 3,
    LKX10CommandAllUnitsOff = 4,
    LKX10CommandAllUnitsOn = 5,
};

@class LKX10Device, LKColor;

@interface LKEvent : NSObject

@property (nonatomic, readonly) LKEventType type;
@property (nonatomic, readonly) LKColor *color;
@property (nonatomic, readonly) LKX10Device *device;
@property (nonatomic, readonly) LKX10Command command;
@property (nonatomic, readonly) NSUInteger index;
@property (nonatomic, readonly) CGFloat speed;
@property (nonatomic, readonly) CGFloat brightness;

@property (nonatomic, readonly) NSString *bodyString;
@property (nonatomic, readonly) NSDictionary *dictionaryRepresentation;

+ (instancetype)eventFromDictionary:(NSDictionary *)dictionary;

+ (instancetype)eventWithType:(LKEventType)type;
+ (instancetype)colorEventWithColor:(LKColor *)color;
+ (instancetype)animationEventWithType:(LKEventType)type speed:(CGFloat)speed brightness:(CGFloat)brightness;
+ (instancetype)x10EventWithDevice:(LKX10Device *)device command:(LKX10Command)command;
+ (instancetype)presetEventAtIndex:(NSUInteger)index;

@end
