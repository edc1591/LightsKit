//
//  LKBeacon.m
//  LightsKit
//
//  Created by Evan Coleman on 3/12/14.
//  Copyright (c) 2014 Evan Coleman. All rights reserved.
//

#import "LKBeacon.h"

static NSString * const LKBeaconNameKey = @"name";
static NSString * const LKBeaconIdKey = @"id";
static NSString * const LKBeaconMajorKey = @"major";
static NSString * const LKBeaconMinorKey = @"minor";
static NSString * const LKBeaconRoomIdKey = @"room_id";

@interface LKBeacon ()

@property (nonatomic) NSString *name;
@property (nonatomic) NSInteger beaconId;
@property (nonatomic) NSInteger major;
@property (nonatomic) NSInteger minor;
@property (nonatomic) NSInteger roomId;

@end

@implementation LKBeacon

+ (instancetype)beaconWithDictionary:(NSDictionary *)dict {
    LKBeacon *beacon = [[LKBeacon alloc] init];
    beacon.name = dict[LKBeaconNameKey];
    beacon.beaconId = [dict[LKBeaconIdKey] integerValue];
    beacon.major = [dict[LKBeaconMajorKey] integerValue];
    beacon.minor = [dict[LKBeaconMinorKey] integerValue];
    beacon.roomId = [dict[LKBeaconRoomIdKey] integerValue];
    return beacon;
}

@end
