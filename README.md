[![Rimbunesia](http://rimbunesia.com/images/github-rimbunesia.png)](http://rimbunesia.com)

# DTInstagramPhotos
Get instagram photos from their API for iOS

## Dependencies
This library will not work without the support of these great open source libraries:  
1. [AFNetworking 2.x](https://github.com/AFNetworking/AFNetworking)  
2. [GSKeychain](https://github.com/goosoftware/GSKeychain)  
3. [RegExCategories](https://github.com/bendytree/Objective-C-RegEx-Categories)  

## How to use
1. Register your app on the developer account  
 - Go to the [Register New Client page](http://instagram.com/developer/clients/register/)  
 - Put your REDIRECT URI as this format: **yourappname://authorize**. This is a scheme URL you will gonna register on the xcode  
 - Put your `APP_ID`, `APP_SECRET`, and `REDIRECT_URI` on the `DTInstagramPhotos.m`

2. Set up your scheme URL on xcode  
Go to your **Project Target**, on the **Info** tab at the bottom you will see the **URL Types**. Add new URL Type, on the **URL Schemes** put yourappname (the same as the above).  

3. Drag all the files here to your project  

4. Edit AppDelegate.m  
Put `#import "DTInstagramPhotos.h"` at the top, and put this code at the bottom:  

```ObjectiveC
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
  [DTInstagramPhotos handleURL:url];
  return YES;
}
```

5. On your ViewController.m (It can be any file) you wanted  
Put `#import "DTInstagramPhotos.h"` at the top,  and followed by:

```ObjectiveC
@interface ViewController () {
    DTInstagramPhotos *instagram;
}
```

```ObjectiveC
instagram = [[DTInstagramPhotos alloc] init];
if ([instagram loggingIn]) {
    [instagram getPhotos:^(id JSON) {
        NSLog(@"All Photos: %@", JSON);
    }];
}
```

Receive the notification when the user logged in for the first time  

```ObjectiveC
-(void) viewWillAppear:(BOOL)animated {
  // notification to receive the photos when user logged in for the first time
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DTInstagramNotification:) name:@"DTInstagram" object:nil];
}

-(void) DTInstagramNotification:(NSNotification *) notification {
  NSDictionary *notificationData = notification.userInfo;
  if ([[notificationData objectForKey:@"type"] isEqualToString:@"readyGetPhoto"]) {
    [instagram getPhotos:^(id JSON) {
      NSLog(@"All Photos: %@", JSON);
    }];
  }
}
```

##Contact
I wrote this code for my own use, and making it available to anyone for the benefit of iOS Developer community.  

You are not encourage to do, but sure I will be glad if you buy one of my apps here.   [http://appstore.com/dianagustriadi](http://appstore.com/dianagustriadi)  

If you have any questions regarding this code, you could contact me here:  
Website: [http://didatstriadi.com](http://didatstriadi.com)  
Twitter: [@didats](http://twitter.com/didats)  

If you have any project to share with me, you could contact my team below. We are available for iOS and Android Development from the scratch with affordable price:  
Website: [http://rimbunesia.com](http://rimbunesia.com)

##License
This code is distributed under the terms and conditions of the MIT license.

Copyright (c) 2015 Didats Triadi

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
