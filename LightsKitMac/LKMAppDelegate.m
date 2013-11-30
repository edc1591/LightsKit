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
@property (nonatomic) NSArray *presets;
@property (nonatomic) NSArray *devices;

@end

@implementation LKMAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    self.statusLabel.stringValue = @"Status: Connecting...";
    self.session = [[LKSession alloc] initWithServer:[NSURL URLWithString:@"http://example.com"]];
    [self.session openSessionWithUsername:@"" password:@"" completion:^{
        self.statusLabel.stringValue = @"Status: Connected!";
    }];
}

- (IBAction)getState:(id)sender {
//    [self.session queryStateWithBlock:^(LKResponse *response) {
//        LKEvent *event = response.event;
//        self.colorWell.color = [NSColor colorWithCalibratedRed:event.color.red green:event.color.green blue:event.color.blue alpha:1];
//    }];
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
        self.devices = response.objects;
        [self.devicesPopup removeAllItems];
        [self.devices enumerateObjectsUsingBlock:^(LKX10Device *obj, NSUInteger idx, BOOL *stop) {
            [self.devicesPopup addItemWithTitle:obj.name];
        }];
        NSLog(@"%@", response.objects);
    }];
}

- (IBAction)getPresets:(id)sender {
    [self.session queryPresetsWithBlock:^(LKResponse *response) {
        self.presets = response.objects;
        [self.presetsPopup removeAllItems];
        [self.presets enumerateObjectsUsingBlock:^(LKPreset *obj, NSUInteger idx, BOOL *stop) {
            [self.presetsPopup addItemWithTitle:obj.name];
        }];
        NSLog(@"%@", self.presets);
    }];
}

- (IBAction)getSchedule:(id)sender {
    [self.session queryScheduleWithBlock:^(LKResponse *response) {
        NSLog(@"%@", response.objects);
    }];
}

- (IBAction)executePreset:(id)sender {
    LKPreset *preset = self.presets[[self.presetsPopup indexOfSelectedItem]];
    [self.session executePreset:preset];
}

- (IBAction)on:(id)sender {
    LKX10Device *device = self.devices[[self.devicesPopup indexOfSelectedItem]];
    [self.session sendEvent:[LKEvent x10EventWithDevice:device command:LKX10CommandOn]];
}

- (IBAction)off:(id)sender {
    LKX10Device *device = self.devices[[self.devicesPopup indexOfSelectedItem]];
    [self.session sendEvent:[LKEvent x10EventWithDevice:device command:LKX10CommandOff]];
}

@end
