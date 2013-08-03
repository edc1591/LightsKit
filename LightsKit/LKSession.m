//
//  LKSession.m
//  LightsKit
//
//  Created by Evan Coleman on 8/2/13.
//  Copyright (c) 2013 Evan Coleman. All rights reserved.
//

#import "LKSession.h"
#import "LKResponse.h"
#import <SocketRocket/SRWebSocket.h>

@interface LKSession () <SRWebSocketDelegate>

@property (nonatomic) SRWebSocket *socket;

@end

@implementation LKSession

#pragma mark - Class lifecycle

+ (instancetype)sharedSession {
    static id sharedSession = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSession = [[self alloc] init];
    });
    
    return sharedSession;
}

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - Getters

- (NSURL *)serverURL {
    return self.socket.url;
}

#pragma mark - SocketRocket methods

- (void)openSessionWithURL:(NSURL *)url {
    self.socket = [[SRWebSocket alloc] initWithURL:url];
    self.socket.delegate = self;
    [self.socket open];
}

- (void)queryState:(void (^)(LKResponse *))block {
    
}

#pragma mark - SocketRocket delegate

- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    
}

@end
