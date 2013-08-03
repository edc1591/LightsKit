//
//  LKResponse.h
//  LightsKit
//
//  Created by Evan Coleman on 8/3/13.
//  Copyright (c) 2013 Evan Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LKEvent;

@interface LKResponse : NSObject

@property (nonatomic, readonly) NSString *bodyString;
@property (nonatomic, readonly) LKEvent *event;
@property (nonatomic, readonly) NSArray *objects;
@property (nonatomic, readonly) NSError *error;

+ (instancetype)responseWithBodyString:(NSString *)body;

@end
