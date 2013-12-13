//
//  LKAnimation.h
//  LightsKit
//
//  Created by Evan Coleman on 12/12/13.
//  Copyright (c) 2013 Evan Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKAnimation : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSInteger animationId;
@property (nonatomic) NSInteger speed;
@property (nonatomic) NSInteger brightness;

+ (instancetype)animationWithDictionary:(NSDictionary *)dict;

@end
