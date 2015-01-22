//
//  DTInstagramRequest.m
//  InstaArabic 2.0
//
//  Created by Didats on 9/15/14.
//  Copyright (c) 2014 Didats Triadi. All rights reserved.
//

#import "DTInstagramRequest.h"
#define apiVersion @"v1"

@implementation DTInstagramRequest

+ (DTInstagramRequest *)sharedInstance {
    static DTInstagramRequest *_sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.instagram.com/"]];
    });
    
    return _sharedInstance;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return self;
}


-(void) accessTokenWithClientSecret:(NSString *) secret redirectURL:(NSString *) redirect instagramID:(NSString *) instagramID code:(NSString *) code success:(void (^)(NSURLSessionDataTask *task, id responseObject)) success failure:(void(^) (NSURLSessionDataTask *task, NSError *error)) failure {
    
    [self POST:@"oauth/access_token" parameters:@{@"client_secret": secret, @"grant_type": @"authorization_code", @"redirect_uri": redirect, @"code": code, @"client_id": instagramID} success:success failure:failure];
}

-(void) allPhotosWithToken:(NSString *) token userID:(NSString *) userID andSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject)) success failure:(void(^) (NSURLSessionDataTask *task, NSError *error)) failure {
    
    NSLog(@"GET: %@", [NSString stringWithFormat:@"%@/users/%@/media/recent/?access_token=%@", apiVersion, userID, token]);
    
    [self GET:[NSString stringWithFormat:@"%@/users/%@/media/recent/?access_token=%@", apiVersion, userID, token] parameters:nil success:success failure:failure];
    
}

@end
