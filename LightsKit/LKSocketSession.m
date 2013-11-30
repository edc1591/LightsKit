//
//  LKSession.m
//  LightsKit
//
//  Created by Evan Coleman on 8/2/13.
//  Copyright (c) 2013 Evan Coleman. All rights reserved.
//

#import "LKSocketSession.h"
#import "LKEvent.h"
#import "LKColor.h"
#import "LKResponse.h"
#import "LKPreset.h"
#import "LKEventCollection.h"
#import <SocketRocket/SRWebSocket.h>

static id _activeSession = nil;

@interface LKSocketSession () <SRWebSocketDelegate>

@property (nonatomic) SRWebSocket *socket;

@property (nonatomic, copy) void (^socketDidOpenBlock)();

@end

@implementation LKSocketSession

#pragma mark - Class lifecycle

+ (instancetype)activeSession {
    return _activeSession;
}

- (instancetype)initWithServer:(NSURL *)url {
    self = [super init];
    if (self) {
        _activeSession = self;
        self.socket = [[SRWebSocket alloc] initWithURL:url];
        self.socket.delegate = self;
    }
    return self;
}

#pragma mark - Getters

- (NSURL *)serverURL {
    return self.socket.url;
}

#pragma mark - SocketRocket methods

- (void)openSessionWithCompletion:(void (^)())completion {
    self.socketDidOpenBlock = completion;
    [self.socket open];
}

- (void)closeSession {
    [self.socket close];
}

- (void)resumeSessionWithCompletion:(void (^)())completion {
    [self openSessionWithCompletion:completion];
}

- (void)sendEvent:(LKEvent *)event {
    [self.socket send:event.bodyString];
}

- (void)sendEventCollection:(LKEventCollection *)collection {
    [self.socket send:collection.bodyString];
}

#pragma mark - Convenience methods



#pragma mark - SocketRocket delegate

- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    if (self.socketDidOpenBlock) {
        self.socketDidOpenBlock();
    }
    self.socketDidOpenBlock = nil;
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    dispatch_async(dispatch_get_main_queue(), ^{
        //LKResponse *response = [LKResponse responseWithBodyString:message];
        
    });
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    
}

@end
