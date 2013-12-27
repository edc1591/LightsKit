//
//  LKRoom.h
//  LightsKit
//
//  Created by Evan Coleman on 12/27/13.
//  Copyright (c) 2013 Evan Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKRoom : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSArray *devices;

+ (instancetype)roomWithDictionary:(NSDictionary *)dict;

@end
