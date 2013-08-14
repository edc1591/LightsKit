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

@property (nonatomic) NSString *bodyString;
@property (nonatomic) LKEvent *event;
@property (nonatomic) NSArray *objects;
@property (nonatomic) NSError *error;

@end

@implementation LKResponse

+ (instancetype)responseWithBodyString:(NSString *)body {
    LKResponse *response = [[self alloc] init];
    response.bodyString = body;
    [response parseOutResponseString:body];
    return response;
}

#pragma mark - Private methods

- (void)parseOutResponseString:(NSString *)string {
    NSData *bodyData = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:bodyData options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        self.error = error;
        return;
    }
    
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
