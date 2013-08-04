//
//  LKMAppDelegate.h
//  LightsKitMac
//
//  Created by Evan Coleman on 8/3/13.
//  Copyright (c) 2013 Evan Coleman. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface LKMAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *statusLabel;
@property (weak) IBOutlet NSColorWell *colorWell;

- (IBAction)getState:(id)sender;
- (IBAction)setColor:(id)sender;
- (IBAction)getDevices:(id)sender;
- (IBAction)getPresets:(id)sender;
- (IBAction)getSchedule:(id)sender;

@end
