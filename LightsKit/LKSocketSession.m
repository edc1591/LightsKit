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
@property (nonatomic) NSURL *serverURL;

@property (nonatomic, copy) void (^socketDidOpenBlock)();
@property (nonatomic, copy) void (^currentStateBlock)(LKEvent *event);

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
        self.serverURL = url;
        self.socket = [[SRWebSocket alloc] initWithURL:url];
        self.socket.delegate = self;
    }
    return self;
}

#pragma mark - SocketRocket methods

- (void)openSessionWithCompletion:(void (^)())completion {
    self.socketDidOpenBlock = completion;
    [self.socket open];
}

- (void)closeSession {
    self.socket.delegate = nil;
    [self.socket close];
    self.socket = nil;
}

- (void)resumeSessionWithCompletion:(void (^)())completion {
    self.socket = [[SRWebSocket alloc] initWithURL:self.serverURL];
    self.socket.delegate = self;
    [self openSessionWithCompletion:completion];
}

- (void)sendEvent:(LKEvent *)event {
    [self.socket send:event.bodyString];
}

- (void)sendEventCollection:(LKEventCollection *)collection {
    [self.socket send:collection.bodyString];
}

#pragma mark - Convenience methods

- (void)queryStateWithCompletion:(void (^)(LKEvent *))completion {
    NSArray *array = @[@"current_state", @{@"data": @""}];
    NSData *data = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil];
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [self.socket send:string];
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
    NSData *bodyData = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *responseObject = [NSJSONSerialization JSONObjectWithData:bodyData options:NSJSONReadingAllowFragments error:nil];
    NSString *command = [[responseObject firstObject] firstObject];
    if ([command isEqualToString:@"websocket_rails.ping"]) {
        NSArray *sendObject = @[@"websocket_rails.pong", @{@"data":@""}];
        NSData *data = [NSJSONSerialization dataWithJSONObject:sendObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [webSocket send:string];
    } else if ([command isEqualToString:@"current_state"]) {
        NSDictionary *dataDict = [[responseObject firstObject] objectAtIndex:1];
        LKEvent *event = [LKEvent eventFromDictionary:dataDict[@"data"]];
        if (self.currentStateBlock) {
            self.currentStateBlock(event);
        }
    }
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    
}

@end
