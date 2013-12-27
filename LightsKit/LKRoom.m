//
//  LKRoom.m
//  LightsKit
//
//  Created by Evan Coleman on 12/27/13.
//  Copyright (c) 2013 Evan Coleman. All rights reserved.
//

#import "LKRoom.h"
#import "LKX10Device.h"

static NSString * const LKRoomNameKey = @"name";
static NSString * const LKRoomDevicesKey = @"x10_devices";

@interface LKRoom ()

@property (nonatomic) NSString *name;
@property (nonatomic) NSArray *devices;

@end

@implementation LKRoom

+ (instancetype)roomWithDictionary:(NSDictionary *)dict {
    LKRoom *room = [[LKRoom alloc] init];
    room.name = dict[LKRoomNameKey];
    
    NSMutableArray *devices = [NSMutableArray array];
    for (NSDictionary *deviceDict in dict[LKRoomDevicesKey]) {
        [devices addObject:[LKX10Device deviceWithDictionary:deviceDict]];
    }
    room.devices = [devices copy];
    
    return room;
}

@end
