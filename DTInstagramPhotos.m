//
//  DTInstagramPhotos.m
//  InstaArabic 2.0
//
//  Created by Didats on 9/14/14.
//  Copyright (c) 2014 Didats Triadi. All rights reserved.
//

#import "DTInstagramPhotos.h"
#import "GSKeychain.h"
#import "RegExCategories.h"
#import "DTInstagramRequest.h"

#define INSTAGRAM_ID @""
#define INSTAGRAM_REDIRECT @"your_app_name://authorize"
#define INSTAGRAM_SECRET @""

@implementation DTInstagramPhotos

+(id) init {
    if ([super init] == self) {
        
        [DTInstagramRequest sharedInstance];
        
    }
    return self;
}

-(BOOL) loggingIn {
    
    NSLog(@"LOGGING INSIDE");
    
    if (![[[GSKeychain systemKeychain] secretForKey:@"instagram_token"] isKindOfClass:[NSString class]] || [[[NSUserDefaults standardUserDefaults] objectForKey:@"instagram_user"] length] == 0) {
        // force to login first
        NSString *strURL = [NSString stringWithFormat:@"https://api.instagram.com/oauth/authorize/?client_id=%@&redirect_uri=%@&response_type=code", INSTAGRAM_ID, INSTAGRAM_REDIRECT];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strURL]];
        return NO;
    }
    else return YES;
}
// success:(void (^)(NSURLSessionDataTask *task, id responseObject)) success
-(void) getPhotos:(void (^)(id JSON)) success {
    NSLog(@"GET PHOTOS");
    if ([[[GSKeychain systemKeychain] secretForKey:@"instagram_token"] isKindOfClass:[NSString class]]) {
    
        NSDictionary *instagramDetails = [[NSUserDefaults standardUserDefaults] objectForKey:@"instagram_user"];
        [[DTInstagramRequest sharedInstance] allPhotosWithToken:[[GSKeychain systemKeychain] secretForKey:@"instagram_token"] userID:[instagramDetails objectForKey:@"id"] andSuccess:^(NSURLSessionDataTask *task, id responseObject) {
            success(responseObject);
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"FAIL TO GET PHOTOS");
            [SVProgressHUD dismiss];
        }];
    }
}

+(void) handleURL:(NSURL *) url {
    NSString *strURL = [NSString stringWithFormat:@"%@", url];
    
    NSLog(@"Handle 123: %@", strURL);
    
    NSString *code;
    if ([strURL isMatch:RX(@"code=[a-zA-Z0-9]{1,}")]) {
        code = [[strURL firstMatch:RX(@"code=[a-zA-Z0-9]{1,}")] stringByReplacingOccurrencesOfString:@"code=" withString:@""];
    }
    
    [[DTInstagramRequest sharedInstance] accessTokenWithClientSecret:INSTAGRAM_SECRET redirectURL:INSTAGRAM_REDIRECT instagramID:INSTAGRAM_ID code:code success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"Handle Response: %@", responseObject);
        
        // access token received
        [[GSKeychain systemKeychain] setSecret:[responseObject objectForKey:@"access_token"] forKey:@"instagram_token"];
        
        // user details
        [[NSUserDefaults standardUserDefaults] setObject:[responseObject objectForKey:@"user"] forKey:@"instagram_user"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DTInstagram" object:nil userInfo:@{@"type": @"readyGetPhoto"}];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Handle Error: %@", error);
    }];
    
}

@end
