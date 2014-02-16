//
//  LKMutableEventCollection.h
//  LightsKit
//
//  Created by Evan Coleman on 2/15/14.
//  Copyright (c) 2014 Evan Coleman. All rights reserved.
//

#import "LKEventCollection.h"

@interface LKMutableEventCollection : LKEventCollection

- (void)addEvent:(LKEvent *)event;
- (void)removeEvent:(LKEvent *)event;
- (void)removeEventAtIndex:(NSUInteger)idx;

@end
