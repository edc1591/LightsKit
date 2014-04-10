//
//  LKUserSession.h
//  LightsKit
//
//  Created by Evan Coleman on 11/30/13.
//  Copyright (c) 2013 Evan Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKUserSession : NSObject

- (instancetype)initWithServer:(NSURL *)url;

- (void)usernameHasPassword:(NSString *)username completion:(void(^)(BOOL hasPassword, NSError *error))completion;
- (void)setPassword:(NSString *)password forUsername:(NSString *)username completion:(void (^)())completion;

@end
