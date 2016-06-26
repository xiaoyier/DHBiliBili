//
//  DetailViewController.m
//  DHBiliBili
//
//  Created by XDH on 16/5/31.
//  Copyright © 2016年 XDH. All rights reserved.
//
#import <AVKit/AVKit.h>
#import <MediaPlayer/MediaPlayer.h>

#import "DetailViewController.h"
#import "RankCell.h"
#import "DetailViewItem.h"
#import "ModelChangeTool.h"

#import "LRLAVPlayerView.h"

#import <UIImageView+WebCache.h>
#import <AFHTTPSessionManager.h>
#import <MJExtension/MJExtension.h>

@interface DetailViewController()<UITableViewDataSource,UITableViewDelegate,LRLAVPlayDelegate,AVPictureInPictureControllerDelegate>

//tableView
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//图片
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
//马赛克
@property (weak, nonatomic) IBOutlet UIVisualEffectView *visualEffectView;
//标题
@property (weak, nonatomic) IBOutlet UILabel *titleL;
//播放按钮
@property (weak, nonatomic) IBOutlet UIButton *playBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLCenterX;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playBtnLeading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playBtnBottom;

@property (strong , nonatomic) NSString *videoUrl;
@property (strong , nonatomic) AFHTTPSessionManager *mgr;
@property (strong , nonatomic) NSMutableArray *relates;
@property (nonatomic, strong) LRLAVPlayerView * avplayerView;
@property (weak, nonatomic) IBOutlet UIView *topView;


@end

@implementation DetailViewController

-(AFHTTPSessionManager *)mgr {
    if (_mgr == nil) {
        _mgr = [AFHTTPSessionManager manager];
    }
    return _mgr;
}
-(NSMutableArray *)relates {
    if (_relates == nil) {
        _relates = [NSMutableArray array];
    }
    return _relates;
}
static NSString *ID = @"cell";
-(void)viewDidLoad{
    [super viewDidLoad];
    
    //初始化
    [self setup];
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"RankCell" bundle:nil] forCellReuseIdentifier:ID];
    
    //获取视频地址
    [self loadVideoUrl];
    
    //加载数据
    [self loadData];
    
    
}

//更改statusBar颜色
-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
#pragma mark - 初始化
- (void)setup {
    
    NSLog(@"%@",self.navigationController);
    //设置tableView的代理和数据源
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //设置tableView的内边距
    self.tableView.contentInset = UIEdgeInsetsMake(244, 0, 0, 0);
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    //加载图片
    [_imageV sd_setImageWithURL:[NSURL URLWithString:_imageUrl]];
    //设置标题
    _titleL.text = [NSString stringWithFormat:@"AV%@",_aid];
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"RankCell" bundle:nil] forCellReuseIdentifier:ID];
}
#pragma mark - 播放视频
- (IBAction)playBtnClick {
    [self createAVPlayerView];
    _playBtn.enabled = NO;
}
#pragma mark - 创建用于播放的View
-(void)createAVPlayerView{
    //固定的实例化方法
    self.avplayerView = [LRLAVPlayerView avplayerViewWithVideoUrlStr:_videoUrl andInitialHeight:200.0 andSuperView:self.view];

    
    self.avplayerView.delegate = self;
    [self.view addSubview:self.avplayerView];
    __weak DetailViewController *weakSelf = self;
    //我的播放器依赖 Masonry 第三方库
    [self.avplayerView setPositionWithPortraitBlock:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).with.offset(60);
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
        //添加竖屏时的限制, 这条也是固定的, 因为: _videoHeight 是float* 类型, 我可以通过它, 动态改视频播放器的高度;
        make.height.equalTo(@(*(weakSelf.avplayerView->_videoHeight)));
    } andLandscapeBlock:^(MASConstraintMaker *make) {
        make.width.equalTo(@(SCREEN_HEIGHT));
        make.height.equalTo(@(SCREEN_WIDTH));
        make.center.equalTo(Window);
    }];
    
    //    self.PiPVc = [[AVPictureInPictureController alloc] initWithPlayerLayer:(AVPlayerLayer *)self.avplayerView.layer];
    //    self.PiPVc.delegate = self;
    //    [self.PiPVc startPictureInPicture];
}

