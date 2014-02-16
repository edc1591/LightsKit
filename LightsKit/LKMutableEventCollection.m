//
//  LKMutableEventCollection.m
//  LightsKit
//
//  Created by Evan Coleman on 2/15/14.
//  Copyright (c) 2014 Evan Coleman. All rights reserved.
//

#import "LKMutableEventCollection.h"

@interface LKMutableEventCollection ()

@property (nonatomic) NSMutableArray *events;

@end

@implementation LKMutableEventCollection

- (instancetype)initWithEvents:(NSArray *)events {
    self = [super init];
    if (self) {
        if (![events isKindOfClass:[NSMutableArray class]]) {
            events = [events mutableCopy];
        }
        self.events = (NSMutableArray *)events;
    }
    return self;
}

- (void)addEvent:(LKEvent *)event {
    [self.events addObject:event];
}

- (void)removeEvent:(LKEvent *)event {
    [self.events removeObject:event];
}

- (void)removeEventAtIndex:(NSUInteger)idx {
    [self.events removeObjectAtIndex:idx];
}

@end
