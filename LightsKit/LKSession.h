//
//  LKSession.h
//  LightsKit
//
//  Created by Evan Coleman on 11/29/13.
//  Copyright (c) 2013 Evan Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LKEvent, LKResponse, LKPreset;

@interface LKSession : NSObject

@property (nonatomic, readonly) NSURL *serverURL;

+ (instancetype)activeSession;
- (instancetype)initWithServer:(NSURL *)url;

- (void)openSessionWithUsername:(NSString *)username password:(NSString *)password completion:(void (^)())completion;

- (void)sendEvent:(LKEvent *)event;
- (void)executePreset:(LKPreset *)preset;

- (void)queryStateWithBlock:(void (^)(LKResponse *response))block;
- (void)queryX10DevicesWithBlock:(void (^)(LKResponse *response))block;
- (void)queryPresetsWithBlock:(void (^)(LKResponse *response))block;
- (void)queryScheduleWithBlock:(void (^)(LKResponse *response))block;

@end
