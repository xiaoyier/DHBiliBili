//
//  GlobalListViewController.m
//  DHBiliBili
//
//  Created by XDH on 16/5/10.
//  Copyright © 2016年 XDH. All rights reserved.
//

#import "GlobalListViewController.h"
#import "RankTableViewController.h"

@interface GlobalListViewController ()

@end

@implementation GlobalListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加所有子控制器
    [self addAllChildControllers];
}

-(void)addAllChildControllers {
    RankTableViewController *VC = [[RankTableViewController alloc] init];
    VC.title = @"番剧";
    VC.url = @"http://api.bilibili.com/list?_device=iphone&_hwid=33262ef86fceeb29&_ulv=0&access_key=&appkey=27eb53fc9058f8c3&appver=3110&build=3110&ios=0&order=hot&page=0&pagesize=20&platform=ios&tid=13&type=json&sign=4a761acaae8359a20e3cde058413379d";
    
    [self addChildViewController:VC];
    
    RankTableViewController *VC1 = [[RankTableViewController alloc] init];
    VC1.title = @"动画";
    VC1.url = @"http://api.bilibili.com/list?_device=iphone&_hwid=33262ef86fceeb29&_ulv=0&access_key=&appkey=27eb53fc9058f8c3&appver=3110&build=3110&ios=0&order=hot&page=0&pagesize=20&platform=ios&tid=1&type=json&sign=fce267512a6a3b02c08505dae349bf91";
    [self addChildViewController:VC1];
    
    
    RankTableViewController *VC2 = [[RankTableViewController alloc] init];
    VC2.title = @"音乐";
    VC2.url = @"http://api.bilibili.com/list?_device=iphone&_hwid=33262ef86fceeb29&_ulv=0&access_key=&appkey=27eb53fc9058f8c3&appver=3110&build=3110&ios=0&order=hot&page=0&pagesize=20&platform=ios&tid=3&type=json&sign=14bd17d6d9017d46d2644a29f424cc7c";
    [self addChildViewController:VC2];
    
    RankTableViewController *VC3 = [[RankTableViewController alloc] init];
    VC3.title = @"舞蹈";
    VC3.url = @"http://api.bilibili.com/list?_device=iphone&_hwid=33262ef86fceeb29&_ulv=0&access_key=&appkey=27eb53fc9058f8c3&appver=3110&build=3110&ios=0&order=hot&page=0&pagesize=20&platform=ios&tid=129&type=json&sign=a3e598714e418155aa5d29b01653d6eb";
    [self addChildViewController:VC3];
    
    RankTableViewController *VC4 = [[RankTableViewController alloc] init];
    VC4.title = @"游戏";
    VC4.url = @"http://api.bilibili.com/list?_device=iphone&_hwid=33262ef86fceeb29&_ulv=0&access_key=&appkey=27eb53fc9058f8c3&appver=3110&build=3110&ios=0&order=hot&page=0&pagesize=20&platform=ios&tid=4&type=json&sign=cd07d9691106d5ac1585d639ff173e7d";
    [self addChildViewController:VC4];
    
    RankTableViewController *VC5 = [[RankTableViewController alloc] init];
    VC5.title = @"科技";
    VC5.url = @"http://api.bilibili.com/list?_device=iphone&_hwid=33262ef86fceeb29&_ulv=0&access_key=&appkey=27eb53fc9058f8c3&appver=3110&build=3110&ios=0&order=hot&page=0&pagesize=20&platform=ios&tid=36&type=json&sign=c92823345509846b4b930ea49b7b13d7";
    [self addChildViewController:VC5];
    
    RankTableViewController *VC6 = [[RankTableViewController alloc] init];
    VC6.title = @"娱乐";
    VC6.url = @"http://api.bilibili.com/list?_device=iphone&_hwid=33262ef86fceeb29&_ulv=0&access_key=&appkey=27eb53fc9058f8c3&appver=3110&build=3110&ios=0&order=hot&page=0&pagesize=20&platform=ios&tid=5&type=json&sign=847af54b0c8d65ba0e46686d4d7b7e76";
    [self addChildViewController:VC6];
    
    RankTableViewController *VC7 = [[RankTableViewController alloc] init];
    VC7.title = @"鬼畜";
    VC7.url = @"http://api.bilibili.com/list?_device=iphone&_hwid=33262ef86fceeb29&_ulv=0&access_key=&appkey=27eb53fc9058f8c3&appver=3110&build=3110&ios=0&order=hot&page=0&pagesize=20&platform=ios&tid=119&type=json&sign=44e1047fa5e5952aceca4208ea25c0d3";
    [self addChildViewController:VC7];
    
    RankTableViewController *VC8 = [[RankTableViewController alloc] init];
    VC8.title = @"电影";
    VC8.url = @"http://api.bilibili.com/list?_device=iphone&_hwid=33262ef86fceeb29&_ulv=0&access_key=&appkey=27eb53fc9058f8c3&appver=3110&build=3110&ios=0&order=hot&page=0&pagesize=20&platform=ios&tid=23&type=json&sign=7c0af480127b9e472e57cb2f16fe1d3c";
    [self addChildViewController:VC8];
    
    RankTableViewController *VC9 = [[RankTableViewController alloc] init];
    VC9.title = @"电视剧";
    VC9.url = @"http://api.bilibili.com/list?_device=iphone&_hwid=33262ef86fceeb29&_ulv=0&access_key=&appkey=27eb53fc9058f8c3&appver=3110&build=3110&ios=0&order=hot&page=0&pagesize=20&platform=ios&tid=11&type=json&sign=dfc2e1036d42730ee6f36574d7abc806";
    [self addChildViewController:VC9];
    
    RankTableViewController *VC10 = [[RankTableViewController alloc] init];
    VC10.title = @"时尚";
    VC10.url = @"http://api.bilibili.com/list?_device=iphone&_hwid=33262ef86fceeb29&_ulv=0&access_key=&appkey=27eb53fc9058f8c3&appver=3110&build=3110&ios=0&order=hot&page=0&pagesize=20&platform=ios&tid=155&type=json&sign=662d1d122efcd20680477c298b7c0d3e";
    [self addChildViewController:VC10];
}

@end
