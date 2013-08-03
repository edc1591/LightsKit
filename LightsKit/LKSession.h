//
//  LKSession.h
//  LightsKit
//
//  Created by Evan Coleman on 8/2/13.
//  Copyright (c) 2013 Evan Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LKEvent;

@interface LKSession : NSObject

@property (nonatomic, readonly) NSURL *serverURL;

- (id)initWithServer:(NSURL *)url;

- (void)openSessionWithCompletion:(void (^)())completion;

- (void)sendEvent:(LKEvent *)event;

- (void)queryStateWithBlock:(void (^)(LKEvent *event))block;

@end
