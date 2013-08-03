//
//  LKColor.h
//  LightsKit
//
//  Created by Evan Coleman on 8/3/13.
//  Copyright (c) 2013 Evan Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKColor : NSObject

@property (nonatomic, readonly) NSInteger red;
@property (nonatomic, readonly) NSInteger green;
@property (nonatomic, readonly) NSInteger blue;
@property (nonatomic, readonly) NSArray *rgb;

+ (instancetype)colorWithRGB:(NSArray *)rgb;

@end
