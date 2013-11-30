//
//  LKResponse.m
//  LightsKit
//
//  Created by Evan Coleman on 8/3/13.
//  Copyright (c) 2013 Evan Coleman. All rights reserved.
//

#import "LKResponse.h"
#import "LKEvent.h"
#import "LKColor.h"
#import "LKX10Device.h"
#import "LKPreset.h"
#import "LKScheduledEvent.h"

@interface LKResponse ()

@property (nonatomic) LKEvent *event;
@property (nonatomic) NSArray *objects;
@property (nonatomic) NSError *error;

@end

@implementation LKResponse

+ (instancetype)responseWithDict:(NSDictionary *)dict {
    LKResponse *response = [[self alloc] init];
    [response parseOutResponse:dict];
    return response;
}

+ (instancetype)responseWithDevices:(NSArray *)devices {
    LKResponse *response = [[self alloc] init];
    [response parseOutDevices:devices];
    return response;
}

#pragma mark - Private methods

- (void)parseOutDevices:(NSArray *)devices_ {
    NSMutableArray *devices = [NSMutableArray array];
    for (NSDictionary *deviceDict in devices_) {
        [devices addObject:[LKX10Device deviceWithDictionary:deviceDict]];
    }
    self.objects = [devices copy];
}

- (void)parseOutResponse:(NSDictionary *)responseDict {
    LKEventType eventType = [responseDict[LKEventTypeKey] integerValue];
    
    if (eventType == LKEventTypeSolid) {
        self.event = [LKEvent colorEventWithColor:[LKColor colorWithRGB:responseDict[LKColorKey]]];
    } else if (eventType == LKEventTypeGetX10Devices) {
        NSMutableArray *devices = [NSMutableArray array];
        for (NSDictionary *deviceDict in responseDict[LKDevicesKey]) {
            [devices addObject:[LKX10Device deviceWithDictionary:deviceDict]];
        }
        self.event = [LKEvent eventWithType:eventType];
        self.objects = [devices copy];
    } else if (eventType == LKEventTypeQueryPresets) {
        NSMutableArray *presets = [NSMutableArray array];
        [responseDict[LKPresetsKey] enumerateObjectsUsingBlock:^(NSDictionary *presetDict, NSUInteger idx, BOOL *stop) {
            LKPreset *preset = [LKPreset presetFromDictionary:presetDict atIndex:idx];
            [presets addObject:preset];
        }];
        self.event = [LKEvent eventWithType:eventType];
        self.objects = [presets copy];
    } else if (eventType == LKEventTypeQuerySchedule) {
        NSMutableArray *events = [NSMutableArray array];
        for (NSDictionary *eventDict in responseDict[LKEventsKey]) {
            [events addObject:[LKScheduledEvent eventFromDictionary:eventDict]];
        }
        self.event = [LKEvent eventWithType:eventType];
        self.objects = [events copy];
    } else {
        self.event = [LKEvent eventWithType:eventType];
    }
}

@end
