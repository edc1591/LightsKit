//
//  LKUserSession.m
//  LightsKit
//
//  Created by Evan Coleman on 11/30/13.
//  Copyright (c) 2013 Evan Coleman. All rights reserved.
//

#import "LKUserSession.h"
#import <AFNetworking/AFHTTPSessionManager.h>

@interface LKUserSession ()

@property (nonatomic) AFHTTPSessionManager *sessionManager;

@end

@implementation LKUserSession

- (instancetype)initWithServer:(NSURL *)url {
    self = [super init];
    if (self) {
        _sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    }
    return self;
}

- (void)usernameHasPassword:(NSString *)username completion:(void (^)(BOOL hasPassword, NSError *error))completion {
    NSDictionary *params = @{@"username": username};
    [self.sessionManager GET:@"api/v1/users/has_password" parameters:params success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        BOOL hasPassword = [responseObject[@"has_password"] boolValue];
        completion(hasPassword, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        completion(NO, error);
    }];
}

- (void)setPassword:(NSString *)password forUsername:(NSString *)username completion:(void (^)())completion {
    NSDictionary *params = @{@"username": username, @"password": password };
    [self.sessionManager POST:@"api/v1/users/set_password" parameters:params success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        completion();
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
    }];
}

@end
