//
//  TabBarView.h
//  BiliBiliDemo
//
//  Created by XDH on 16/4/12.
//  Copyright © 2016年 XDH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TabBarView;
@protocol TabBarViewDelegate <NSObject>

-(void)tabBarViewDidClickBtn:(UIButton *)btn;

@end
@interface TabBarView : UIView

@property (strong , nonatomic) NSArray *TabBarItemsArray;

@property (weak , nonatomic) id<TabBarViewDelegate> delegate;
@end
