//
//  RecommandViewController.m
//  DHBiliBili
//
//  Created by XDH on 16/6/15.
//  Copyright © 2016年 XDH. All rights reserved.
//

#import "RecommandViewController.h"
#import "RecommandCollectionViewCell.h"
#import "CommonTableViewCell.h"
//自定义按钮
#import "CommonButton.h"
//轮播图
#import "RoundView.h"
#import "RankCellItem.h"
#import "DetailViewController.h"
#import "RecommandCellItem.h"
//模型转换
#import "ModelChangeTool.h"

#import "SectionHeaderView.h"

#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>



@interface RecommandViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong , nonatomic) NSArray *cellItems;
@property (weak , nonatomic) RoundView *roundV;
@property (weak , nonatomic) UICollectionView *collectionV;

@end

@implementation RecommandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsMake(44, 0, 44, 0);
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    //加载轮播图
    [self setupRoundView];
    
    //加载轮播图
    [self loadBannerData];
    
    //加载数据
    [self loadData];
    
}

- (void)loadData {
    NSString *url = @"http://app.bilibili.com/x/show/hot?actionKey=appkey&appkey=27eb53fc9058f8c3&build=3390&channel=appstore&device=phone&mobi_app=iphone&plat=1&platform=ios";
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        NSArray *data = responseObject[@"data"];
       _cellItems = [RecommandCellItem mj_objectArrayWithKeyValuesArray:data];
        [self.collectionV reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)loadBannerData {
    NSString *url = @"http://app.bilibili.com/x/banner?build=3390&channel=appstore&plat=2";
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        NSArray *data = responseObject[@"data"];
        NSMutableArray *banners = [NSMutableArray array];
        for (NSDictionary *dict in data) {
            NSMutableDictionary *banner = [NSMutableDictionary dictionary];
            [banner setObject:dict[@"image"] forKey:@"img"];
            [banners addObject:banner];
        }
        _roundV.banners = banners;
        [self.tableView reloadData];
      
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}


- (void)setupRoundView {
    RoundView *roundV = [[RoundView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    self.tableView.tableHeaderView = roundV;
    _roundV = roundV;
}

#pragma mark - 创建collectionV
- (UICollectionView *)setupCollectionView:(CGRect )rect {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat margin = 10;
    CGFloat width = (rect.size.width - 3 * margin) / 2;
    CGFloat height = 140;
    flowLayout.itemSize = CGSizeMake(width ,height);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    
    
    UICollectionView *collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300) collectionViewLayout:flowLayout];
    collectionV.backgroundColor = [UIColor whiteColor];
    collectionV.dataSource = self;
    collectionV.delegate = self;
    collectionV.showsVerticalScrollIndicator = NO;
    collectionV.bounces = NO;
    _collectionV = collectionV;
    //注册cell
    [collectionV registerNib:[UINib nibWithNibName:@"RecommandCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"RecommandCell"];
    
    return collectionV;
}

#pragma mark - collectionV 的数据源和代理方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _cellItems.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RecommandCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RecommandCell" forIndexPath:indexPath];
    cell.item = _cellItems[indexPath.row];
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat margin = 10;
    CGFloat width = (XDHScreenW - 3 * margin) / 2;
    CGFloat height = 140;
    return CGSizeMake(width, height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 0, 10);
}
#pragma mark - 监听cell的点击,并跳转控制器
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //模型转换
    RankCellItem *item = [ModelChangeTool RecommandCellItemToRankcellItem:_cellItems[indexPath.row]];
    
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    detailVC.imageUrl = item.pic;
    detailVC.aid = item.aid;
    detailVC.navigationController.navigationBarHidden = YES;
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
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
    return 310 + 15;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SectionHeaderView *view = [[SectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    view.icon = @"hd_home_recommend";
    view.title = @"热门推荐";
    return view;

}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
   return 30;
}
@end
