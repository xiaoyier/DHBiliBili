//
//  BangumiViewController.m
//  DHBiliBili
//
//  Created by XDH on 16/6/15.
//  Copyright © 2016年 XDH. All rights reserved.
//

#import "BangumiViewController.h"
#import "CommonCollectionViewCell.h"
#import "CommonTableViewCell.h"
//自定义按钮
#import "CommonButton.h"
//轮播图
#import "RoundView.h"
#import "RankCellItem.h"
#import "DetailViewController.h"

#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>

@interface BangumiViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong , nonatomic) NSArray *icons;
@property (strong , nonatomic) NSArray *bangumiImg;
@property (strong , nonatomic) NSArray *cellItems;
@property (weak , nonatomic) RoundView *roundV;
@property (weak , nonatomic) UICollectionView *collectionV;
@end

static NSString  const *ID = @"cellID";

@implementation BangumiViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _icons = @[@{@"icon": @"home_region_icon_33" ,@"title": @"连载动画"},@{@"icon": @"home_region_icon_32" ,@"title": @"完结动画"},@{@"icon": @"home_region_icon_153" ,@"title": @"国产动画"},@{@"icon": @"home_region_icon_152" ,@"title": @"官方延伸"}];
    _bangumiImg = @[@"hd_home_bangumi_recommend",@"hd_home_bangumi_timeline",@"hd_home_bangumi_category"];
    
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
    NSString *url = @"http://app.bilibili.com/x/region/show/old?tid=13&plat=1";
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        NSDictionary *result = responseObject[@"result"];
        //转换模型
        NSArray *recommands = result[@"recommends"];
        _cellItems = [RankCellItem mj_objectArrayWithKeyValuesArray:recommands];
        //传递banners
        NSArray *banners = result[@"banners"];
        _roundV.banners = banners;
        [self.tableView reloadData];
        [self.collectionV reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}
#pragma mark - 创建collectionV
- (UICollectionView *)setupCollectionView:(CGRect )rect {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat margin = 10;
    CGFloat width = (rect.size.width - 3 * margin) / 2;
    CGFloat height = 120;
    flowLayout.itemSize = CGSizeMake(width ,height);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    
    
    UICollectionView *collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 130 * _cellItems.count / 2 ) collectionViewLayout:flowLayout];
    collectionV.backgroundColor = [UIColor whiteColor];
    collectionV.dataSource = self;
    collectionV.delegate = self;
    collectionV.showsVerticalScrollIndicator = NO;
    collectionV.bounces = NO;
    _collectionV = collectionV;
    //注册cell
    [collectionV registerNib:[UINib nibWithNibName:@"CommonCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"commonCell"];
    
    return collectionV;
}

#pragma mark - collectionV 的数据源和代理方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _cellItems.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CommonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"commonCell" forIndexPath:indexPath];
    cell.item = _cellItems[indexPath.row];
    NSLog(@"cell--%@",NSStringFromCGRect(cell.frame));
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat margin = 10;
    CGFloat width = (XDHScreenW - 3 * margin) / 2;
    CGFloat height = 120;
    return CGSizeMake(width, height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 0, 10);
}
#pragma mark - 监听cell的点击,并跳转控制器
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    RankCellItem *item = _cellItems[indexPath.row];
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    detailVC.imageUrl = item.pic;
    detailVC.aid = item.aid;
    detailVC.navigationController.navigationBarHidden = YES;
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
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
    
    if (indexPath.section == 0) {
        [self setupFirstCell:cell];
    }else if (indexPath.section == 1) {
        [self setupSecondCell:cell];
    }else {
        UICollectionView *collectionView = [self setupCollectionView:cell.bounds];
        [cell.contentView addSubview:collectionView];
    }
    
    return cell;
    
}

#pragma mark - 设置第一个cell
- (void)setupFirstCell:(UITableViewCell *)cell {
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    int count = 4;
    CGFloat btnW = 40;
    CGFloat btnH = 60;
    CGFloat x = 0;
    CGFloat y = (100 - btnH) / 2 ;
    CGFloat margin = (XDHScreenW - (40 * 4)) / 5;
    for (int i = 0; i < count; i++) {
        CommonButton * btn = [CommonButton buttonWithType:UIButtonTypeCustom];
        x = margin + i * (margin + btnW);
        btn.frame = CGRectMake(x, y, btnW, btnH);
        //取出字典
        NSDictionary *icon = _icons[i];
        [btn setImage:[UIImage imageNamed:icon[@"icon"]] forState:UIControlStateNormal];
        [btn setTitle:icon[@"title"] forState:UIControlStateNormal];
        
        [cell.contentView addSubview:btn];
    }
}
#pragma mark - 设置第二个cell
-(void)setupSecondCell:(UITableViewCell *)cell {
    cell.backgroundColor = [UIColor clearColor];
    int count = 3;
    CGFloat margin = 5;
    CGFloat btnW = (SCREEN_WIDTH - margin * (count + 1)) / count;
    CGFloat btnH = 45;
    
    for (int i = 0; i < count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:_bangumiImg[i]] forState:UIControlStateNormal];
        CGFloat btnX = margin + (margin + btnW) * i;
        btn.frame = CGRectMake(btnX, 0, btnW, btnH);
        [cell.contentView addSubview:btn];
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 100 + 15;
    } else if (indexPath.section == 1) {
        return 45 + 15;
    }
    else {
        return 130 * _cellItems.count / 2 + 10 + 15;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
        view.backgroundColor = [UIColor blueColor];
        return view;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 2) return 35;
    else return 0;
}

@end
