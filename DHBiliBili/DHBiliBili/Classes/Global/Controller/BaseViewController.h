//
//  BaseViewController.h
//  DHBiliBili
//
//  Created by XDH on 16/6/18.
//  Copyright © 2016年 XDH. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BaseViewController : UIViewController


/**
 *  设置导航栏后退按钮
 */
- (void) setBackBtn;


#pragma mark - 菊花转
/**
 *  @author YYang, 16-01-31 22:01:26
 *
 *  展示菊花
 *
 */
- (void) showHudWithMsg:(NSString *)msg;
/**
 *  @author YYang, 16-01-31 22:01:38
 *
 *  隐藏菊花
 */
- (void) hideHud;



@end
