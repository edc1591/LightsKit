//
//  LKSession.h
//  LightsKit
//
//  Created by Evan Coleman on 11/29/13.
//  Copyright (c) 2013 Evan Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LKEvent, LKScheduledEvent, LKResponse, LKPreset, LKEventCollection;

@interface LKSession : NSObject

@property (nonatomic, readonly) NSURL *serverURL;

+ (instancetype)activeSession;
- (instancetype)initWithServer:(NSURL *)url;

- (void)openSessionWithUsername:(NSString *)username password:(NSString *)password completion:(void (^)(NSDictionary *userDict))completion;
- (void)suspendSession;
- (void)resumeSessionWithCompletion:(void (^)())completion;

- (void)sendEvent:(LKEvent *)event;
- (void)sendEventCollection:(LKEventCollection *)collection;
- (void)scheduleEvent:(LKScheduledEvent *)event withCompletion:(void (^)())completion;
- (void)updateEvent:(LKScheduledEvent *)event withCompletion:(void (^)())completion;
- (void)executePreset:(LKPreset *)preset;

- (void)queryStateWithBlock:(void (^)(LKEvent *state))block;
- (void)queryX10DevicesWithBlock:(void (^)(NSArray *devices))block;
- (void)queryPresetsWithBlock:(void (^)(NSArray *presets))block;
- (void)queryScheduleWithBlock:(void (^)(NSArray *events))block;
- (void)queryAnimationsWithBlock:(void (^)(NSArray *animations))block;
- (void)queryColorPermissionsWithBlock:(void (^)(NSArray *colorZones))block;

@end
