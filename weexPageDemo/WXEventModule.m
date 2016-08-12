/**
 * Created by Weex.
 * Copyright (c) 2016, Alibaba, Inc. All rights reserved.
 *
 * This source code is licensed under the Apache Licence 2.0.
 * For the full copyright and license information,please view the LICENSE file in the root directory of this source tree.
 */

#import "WXEventModule.h"
#import "ViewController.h"
#import <WeexSDK/WXBaseViewController.h>

@implementation WXEventModule

@synthesize weexInstance;

WX_EXPORT_METHOD(@selector(openURL:))

//这个openURL 对应的是weex.js文件中的openURL的方法。js调用openURL则通过runtime执行到native的这个openURL方法
- (void)openURL:(NSString *)url
{
    NSString *newURL = url;
    newURL = [newURL stringByReplacingOccurrencesOfString:@"//Users/examples/build/" withString:@"/bundlejs/"];
//    newURL = [newURL stringByReplacingOccurrencesOfString:@"//var/examples/build/" withString:@"/bundlejs/"];

    newURL = [[[NSBundle mainBundle] bundlePath] stringByAppendingString:newURL];;
    UIViewController *controller = [[ViewController alloc] init];
    ((ViewController *)controller).url = newURL;
    
    [[weexInstance.viewController navigationController] pushViewController:controller animated:YES];
}

@end

