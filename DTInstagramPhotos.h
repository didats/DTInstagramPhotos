//
//  DTInstagramPhotos.h
//  InstaArabic 2.0
//
//  Created by Didats on 9/14/14.
//  Copyright (c) 2014 Didats Triadi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTInstagramPhotos : NSObject <UIWebViewDelegate> {
    UIWebView *webView;
}

-(BOOL) loggingIn;
-(void) getPhotos:(void (^)(id JSON)) success;
+(void) handleURL:(NSURL *) url;


@end
