//
//  OriginalListViewController.m
//  DHBiliBili
//
//  Created by XDH on 16/5/10.
//  Copyright © 2016年 XDH. All rights reserved.
//

#import "OriginalListViewController.h"
#import "RankTableViewController.h"

@interface OriginalListViewController ()

@end

@implementation OriginalListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加所有子控制器
    [self addAllChildControllers];
    
}


-(void)addAllChildControllers {
    RankTableViewController *VC = [[RankTableViewController alloc] init];
    VC.title = @"原 创";
    VC.url = @"http://api.bilibili.com/list?_device=iphone&_hwid=33262ef86fceeb29&_ulv=0&access_key=&appkey=27eb53fc9058f8c3&appver=3110&build=3110&ios=0&order=hot&original=1&page=0&pagesize=20&platform=ios&type=json&sign=74bc8226510bef007f0830f84d5c86b4";
    

    [self addChildViewController:VC];
    
    RankTableViewController *VC1 = [[RankTableViewController alloc] init];
    VC1.title = @"全 站";
     VC1.url = @"http://api.bilibili.com/list?_device=iphone&_hwid=33262ef86fceeb29&_ulv=0&access_key=&appkey=27eb53fc9058f8c3&appver=3110&build=3110&ios=0&order=hot&page=0&pagesize=20&platform=ios&type=json&sign=734f187110f883d9e66d9ac3951d10be";
    
    [self addChildViewController:VC1];
    
    
    RankTableViewController *VC2 = [[RankTableViewController alloc] init];
    VC2.title = @"新 番";
    VC2.url = @"http://api.bilibili.com/list?_device=iphone&_hwid=33262ef86fceeb29&_ulv=0&access_key=&appkey=27eb53fc9058f8c3&appver=3110&build=3110&ios=0&order=hot&page=0&pagesize=20&platform=ios&tid=33&type=json&sign=8aca3a8cf2844ddad085db16639df3eb";
    [self addChildViewController:VC2];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
