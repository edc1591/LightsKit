//
//  LKX10Device.h
//  LightsKit
//
//  Created by Evan Coleman on 8/2/13.
//  Copyright (c) 2013 Evan Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LKX10Device) {
    LKX10DeviceAppliance = 0,
    LKX10DeviceLamp = 1,
};

@interface LKX10Device : NSObject

@property (nonatomic, readonly) NSInteger deviceID;
@property (nonatomic, readonly) NSInteger houseCode;
@property (nonatomic, readonly) LKX10Device type;
@property (nonatomic, readonly) NSString *name;

+ (LKX10Device *)deviceWithID:(NSInteger)deviceID houseCode:(NSInteger)houseCode name:(NSString *)name type:(LKX10Device)type;

@end
