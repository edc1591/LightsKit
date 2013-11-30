//
//  LKEventCollection.h
//  LightsKit
//
//  Created by Evan Coleman on 11/30/13.
//  Copyright (c) 2013 Evan Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKEvent.h"

@interface LKEventCollection : NSObject

@property (nonatomic, readonly) NSArray *events;

+ (instancetype)collectionWithDevices:(NSArray *)devices command:(LKX10Command)command;

- (NSString *)bodyString;
- (NSDictionary *)dictionaryRepresentation;

@end
