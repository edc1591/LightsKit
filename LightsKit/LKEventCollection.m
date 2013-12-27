//
//  LKEventCollection.m
//  LightsKit
//
//  Created by Evan Coleman on 11/30/13.
//  Copyright (c) 2013 Evan Coleman. All rights reserved.
//

#import "LKEventCollection.h"
#import "LKX10Device.h"
#import "LKRoom.h"

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

+ (instancetype)collectionWithRoom:(LKRoom *)room command:(LKX10Command)command {
    return [LKEventCollection collectionWithDevices:room.devices command:command];
}

+ (instancetype)collectionWithEvents:(NSArray *)events {
    LKEventCollection *eventCollection = [[LKEventCollection alloc] initWithEvents:events];
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

- (NSString *)jsonStringWithDictionary:(NSDictionary *)dict {
    NSArray *array = @[@"command_collection", @{@"data":dict}];
    NSData *data = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil];
    NSString *retVal = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return retVal;
}

#pragma mark - Public methods

- (NSString *)bodyString {
    return [self jsonStringWithDictionary:self.dictionaryRepresentation];
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *eventDict = [NSMutableDictionary dictionary];
    NSMutableArray *events = [NSMutableArray array];
    for (LKEvent *event in self.events) {
        [events addObject:event.dictionaryRepresentation];
    }
    eventDict[@"events"] = events;
    return eventDict;
}

@end
