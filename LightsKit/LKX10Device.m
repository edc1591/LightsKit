//
//  LKX10Device.m
//  LightsKit
//
//  Created by Evan Coleman on 8/2/13.
//  Copyright (c) 2013 Evan Coleman. All rights reserved.
//

#import "LKX10Device.h"
#import "LKEvent.h"

@interface LKX10Device ()

@property (nonatomic) NSInteger deviceID;
@property (nonatomic) NSInteger houseCode;
@property (nonatomic) LKX10DeviceType type;
@property (nonatomic) NSString *name;
@property (nonatomic) NSInteger zone;

@end

@implementation LKX10Device

+ (LKX10Device *)deviceWithDictionary:(NSDictionary *)deviceDict {
    return [LKX10Device deviceWithID:[deviceDict[LKX10DeviceIDKey] integerValue]
                           houseCode:[deviceDict[LKX10HouseCodeKey] integerValue]
                                name:deviceDict[LKNameKey]
                                type:[deviceDict[LKX10DeviceTypeKey] integerValue]
                                zone:[deviceDict[LKX10DeviceZoneKey] integerValue]];
}

+ (LKX10Device *)deviceWithID:(NSInteger)deviceID houseCode:(NSInteger)houseCode name:(NSString *)name type:(LKX10DeviceType)type zone:(NSInteger)zone {
    LKX10Device *device = [[LKX10Device alloc] init];
    device.deviceID = deviceID;
    device.houseCode = houseCode;
    device.name = name;
    device.type = type;
    device.zone = zone;
    return device;
}

- (NSString *)description {
    return self.name;
}

@end
