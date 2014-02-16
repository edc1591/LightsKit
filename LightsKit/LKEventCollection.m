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
#import "LKColor.h"
#import "LKMutableEventCollection.h"

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
    LKMutableEventCollection *collection = [[LKEventCollection collectionWithDevices:room.devices command:command] mutableCopy];
    
    if (room.hasColors) {
        LKEvent *event = nil;
        if (command == LKX10CommandOn) {
            event = [LKEvent animationEventWithType:LKEventTypeAnimateRainbow speed:1.0 brightness:255.0];
        } else if (command == LKX10CommandOff) {
            event = [LKEvent colorEventWithColor:[LKColor colorWithRGB:@[@0, @0, @0]]];
        }
        [collection addEvent:event];
    }
    
    return collection;
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

#pragma mark - NSMutableCopying

- (id)mutableCopyWithZone:(NSZone *)zone {
    id copy = [[LKMutableEventCollection alloc] initWithEvents:[self.events mutableCopyWithZone:zone]];
    
    return copy;
}

@end
