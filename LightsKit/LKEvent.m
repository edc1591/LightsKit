//
//  LKEvent.m
//  LightsKit
//
//  Created by Evan Coleman on 8/3/13.
//  Copyright (c) 2013 Evan Coleman. All rights reserved.
//

#import "LKEvent.h"

@interface LKEvent ()

@property (nonatomic) LKEventType type;
@property (nonatomic) LKColor *color;
@property (nonatomic) LKX10Device *device;
@property (nonatomic) LKX10Command command;
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

@end
