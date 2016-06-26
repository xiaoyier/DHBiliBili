//
//  OverseasVC.m
//  BiliBiliDemo
//
//  Created by XDH on 16/4/23.
//  Copyright © 2016年 XDH. All rights reserved.
//

#import "WebViewController.h"

@import WebKit;
@interface WebViewController () <UIWebViewDelegate>

@property (strong , nonatomic) WKWebView *webView;
@end

@implementation WebViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.title]]];
    
    
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WKWebView *webView = [[WKWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.webView = webView;
    [self.view addSubview:webView];
}



@end
