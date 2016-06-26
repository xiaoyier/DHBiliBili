//
//  DetailViewController.h
//  DHBiliBili
//
//  Created by XDH on 16/5/31.
//  Copyright © 2016年 XDH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
//图片路径
@property (strong , nonatomic) NSString *imageUrl;
//编号
@property (strong , nonatomic) NSString *aid;
//返回时是否显示导航条
@property (assign , nonatomic) BOOL showNaviBar;
@end
