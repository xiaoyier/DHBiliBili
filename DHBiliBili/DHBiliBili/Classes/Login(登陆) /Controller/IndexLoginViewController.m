//
//  IndexLoginViewController.m
//  DHBiliBili
//
//  Created by XDH on 16/5/13.
//  Copyright © 2016年 XDH. All rights reserved.
//

#import "IndexLoginViewController.h"

@implementation IndexLoginViewController
- (IBAction)dismiss:(UIBarButtonItem *)sender {
   
    [[UIApplication sharedApplication].keyWindow.rootViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)login {
     NSLog(@"登陆");
}

- (IBAction)Resgister {
    NSLog(@"注册");
}



@end
