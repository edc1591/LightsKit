//
//  LKX10Device.h
//  LightsKit
//
//  Created by Evan Coleman on 8/2/13.
//  Copyright (c) 2013 Evan Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LKX10DeviceType) {
    LKX10DeviceTypeAppliance = 0,
    LKX10DeviceTypeLamp = 1,
};

@interface LKX10Device : NSObject

@property (nonatomic, readonly) NSInteger deviceID;
@property (nonatomic, readonly) NSInteger houseCode;
@property (nonatomic, readonly) LKX10DeviceType type;
@property (nonatomic, readonly) NSString *name;

+ (LKX10Device *)deviceWithDictionary:(NSDictionary *)deviceDict;
+ (LKX10Device *)deviceWithID:(NSInteger)deviceID houseCode:(NSInteger)houseCode name:(NSString *)name type:(LKX10DeviceType)type;

@end
