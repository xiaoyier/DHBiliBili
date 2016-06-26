//
//  DiscoverTableVC.m
//  BiliBiliDemo
//
//  Created by XDH on 16/4/12.
//  Copyright © 2016年 XDH. All rights reserved.
//

#import "DiscoverTableViewController.h"
#import "WebViewController.h"
#import "GameCenterCollectionViewController.h"
#import "OriginalListViewController.h"
#import "GlobalListViewController.h"
#import "BaseNavigationController.h"
#import "LoginRegisterViewController.h"

#import "SearchView.h"
#import "SearchTagItem.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
@interface DiscoverTableViewController () <searchButtonDelegate>
@property (weak , nonatomic) SearchView *headView;


@end
@implementation DiscoverTableViewController
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //隐藏导航栏
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SearchView *headView = [SearchView loadView];
    headView.frame = CGRectMake(0, 0, XDHScreenW, 200);
    headView.delegate = self;
    self.tableView.tableHeaderView = headView;
    self.headView = headView;
    
    //请求tag数据
    [self loadTagData];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 请求tag的数据
-(void)loadTagData {
    
    NSString *urlStr = @"http://s.search.bilibili.com/main/hotword?actionKey=appkey&appkey=27eb53fc9058f8c3&build=3110&device=phone&platform=ios&sign=846a3e5a0c6b3ed23b931276267f9436&ts=1461381244";
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
        //设置可以交互
        self.headView.viewMoreBtn.userInteractionEnabled = YES;
        
        NSArray *tagDicts = responseObject[@"list"];
        self.headView.tagItems = [SearchTagItem mj_objectArrayWithKeyValuesArray:tagDicts];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 1 || section == 2 ) return 2;
    return 1;
}

static NSString * const ID = @"discover";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.textColor = [UIColor colorWithWhite:0.1 alpha:0.9];
    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jiantou_you"]];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:241/255.0 alpha:1];
    view.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 40, 1);
    view.frame = CGRectMake(20, 0, [UIScreen mainScreen].bounds.size.width - 20, 1);
    
    //设置cell选中还是无色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        cell.textLabel.text  = @"兴趣圈";
        cell.imageView.image = [UIImage imageNamed:@"xingququan"];
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.textLabel.text  = @"原创排行榜";
            cell.imageView.image = [UIImage imageNamed:@"yuanchuangpaihangbang"];
        } else {
        [cell.contentView addSubview:view];
        cell.textLabel.text  = @"全区排行榜";
        cell.imageView.image = [UIImage imageNamed:@"quanqupaihangbang"];
        }
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            cell.textLabel.text  = @"游戏中心";
            cell.imageView.image = [UIImage imageNamed:@"youxizhongxing"];
        } else {
            [cell.contentView addSubview:view];
            cell.textLabel.text  = @"海外游";
            cell.imageView.image = [UIImage imageNamed:@"haiwaiyou"];
        }

    }
    
 
    return cell;
}
//设置section高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
#pragma mark -设置Section间距
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,1 )];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 12;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,1 )];
    view.backgroundColor = [UIColor clearColor];
    return view;
    
}

#pragma mark - 按钮点击,实现代理方法
-(void)buttonClicked:(UIButton *)sender {
    
    if ([sender isKindOfClass:NSClassFromString(@"SearchTagButton")]) {
        NSLog(@"%@",sender.titleLabel.text);
    } else if ([sender isKindOfClass:[UIButton class]]) {
        self.tableView.tableHeaderView = self.headView;
    }
    
}


#pragma mark - 跳转控制器
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"LoginRegisterViewController"  bundle:nil];
        LoginRegisterViewController *loginVC = [storyBoard instantiateInitialViewController];
        loginVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:loginVC animated:YES completion:nil];
        
    } else if (indexPath.section == 1 && indexPath.row == 1) {
        GlobalListViewController *VC = [[GlobalListViewController alloc] init];
        VC.hidesBottomBarWhenPushed = YES;
        VC.navigationController.navigationBarHidden = YES;
        [self.navigationController pushViewController:VC animated:YES];
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        OriginalListViewController *VC = [[OriginalListViewController alloc] init];
        VC.hidesBottomBarWhenPushed = YES;
        VC.navigationController.navigationBarHidden = YES;
        [self.navigationController pushViewController:VC animated:YES];
        
    } else if (indexPath.section == 2 && indexPath.row == 1) {
        WebViewController *VC = [[WebViewController alloc] init];
        VC.view.backgroundColor = [UIColor lightGrayColor];
        VC.title = @"http://yoo.bilibili.com/html/indexm.html";
        [self.navigationController pushViewController:VC animated:YES];
    } else if (indexPath.section == 2 && indexPath.row == 0) {
        GameCenterCollectionViewController *VC = [[GameCenterCollectionViewController alloc] init];
        VC.view.backgroundColor = [UIColor lightGrayColor];
        VC.title = @"游戏中心";
        [self.navigationController pushViewController:VC animated:YES];
    }
    
}

-(BOOL)shouldAutorotate{
    return NO;
}
@end
