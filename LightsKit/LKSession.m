//
//  LKSession.m
//  LightsKit
//
//  Created by Evan Coleman on 8/2/13.
//  Copyright (c) 2013 Evan Coleman. All rights reserved.
//

#import "LKSession.h"
#import "LKEvent.h"
#import "LKColor.h"
#import <SocketRocket/SRWebSocket.h>

@interface LKSession () <SRWebSocketDelegate>

@property (nonatomic) SRWebSocket *socket;

@property (nonatomic, copy) void (^socketDidOpenBlock)();
@property (nonatomic, copy) void (^didReceiveStateBlock)();

@end

@implementation LKSession

#pragma mark - Class lifecycle

- (id)initWithServer:(NSURL *)url {
    self = [super init];
    if (self) {
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

- (void)sendEvent:(LKEvent *)event {
    [self.socket send:event.bodyString];
}

#pragma mark - Convenience methods

- (void)queryStateWithBlock:(void (^)(LKEvent *))block {
    self.didReceiveStateBlock = block;
    LKEvent *event = [LKEvent eventWithType:LKEventTypeQuery];
    [self sendEvent:event];
}

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
        if([message hasPrefix:@"currentState"]) {
            NSString *command  = [message stringByReplacingOccurrencesOfString:@"currentState: " withString:@""];
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[command dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
            LKEvent *event = [LKEvent colorEventWithColor:[LKColor colorWithRGB:dict[LKColorKey]]];
            if (self.didReceiveStateBlock) {
                self.didReceiveStateBlock(event);
            }
            self.didReceiveStateBlock = nil;
        }
    });
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    
}

@end
