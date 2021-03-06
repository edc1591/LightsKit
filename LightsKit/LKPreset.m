//
//  LKPreset.m
//  LightsKit
//
//  Created by Evan Coleman on 8/3/13.
//  Copyright (c) 2013 Evan Coleman. All rights reserved.
//

#import "LKPreset.h"
#import "LKEvent.h"

@interface LKPreset ()

@property (nonatomic) NSUInteger index;

@end

@implementation LKPreset

- (instancetype)init {
    self = [super init];
    if (self) {
        self.actions = [NSMutableArray array];
    }
    return self;
}

+ (instancetype)presetFromDictionary:(NSDictionary *)dict atIndex:(NSUInteger)index {
    LKPreset *preset = [[self alloc] init];
    
    preset.name = dict[LKNameKey];
    preset.index = index;
    for (NSDictionary *d in dict[LKEventsKey]) {
        [preset.actions addObject:[LKEvent eventFromDictionary:d]];
    }
    
    return preset;
}

- (NSString *)description {
    NSMutableString *string = [NSMutableString stringWithFormat:@"%@: %@\r", LKNameKey, self.name];
    int i = 0;
    for (LKEvent *event in self.actions) {
        [string appendFormat:@"%d: %@\r", i, event];
        i++;
    }
    [string appendString:@"\r"];
    return string;
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutDict = [NSMutableDictionary dictionary];
    mutDict[LKNameKey] = self.name;
    NSMutableArray *events = [NSMutableArray array];
    for (LKEvent *event in self.actions) {
        [events addObject:[event dictionaryRepresentation]];
    }
    mutDict[LKEventsKey] = events;
    return [mutDict copy];
}

@end