#pragma mark - 关闭设备自动旋转, 然后手动监测设备旋转方向来旋转avplayerView
-(BOOL)shouldAutorotate{
    return NO;
}


#pragma mark - 加载视频地址
-(void)loadVideoUrl {
    NSString *urlStr = [NSString stringWithFormat:@"http://www.bilibili.com/m/html5?aid=%@&page=1",_aid];
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        _videoUrl = responseObject[@"src"];
        NSLog(@"%@",_videoUrl);
        _playBtn.enabled = YES;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


#pragma mark - 加载数据
-(void)loadData {
    
    NSString *urlStr = [NSString stringWithFormat:@"http://app.bilibili.com/x/view?actionKey=appkey&aid=%@&appkey=27eb53fc9058f8c3&build=3300&device=phone&plat=0&platform=ios&sign=4b7ff3c1e4d89f01751ef9adc4b8c6f1&ts=1464156040",_aid];
    
    [self.mgr GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        [responseObject writeToFile:@"/Users/apple/Desktop/detail.plist" atomically:YES];
        NSDictionary *temp = responseObject[@"data"];
        NSArray *relates = temp[@"relates"];
        if (relates.count != 0) {
            //转换为detailViewItem
            NSArray *detailItems = [DetailViewItem mj_objectArrayWithKeyValuesArray:relates];
            //遍历模型数组,转为rankcellItem
            for (DetailViewItem *item in detailItems) {
                
                RankCellItem *cellItem = [ModelChangeTool DetailViewItemToRankcellItem:item];
                [self.relates addObject:cellItem];
            };
            [self.tableView reloadData];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.relates.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RankCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    RankCellItem *item =  _relates[indexPath.row];
    cell.item = item;
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

#pragma mark - tableView代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.avplayerView destoryAVPlayer];
     [self.avplayerView removeFromSuperview];
    self.avplayerView = nil;
    _playBtn.enabled = YES;
    
    RankCellItem *item = _relates[indexPath.row];
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    detailVC.imageUrl = item.pic;
    detailVC.aid = item.aid;
    detailVC.navigationController.navigationBarHidden = YES;
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark -- 计算偏移量
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat offsetY = self.tableView.contentOffset.y - (-244);
    
    if (offsetY >= 144) {
        offsetY = 144;
    }
    
    if (offsetY <= 0) {
        offsetY = 0;
    }
    
    CGFloat ratio = (offsetY / 144);
    
    _imageViewHeight.constant  = 200 - offsetY;
    _playBtnLeading.constant = 300 - (offsetY / 144.0) * 0.5 * XDHScreenW;
    CGFloat scale = 1- 0.4 * (offsetY / 144.0) ;
    _playBtn.transform = CGAffineTransformMakeScale(scale, scale);
    _playBtnBottom.constant = 10 * (1 - ratio) ;
    _visualEffectView.alpha = 0.9 + 0.1 * ratio;
    _titleLCenterX.constant = 20 * ratio;

    //设置titleL的alpha
    _titleL.alpha = 1 - 3 * ratio;
    if (ratio > 0.9) {
        _titleL.alpha = ratio;
    }
    
}

#pragma mark - 销毁控制器
- (IBAction)backBtnClick {
    [self.avplayerView destoryAVPlayer];
    [self.avplayerView removeFromSuperview];
    self.avplayerView = nil;
    
    //判断导航控制器的类型
    if (self.showNaviBar) {
        self.navigationController.navigationBarHidden = NO;
    }
    [self.navigationController popViewControllerAnimated:YES];
   
}

-(void)dealloc {
    NSLog(@"dealloc");
    
}
@end
