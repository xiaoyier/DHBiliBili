//
//  LoginRegisterViewController.m
//  DHBiliBili
//
//  Created by XDH on 16/5/13.
//  Copyright © 2016年 XDH. All rights reserved.
//

#import "LoginRegisterViewController.h"

@interface LoginRegisterViewController ()<UINavigationBarDelegate>

@end

@implementation LoginRegisterViewController

+(void)initialize {
    // Do any additional setup after loading the view
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:[self class], nil];
    bar.barTintColor = [UIColor whiteColor];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
