//
//  LKEventCollection.h
//  LightsKit
//
//  Created by Evan Coleman on 11/30/13.
//  Copyright (c) 2013 Evan Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKEvent.h"

@class LKRoom;

@interface LKEventCollection : NSObject <NSMutableCopying>

@property (nonatomic, readonly) NSArray *events;

+ (instancetype)collectionWithDevices:(NSArray *)devices command:(LKX10Command)command;
+ (instancetype)collectionWithEvents:(NSArray *)events;
+ (instancetype)collectionWithRoom:(LKRoom *)room command:(LKX10Command)command;

- (NSString *)bodyString;
- (NSDictionary *)dictionaryRepresentation;

@end
