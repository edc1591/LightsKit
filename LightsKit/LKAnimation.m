//
//  LKAnimation.m
//  LightsKit
//
//  Created by Evan Coleman on 12/12/13.
//  Copyright (c) 2013 Evan Coleman. All rights reserved.
//

#import "LKAnimation.h"

@implementation LKAnimation

+ (instancetype)animationWithDictionary:(NSDictionary *)dict {
    LKAnimation *animation = [[LKAnimation alloc] init];
    animation.name = dict[@"name"];
    animation.animationId = [dict[@"id"] integerValue];
    animation.speed = [dict[@"speed"] integerValue];
    animation.brightness = [dict[@"brightness"] integerValue];
    return animation;
}

@end
