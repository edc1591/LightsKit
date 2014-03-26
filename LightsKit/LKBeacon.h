//
//  LKBeacon.h
//  LightsKit
//
//  Created by Evan Coleman on 3/12/14.
//  Copyright (c) 2014 Evan Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKBeacon : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSInteger beaconId;
@property (nonatomic, readonly) NSInteger major;
@property (nonatomic, readonly) NSInteger minor;
@property (nonatomic, readonly) NSInteger roomId;
@property (nonatomic, readonly) CGFloat latitude;
@property (nonatomic, readonly) CGFloat longitude;

+ (instancetype)beaconWithDictionary:(NSDictionary *)dict;

@end
