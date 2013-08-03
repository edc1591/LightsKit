//
//  LKMAppDelegate.m
//  LightsKitMac
//
//  Created by Evan Coleman on 8/3/13.
//  Copyright (c) 2013 Evan Coleman. All rights reserved.
//

#import "LKMAppDelegate.h"
#import "LightsKit.h"

@interface LKMAppDelegate ()

@property (nonatomic) LKSession *session;

@end

@implementation LKMAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    self.statusLabel.stringValue = @"Status: Connecting...";
    self.session = [[LKSession alloc] initWithServer:[NSURL URLWithString:@"ws://evancoleman.net:9000"]];
    [self.session openSessionWithCompletion:^{
        self.statusLabel.stringValue = @"Status: Connected!";
    }];
}

- (IBAction)getState:(id)sender {
    [self.session queryStateWithBlock:^(LKEvent *event) {
        self.colorWell.color = [NSColor colorWithCalibratedRed:event.color.red green:event.color.green blue:event.color.blue alpha:1];
    }];
}

@end
