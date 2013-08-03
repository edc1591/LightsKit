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
            LKX10Device *device = [LKX10Device deviceWithID:[deviceDict[LKX10DeviceIDKey] integerValue]
                                                  houseCode:[deviceDict[LKX10HouseCodeKey] integerValue]
                                                       name:deviceDict[LKX10DeviceNameKey]
                                                       type:[deviceDict[LKX10DeviceTypeKey] integerValue]];
            [devices addObject:device];
        }
        self.event = [LKEvent eventWithType:eventType];
        self.objects = [devices copy];
    } else {
        self.event = [LKEvent eventWithType:eventType];
    }
}

@end
