//
//  TabBarView.m
//  BiliBiliDemo
//
//  Created by XDH on 16/4/12.
//  Copyright © 2016年 XDH. All rights reserved.
//

#import "TabBarView.h"
#import "TabBarBtn.h"

@interface TabBarView ()

//上一个被选中的按钮
@property (weak , nonatomic) UIButton *preSelBtn;

@end
@implementation TabBarView


-(void)setTabBarItemsArray:(NSArray *)TabBarItemsArray {
    _TabBarItemsArray = TabBarItemsArray;
    //遍历数组
    for (int i = 0; i < self.TabBarItemsArray.count; i++) {
        
        //取出模型
        UITabBarItem *item = self.TabBarItemsArray[i];
        
        TabBarBtn *btn = [TabBarBtn buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        //设置normal状态下的图片
        [btn setBackgroundImage:item.image forState:UIControlStateNormal];
        //设置selected状态下的图片
        [btn setBackgroundImage:item.selectedImage forState:UIControlStateSelected];
        
        //监听按钮的点击
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
        //默认选中第一个按钮
        if (i == 0) {
            [self click:btn];
        }
        
        //将btn添加为子控件
        [self addSubview:btn];
        
    }
}

- (void)layoutSubviews {
    //设置Tabbar背景为白色
    self.backgroundColor = [UIColor whiteColor];
    //取出每一个子控件,设置frame
    CGFloat w = 49;
    CGFloat h = 49;
    CGFloat space = (self.xdh_width - w * self.subviews.count)/ self.subviews.count ;
    CGFloat x = 0;
    CGFloat y = 0;

    for (TabBarBtn *btn in self.subviews) {
        x = 0.5 * space + (space +w) * btn.tag ;
        btn.frame = CGRectMake(x, y, w, h);

    }
}
-(void)click:(UIButton *)btn {
    //让上一个按钮取消选中
    self.preSelBtn.selected = NO;
    //让当前的按钮成为选中
    btn.selected = YES;
    //让当前按钮成为上一个按钮
    self.preSelBtn = btn;
    
    //通知代理调用方法
    if ([self.delegate respondsToSelector:@selector(tabBarViewDidClickBtn:)]) {
        [self.delegate tabBarViewDidClickBtn:btn];
    }
    
}
@end
