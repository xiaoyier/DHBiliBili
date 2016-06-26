//
//  RankTableViewController.m
//  DHBiliBili
//
//  Created by XDH on 16/5/10.
//  Copyright © 2016年 XDH. All rights reserved.
//
#import "RankTableViewController.h"
#import "RankCellItem.h"
#import "RankCell.h"
#import "DetailViewController.h"

#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>

@interface RankTableViewController ()
@property (weak , nonatomic) AFHTTPSessionManager *manager;
@property (strong , nonatomic) NSMutableArray *cellItems;
@end
@implementation RankTableViewController
static NSString * const ID = @"cell";
-(NSMutableArray *)cellItems {
    if (_cellItems == nil) {
        _cellItems = [NSMutableArray array];
    }
    return _cellItems;
}
-(AFHTTPSessionManager *)manager {
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    //设置内边距
    self.tableView.contentInset = UIEdgeInsetsMake(35, 0, 0, 0);
    
    //加载数据
    [self loadData];
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"RankCell" bundle:nil] forCellReuseIdentifier:ID];
    
    //取消分隔线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
}
-(void)loadData {
    [self.manager GET:self.url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
        NSDictionary *dictList = responseObject[@"list"];
        [dictList writeToFile:@"/Users/apple/Desktop/BiliBiliDemoXdh/DHBiliBili/list.plist" atomically:YES];
        for (int i = 0; i < 20 ; i ++) {
            //取出list字典中的每个字典
            NSDictionary *itemDict = [dictList valueForKey:[NSString stringWithFormat:@"%d",i]] ;
           RankCellItem *item = [RankCellItem mj_objectWithKeyValues:itemDict];
            item.no = [NSString stringWithFormat:@"%d",i + 1];
            [self.cellItems addObject:item];
        }
        //刷新数据
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%ld",self.cellItems.count);
    return self.cellItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RankCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell.item = self.cellItems[indexPath.row];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}
/*
http://app.bilibili.com/x/view?actionKey=appkey&aid=4596515&appkey=27eb53fc9058f8c3&build=3220&device=phone&plat=0&platform=ios
 
http://app.bilibili.com/x/view?actionKey=appkey&aid=4596515&appkey=27eb53fc9058f8c3&build=3220&device=phone&plat=0&platform=ios
 

 http://app.bilibili.com/x/view?actionKey=appkey&aid=4606803&appkey=27eb53fc9058f8c3&build=3220&device=phone&plat=0&platform=ios&sign=ba189f4f3f6b5c9894b5867f1f47a64d&ts=1463137860
 
 
 http://app.bilibili.com/x/view?actionKey=appkey&aid=4606803&appkey=27eb53fc9058f8c3&build=3220&device=phone&plat=0&platform=ios&sign=8bf3b679b0b1991b2a3496d463bc1bf5&ts=1463138812
 
 
 */

#pragma mark - Table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RankCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"%@",cell.item);
    
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    detailVC.imageUrl = cell.item.pic;
    detailVC.aid = cell.item.aid;
    detailVC.navigationController.navigationBarHidden = YES;
    
    [self.navigationController pushViewController:detailVC animated:YES];
}
-(void)viewWillDisappear:(BOOL)animated {
    //取消所有任务
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [super viewWillDisappear:animated];
}
-(void)dealloc {
    NSLog(@"%s",__func__);
}

-(BOOL)shouldAutorotate{
    return NO;
}
@end
