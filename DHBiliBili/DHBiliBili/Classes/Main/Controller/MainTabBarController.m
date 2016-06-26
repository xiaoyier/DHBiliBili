//
//  MainTabBarController.m
//  BiliBiliDemo
//
//  Created by XDH on 16/4/12.
//  Copyright © 2016年 XDH. All rights reserved.
//

#import "MainTabBarController.h"
#import "BaseNavigationController.h"

#import "HomePageViewController.h"
#import "FocusViewController.h"
#import "DiscoverTableViewController.h"
#import "MineTableVC.h"
#import "TabBarView.h"

@interface MainTabBarController ()<TabBarViewDelegate>
@property (strong , nonatomic) NSMutableArray *TabBarItemsArray;

@end
@implementation MainTabBarController
#pragma mark 懒加载
- (NSMutableArray *)TabBarItemsArray {
    if (_TabBarItemsArray == nil) {
        _TabBarItemsArray = [NSMutableArray array];
    }
    return  _TabBarItemsArray;
}

#pragma mark 生命周期
-(void)viewDidLoad {
    [super viewDidLoad];
    //初始化,添加所有子控制器
    [self AddChlidVCs];
    
    //创建XDHTabBarView
    TabBarView *tabBar = [[TabBarView alloc] init];
    tabBar.frame = self.tabBar.bounds;
    tabBar.TabBarItemsArray = self.TabBarItemsArray;
    
    tabBar.delegate = self;
    [self.tabBar addSubview:tabBar];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //遍历self.tabBar的子控件,如果不是TabBarView就移除
    for (UIView *view in self.tabBar.subviews) {
        if (! [view isKindOfClass:[TabBarView class]]) {
            [view removeFromSuperview];
        }
    }
}


//代理方法
#pragma mark - XDHTabBarViewDelegate
-(void)tabBarViewDidClickBtn:(UIButton *)btn {
    self.selectedIndex = btn.tag;

}

#pragma mark - 播放动画
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //播放动画
    [self playAnimation];
}

#pragma mark - 实现动画
-(void)playAnimation {
    //一次性代码
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        //播放动画
        UIImageView *launchV = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];

        launchV.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bilibili_splash_iphone_bg" ofType:@"png"]];

        [[UIApplication sharedApplication].keyWindow addSubview:launchV];


        CGFloat ratio = 1.0 * 841 / 640;
        CGFloat imageViewX = ([UIScreen mainScreen].bounds.size.width - 120)/2;
        CGFloat imageViewY = 100;
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(imageViewX, imageViewY, 150, 150*ratio)];
        imageV.center = CGPointMake([UIScreen mainScreen].bounds.size.width * 0.5, [UIScreen mainScreen].bounds.size.height * 0.3);

        imageV.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bilibili_splash_default@2x" ofType:@"png"]];
        [launchV addSubview:imageV];

        [UIView animateWithDuration:0.5 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            imageV.transform = CGAffineTransformScale(imageV.transform, 2.0, 2.0);
        } completion:^(BOOL finished) {


            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:0.3 animations:^{
                    imageV.alpha = 0;
                } completion:^(BOOL finished) {
                    [launchV removeFromSuperview];
                }];
            });
            
        }];
    });
}

#pragma mark -添加所有子控制器
-(void)AddChlidVCs {
    
    //首页
    HomePageViewController *homeVC = [[HomePageViewController alloc] init];
    [self addChildVc:homeVC title:@"首页" Imagename:@"index_normal" andWithSelImageName:@"index_selected"];
    
    //关注
    FocusViewController *followVC = [[FocusViewController alloc] init];
    [self addChildVc:followVC title:@"关注" Imagename:@"focus_normal" andWithSelImageName:@"focus_selected"];
    
    
    //发现
    DiscoverTableViewController *disVC = [[DiscoverTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self addChildVc:disVC title:@"发现" Imagename:@"find_normal" andWithSelImageName:@"find_selected"];
    
    //我的
    MineTableVC *mineVC = [[MineTableVC alloc] init];
    [self addChildVc:mineVC title:@"我的" Imagename:@"mine_normal" andWithSelImageName:@"mine_selected"];
    

    
}

#pragma mark 添加单个控制器
-(void)addChildVc:(UIViewController *)vc title:(NSString *)title Imagename:(NSString *)name andWithSelImageName:(NSString *)selImageName {

    //添加导航控制器
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    

    //设置数据
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:name];
    nav.tabBarItem.selectedImage = [UIImage imageNamed:selImageName];
    
    //设置导航控制器的标题
    vc.navigationItem.title = title;
    
    //将barIterm添加到数组中
    [self.TabBarItemsArray addObject:nav.tabBarItem];
    
    //将导航控制器添加到子控制器中
    [self addChildViewController:nav];
}

-(BOOL)shouldAutorotate{
    return NO;
}
@end
