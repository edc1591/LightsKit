//
//  LKEventCollection.m
//  LightsKit
//
//  Created by Evan Coleman on 11/30/13.
//  Copyright (c) 2013 Evan Coleman. All rights reserved.
//

#import "LKEventCollection.h"
#import "LKX10Device.h"

@interface LKEventCollection ()

@property (nonatomic) NSArray *events;

@end

@implementation LKEventCollection

+ (instancetype)collectionWithDevices:(NSArray *)devices command:(LKX10Command)command {
    NSMutableArray *events = [NSMutableArray array];
    for (LKX10Device *device in devices) {
        LKEvent *event = [LKEvent x10EventWithDevice:device command:command];
        [events addObject:event];
    }
    LKEventCollection *eventCollection = [[LKEventCollection alloc] initWithEvents:[events copy]];
    return eventCollection;
}

#pragma mark - Private methods

- (instancetype)initWithEvents:(NSArray *)events {
    self = [super init];
    if (self) {
        self.events = events;
    }
    return self;
}

@end
