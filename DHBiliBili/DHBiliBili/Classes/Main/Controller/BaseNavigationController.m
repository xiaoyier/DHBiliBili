//
//  BaseNavigationController.m
//  BiliBiliDemo
//
//  Created by XDH on 16/4/12.
//  Copyright © 2016年 XDH. All rights reserved.
//

#import "BaseNavigationController.h"

@implementation BaseNavigationController


+(void)initialize {
    //设置NavigationBar的背景图片
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[BaseNavigationController class]]];
    
    //设置背景为白色
    bar.barTintColor = [UIColor whiteColor];
    bar.tintColor = [UIColor darkGrayColor];
    
    //设置图片
    CGFloat w = XDHScreenW;
    CGRect rect = CGRectMake(0, 0, w,1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor colorWithWhite:0.9 alpha:1].CGColor);
    CGContextFillRect(context, rect);
    UIImage *LightGrayImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    bar.shadowImage = LightGrayImg;
    
    
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    dict[NSFontAttributeName] = [UIFont boldSystemFontOfSize:15];
    
    bar.titleTextAttributes = dict;
    
    /************移除返回按钮的文字*****************/
    //获取按钮
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    //设置item文字向上偏移
    [item setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -64) forBarMetrics:UIBarMetricsDefault];
    

    
}

-(BOOL)shouldAutorotate{
    return NO;
}

@end
