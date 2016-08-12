//
//  ViewController.m
//  weexPageDemo
//
//  Created by junwen.deng on 16/8/11.
//  Copyright © 2016年 junwen.deng. All rights reserved.
//

#import "ViewController.h"
#import <WeexSDK/WeexSDK.h>
#import <SRWebSocket.h>

@interface ViewController ()

@property (nonatomic, readwrite, strong) WXSDKInstance *instance;
@property (nonatomic, weak) UIView *weexView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //在self.view上添加一个原生的按钮
    UIButton *testButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 64, 200, 100)];
    [self.view addSubview:testButton];
    [testButton setTitle:@"原生的button" forState:UIControlStateNormal];
    [testButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    //默认加载的地址为本地路径的bundlejs/index.js
    if (!self.url) {
        self.url = [[NSBundle mainBundle] pathForResource:@"bundlejs/index" ofType:@"js"];
    }
    [self render];//weex将js渲染成weex页面。
}

- (void)render{
    NSURL *URL = [[NSURL alloc] initFileURLWithPath:self.url];
    
    CGFloat width = self.view.frame.size.width;
    [_instance destroyInstance];
    _instance = [[WXSDKInstance alloc] init];
    _instance.viewController = self;
    _instance.frame = CGRectMake(self.view.frame.size.width-width, 200, width, self.view.frame.size.height);
    
    __weak typeof(self) weakSelf = self;
    _instance.onCreate = ^(UIView *view) {
        [weakSelf.weexView removeFromSuperview];
        weakSelf.weexView = view;
        [weakSelf.view addSubview:weakSelf.weexView];
    };
    
    NSString *randomURL = [NSString stringWithFormat:@"%@?random=%d",URL.absoluteString,arc4random()];
    [_instance renderWithURL:[NSURL URLWithString:randomURL] options:@{@"bundleUrl":URL.absoluteString} data:nil];
}

- (void)dealloc{
    [_instance destroyInstance];
}
@end
