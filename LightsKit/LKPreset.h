//
//  LKPreset.h
//  LightsKit
//
//  Created by Evan Coleman on 8/3/13.
//  Copyright (c) 2013 Evan Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKPreset : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSMutableArray *actions;
@property (nonatomic, readonly) NSUInteger index;

+ (instancetype)presetFromDictionary:(NSDictionary *)dict atIndex:(NSUInteger)index;
- (NSDictionary *)dictionaryRepresentation;

@end
