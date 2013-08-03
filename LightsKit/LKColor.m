//
//  LKColor.m
//  LightsKit
//
//  Created by Evan Coleman on 8/3/13.
//  Copyright (c) 2013 Evan Coleman. All rights reserved.
//

#import "LKColor.h"

@interface LKColor ()

@property (nonatomic) NSInteger red;
@property (nonatomic) NSInteger green;
@property (nonatomic) NSInteger blue;
@property (nonatomic) NSArray *rgb;

@end

@implementation LKColor

+ (instancetype)colorWithRGB:(NSArray *)rgb {
    LKColor *color = [[self alloc] init];
    color.red = [rgb[0] integerValue];
    color.green = [rgb[1] integerValue];
    color.blue = [rgb[2] integerValue];
    return color;
}

- (NSArray *)rgb {
    return @[@(self.red), @(self.green), @(self.blue)];
}

@end
