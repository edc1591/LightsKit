//
//  LKColor.m
//  LightsKit
//
//  Created by Evan Coleman on 8/3/13.
//  Copyright (c) 2013 Evan Coleman. All rights reserved.
//

#import "LKColor.h"

@implementation LKColor

+ (instancetype)colorWithRGB:(NSArray *)rgb {
    LKColor *color = [[self alloc] init];
    color.red = [rgb[0] floatValue];
    color.green = [rgb[1] floatValue];
    color.blue = [rgb[2] floatValue];
    return color;
}

@end
