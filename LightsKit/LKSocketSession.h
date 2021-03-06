//
//  LKSession.h
//  LightsKit
//
//  Created by Evan Coleman on 8/2/13.
//  Copyright (c) 2013 Evan Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LKEvent, LKResponse, LKPreset, LKEventCollection;

@interface LKSocketSession : NSObject

@property (nonatomic, readonly) NSURL *serverURL;

+ (instancetype)activeSession;
- (instancetype)initWithServer:(NSURL *)url;

- (void)openSessionWithCompletion:(void (^)())completion;
- (void)closeSession;
- (void)resumeSessionWithCompletion:(void (^)())completion;

- (void)queryStateWithCompletion:(void (^)(LKEvent *event))completion;

- (void)sendEvent:(LKEvent *)event;
- (void)sendEventCollection:(LKEventCollection *)collection;
- (void)notifyServerOfScheduleUpdateInZone:(NSInteger)zone withCompletion:(void (^)())completion;

@end
