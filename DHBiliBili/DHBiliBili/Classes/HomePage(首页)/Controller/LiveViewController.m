//
//  LiveViewController.m
//  DHBiliBili
//
//  Created by XDH on 16/6/15.
//  Copyright © 2016年 XDH. All rights reserved.
//

#import "LiveViewController.h"
#import "CommonCollectionViewCell.h"
#import "CommonTableViewCell.h"
//自定义按钮
#import "CommonButton.h"
//轮播图
#import "RoundView.h"

#import <AFNetworking/AFNetworking.h>
@interface LiveViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong , nonatomic) NSMutableArray *banners;
@property (weak , nonatomic) RoundView *roundV;
@end

static NSString  const *ID = @"cellID";
@implementation LiveViewController

-(NSMutableArray *)banners {
    if (_banners == nil) {
        _banners = [NSMutableArray array];
    }
    return _banners;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsMake(44, 0, 44, 0);
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
    //加载轮播图
    [self setupRoundView];
    
    //加载数据
    [self loadData];
}

- (void)setupRoundView {
    RoundView *roundV = [[RoundView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    self.tableView.tableHeaderView = roundV;
    _roundV = roundV;
}

- (void)loadData {
    NSString *url = @"http://live.bilibili.com/AppIndex/home?actionKey=appkey&appkey=27eb53fc9058f8c3&build=3390&device=phone&mobi_app=iphone&platform=ios&scale=2&sign=c36afbb510e939c8a3d7ffcf1ee1ce20&ts=1466263179";
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        NSArray *banners = responseObject[@"data"][@"banner"];
        for (NSDictionary *dict in banners) {
            NSMutableDictionary *banner = [NSMutableDictionary dictionaryWithObject:dict[@"img"] forKey:@"img"];
            [self.banners addObject:banner];
        }
        _roundV.banners = self.banners;
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}
- (UICollectionView *)setupCollectionView:(CGRect )rect {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat margin = 10;
    CGFloat width = (rect.size.width - 3 * margin) / 2;
    CGFloat height = 100;
    flowLayout.itemSize = CGSizeMake(width ,height);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    
    
    UICollectionView *collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220) collectionViewLayout:flowLayout];
    collectionV.backgroundColor = [UIColor whiteColor];
    collectionV.dataSource = self;
    collectionV.delegate = self;
    collectionV.showsVerticalScrollIndicator = NO;
    collectionV.bounces = NO;
    //注册cell
    [collectionV registerNib:[UINib nibWithNibName:@"CommonCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"commonCell"];
    
    return collectionV;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CommonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"commonCell" forIndexPath:indexPath];
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat margin = 10;
    CGFloat width = (XDHScreenW - 3 * margin) / 2;
    CGFloat height = 100;
    return CGSizeMake(width, height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 0, 10);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *ID = @"cellID";
    CommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CommonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    UICollectionView *collectionView = [self setupCollectionView:cell.bounds];
    [cell.contentView addSubview:collectionView];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    return 230 + 15;

    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
        view.backgroundColor = [UIColor blueColor];
        return view;

}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    return 30;
}


@end
