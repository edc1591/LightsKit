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
#import "LKResponse.h"
#import "LKPreset.h"
#import <SocketRocket/SRWebSocket.h>

@interface LKSession () <SRWebSocketDelegate>

@property (nonatomic) SRWebSocket *socket;

@property (nonatomic, copy) void (^socketDidOpenBlock)();
@property (nonatomic, copy) void (^didReceiveStateBlock)(LKResponse *response);
@property (nonatomic, copy) void (^didReceiveDevicesBlock)(LKResponse *response);
@property (nonatomic, copy) void (^didReceivePresetsBlock)(LKResponse *response);
@property (nonatomic, copy) void (^didReceiveScheduleBlock)(LKResponse *response);

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

- (void)executePreset:(LKPreset *)preset {
    LKEvent *event = [LKEvent presetEventAtIndex:preset.index];
    [self sendEvent:event];
}

#pragma mark - Convenience methods

- (void)queryStateWithBlock:(void (^)(LKResponse *response))block {
    self.didReceiveStateBlock = block;
    LKEvent *event = [LKEvent eventWithType:LKEventTypeQuery];
    [self sendEvent:event];
}

- (void)queryX10DevicesWithBlock:(void (^)(LKResponse *response))block {
    self.didReceiveDevicesBlock = block;
    LKEvent *event = [LKEvent eventWithType:LKEventTypeGetX10Devices];
    [self sendEvent:event];
}

- (void)queryPresetsWithBlock:(void (^)(LKResponse *))block {
    self.didReceivePresetsBlock = block;
    LKEvent *event = [LKEvent eventWithType:LKEventTypeQueryPresets];
    [self sendEvent:event];
}

- (void)queryScheduleWithBlock:(void (^)(LKResponse *))block {
    self.didReceiveScheduleBlock = block;
    LKEvent *event = [LKEvent eventWithType:LKEventTypeQuerySchedule];
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
            LKResponse *response = [LKResponse responseWithBodyString:command];
            if (self.didReceiveStateBlock) {
                self.didReceiveStateBlock(response);
            }
            self.didReceiveStateBlock = nil;
        } else {
            LKResponse *response = [LKResponse responseWithBodyString:message];
            if(response.event.type == LKEventTypeGetX10Devices) {
                if (self.didReceiveDevicesBlock) {
                    self.didReceiveDevicesBlock(response);
                }
                self.didReceiveDevicesBlock = nil;
            } else if (response.event.type == LKEventTypeQueryPresets) {
                if (self.didReceivePresetsBlock) {
                    self.didReceivePresetsBlock(response);
                }
                self.didReceivePresetsBlock = nil;
            } else if (response.event.type == LKEventTypeQuerySchedule) {
                if (self.didReceiveScheduleBlock) {
                    self.didReceiveScheduleBlock(response);
                }
                self.didReceiveScheduleBlock = nil;
            }
        }
    });
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    
}

@end
