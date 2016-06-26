//
//  AppDelegate.m
//  BiliBiliDemo
//
//  Created by XDH on 16/4/12.
//  Copyright © 2016年 XDH. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //1创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //2设置窗口的根控制器
    MainTabBarController *tabVC = [[MainTabBarController alloc] init];
    [self.window setRootViewController:tabVC];
    
    //3显示窗口
    [self.window makeKeyAndVisible];
    
   
    return YES;
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication*)application
{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

////支持横屏
//-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
//    return self.window.rootViewController.supportedInterfaceOrientations;
//}

@end
