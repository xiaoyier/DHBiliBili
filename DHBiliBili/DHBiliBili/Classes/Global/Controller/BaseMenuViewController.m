//
//  BaseMenuViewController.m
//  BiliBiliDemo
//
//  Created by XDH on 16/5/3.
//  Copyright © 2016年 XDH. All rights reserved.
//

#import "BaseMenuViewController.h"

@interface BaseMenuViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak , nonatomic) UIScrollView *topScrollView ;
@property (weak , nonatomic) UIView *topView;
@property (weak , nonatomic) UIButton *preSelBtn;
@property (weak , nonatomic) UICollectionView *collectionV;

@property (strong , nonatomic) NSMutableArray *buttons;
@property (weak , nonatomic) UIView *subView;

@property (assign ,nonatomic) BOOL isInitialized;
@end

@implementation BaseMenuViewController

static NSString * const ID = @"cell";
-(NSMutableArray *)buttons {
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加collectionView
    [self addCollectionView];
    
    //添加顶部View
    [self addTopView];
    
    //取消额外滚动区域
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //取消strollView的弹簧效果
    _collectionV.bounces = NO;
    _topScrollView.bounces = NO;
    
}

//在viewdidload中设置标题太早,子控制器还未添加
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (!self.isInitialized) {
        //设置topView的标题
        [self setTopViewTitle];
        self.isInitialized = YES;
        
        //给topView底部加分隔线
        UIView *underLine = [[UIView alloc] initWithFrame:CGRectMake(0, _topView.xdh_height - 1,XDHScreenW , 1)];
        underLine.backgroundColor = [UIColor lightGrayColor];
        [_topView addSubview:underLine];
    }
}

#pragma mark -- 设置所有标题
-(void)setTopViewTitle {
    //添加返回按钮
    CGFloat backBtnW = 50;
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, backBtnW, _topView.xdh_height);
    [backBtn setImage:[UIImage imageNamed:@"left_arr"] forState:UIControlStateNormal];
    [_topView addSubview:backBtn];
    //监听返回按钮点击
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];

    //设置位置
  
    CGFloat X = 0;
    CGFloat Y = 0;
    CGFloat W = 60;
    CGFloat H = _topView.xdh_height;
    
    //设置标题居中
    CGFloat minX = XDHScreenW * 0.5 - 1.5 * W - backBtnW;
    
    //如果标题过多,设置_topscrollView的滚动区域
    if (self.childViewControllers.count * W > (XDHScreenW - backBtnW)) {
        _topScrollView.contentSize = CGSizeMake(self.childViewControllers.count * W, 0 );
        minX = 0;
    }
    
    //取出所有子控制器
    for (int i = 0; i < self.childViewControllers.count; i ++) {
        X = minX + W * i ;
        UIViewController *vc = self.childViewControllers[i];
        //创建UIbutton
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:vc.title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.frame = CGRectMake(X, Y, W, H);
        [_topScrollView addSubview:btn];
        
        //设置监听
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.tag = i;
        //默认选中第一个
        if (i == 0) {
            [self clickBtn:btn];
            //添加SubLine
            UIView *subView = [[UIView alloc] init];
            subView.backgroundColor = [UIColor redColor];
            CGFloat width = [btn.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:15]].width + 20;
            CGFloat height = 4;
            CGFloat Y = _topView.xdh_height - height;
            subView.frame = CGRectMake(X, Y, width, height);
            subView.xdh_centerX = btn.xdh_centerX;
            _subView = subView;
            [_topScrollView addSubview:subView];
            
        }
        [self.buttons addObject:btn];
    }
    
    
}
#pragma mark -- 返回上一个界面
-(void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- 选中按钮
-(void)selBtn:(UIButton *)sender {
    //取消上一个按钮选中
    _preSelBtn.selected = NO;
    //设置当前按钮选中
    sender.selected = YES;
    //当前按钮成为上一个选中按钮
    _preSelBtn = sender;
}

-(void)clickBtn:(UIButton *)sender {
    //选中按钮
    [self selBtn:sender];
    
    //移到对应的cell
    CGFloat offsetX = sender.tag * XDHScreenW;
    _collectionV.contentOffset = CGPointMake(offsetX, 0);
    
    //移动subView
    [UIView animateWithDuration:0.5 animations:^{
        _subView.xdh_centerX = sender.xdh_centerX;
    }];
    
    
}

#pragma mark -- 添加collectionView
-(void)addTopView {
   
    CGFloat X = 0;
    CGFloat Y = self.navigationController.navigationBarHidden ? 20 : 64;
    CGFloat W = XDHScreenW;
    CGFloat H = 35;
    CGFloat backBtnW = 50;
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(X, Y, W, H)];
    topView.backgroundColor = [UIColor whiteColor];
    _topView = topView;
    [self.view addSubview:topView];
    
    UIScrollView *topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(backBtnW,0,W - backBtnW, H)];
    _topScrollView = topScrollView;
    topScrollView.showsHorizontalScrollIndicator = NO;
    topScrollView.scrollsToTop = NO;
    topScrollView.backgroundColor = [UIColor whiteColor];
    [_topView addSubview:topScrollView];
    
}
#pragma mark -- 添加collectionView
-(void)addCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(XDHScreenW, XDHScreenH);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionV = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    _collectionV = collectionV;
    collectionV.backgroundColor = [UIColor whiteColor];
    collectionV.scrollsToTop = NO;
    [self.view addSubview:collectionV];
    //设置数据源
    collectionV.dataSource = self;
    
    //注册cell
    [collectionV registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    
    //设置可以分页
    collectionV.pagingEnabled = YES;
    
    //设置滚动方向
    collectionV.showsHorizontalScrollIndicator = NO;
    
    //设置代理
    collectionV.delegate = self;
    
}
#pragma mark -- Collection view delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //计算偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger i = offsetX / XDHScreenW;
    
    //取出对应的按钮
    UIButton *btn = self.buttons[i];
    
    //点击按钮
    [self clickBtn:btn];
    
}
#pragma mark -- Collection view data source
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  self.childViewControllers.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    //取出对应的子控制器,设置cell的view为控制器的view
    UIViewController *VC = self.childViewControllers[indexPath.row];
    [cell.contentView addSubview:VC.view];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//-(BOOL)shouldAutorotate{
//    return NO;
//}


@end
