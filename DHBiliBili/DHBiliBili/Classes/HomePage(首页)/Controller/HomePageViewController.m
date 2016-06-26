//
//  HomePageViewController.m
//  DHBiliBili
//
//  Created by XDH on 16/6/14.
//  Copyright © 2016年 XDH. All rights reserved.
//

#import "HomePageViewController.h"
#import "LiveViewController.h"
#import "RecommandViewController.h"
#import "BangumiViewController.h"
#import "CategoryViewController.h"

@interface HomePageViewController ()

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    //添加所有子控制器
    [self addAllChildControllers];
    
    [super viewDidLoad];
    
    //隐藏navigationBar
    self.navigationController.navigationBarHidden = YES;
    
    
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


- (void)addAllChildControllers {
    
    //直播
//    LiveViewController *live = [[LiveViewController alloc]init];
//    live.title = @"直播";
//    [self addChildViewController:live];
    
    //推荐
    RecommandViewController *recommandVC = [[RecommandViewController alloc] init];
    recommandVC.title = @"推 荐";
    [self addChildViewController:recommandVC];
    
    //番剧
    BangumiViewController *bangumiVC = [[BangumiViewController alloc] init];
    bangumiVC.title = @"番剧";
    [self addChildViewController:bangumiVC];
    
    //分区
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"CategoryViewController" bundle:nil];
    CategoryViewController *categoryVC = [storyBoard instantiateInitialViewController];
    categoryVC.title = @"分 区";
    [self addChildViewController:categoryVC];
    
}



@end
