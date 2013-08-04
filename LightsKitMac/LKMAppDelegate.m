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
    [self.session queryStateWithBlock:^(LKResponse *response) {
        LKEvent *event = response.event;
        self.colorWell.color = [NSColor colorWithCalibratedRed:event.color.red green:event.color.green blue:event.color.blue alpha:1];
    }];
}

- (IBAction)setColor:(id)sender {
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    [self.colorWell.color getRed:&red green:&green blue:&blue alpha:NULL];
    [self.session sendEvent:[LKEvent colorEventWithColor:[LKColor colorWithRGB:@[@(red*255), @(green*255), @(blue*255)]]]];
}

- (IBAction)getDevices:(id)sender {
    [self.session queryX10DevicesWithBlock:^(LKResponse *response) {
        NSLog(@"%@", response.objects);
    }];
}

- (IBAction)getPresets:(id)sender {
    [self.session queryPresetsWithBlock:^(LKResponse *response) {
        NSLog(@"%@", response.objects);
    }];
}

- (IBAction)getSchedule:(id)sender {
    [self.session queryScheduleWithBlock:^(LKResponse *response) {
        NSLog(@"%@", response.objects);
    }];
}

@end
