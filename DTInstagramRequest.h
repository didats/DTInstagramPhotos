//
//  DTInstagramRequest.h
//  InstaArabic 2.0
//
//  Created by Didats on 9/15/14.
//  Copyright (c) 2014 Didats Triadi. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface DTInstagramRequest : AFHTTPSessionManager

+ (DTInstagramRequest *)sharedInstance;
- (instancetype)initWithBaseURL:(NSURL *)url;

// @{@"client_secret": INSTAGRAM_SECRET, @"grant_type": @"authorization_code", @"redirect_uri": INSTAGRAM_REDIRECT, @"code": code, @"client_id": INSTAGRAM_ID}

-(void) accessTokenWithClientSecret:(NSString *) secret redirectURL:(NSString *) redirect instagramID:(NSString *) instagramID code:(NSString *) code success:(void (^)(NSURLSessionDataTask *task, id responseObject)) success failure:(void(^) (NSURLSessionDataTask *task, NSError *error)) failure;

-(void) allPhotosWithToken:(NSString *) token userID:(NSString *) userID andSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject)) success failure:(void(^) (NSURLSessionDataTask *task, NSError *error)) failure;

@end
