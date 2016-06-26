//
//  RoundView.m
//  DHBiliBili
//
//  Created by XDH on 16/6/18.
//  Copyright © 2016年 XDH. All rights reserved.
//

#import "RoundView.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface RoundView()<UIScrollViewDelegate>
@property (weak , nonatomic) UIScrollView *scrollV;
@property (weak , nonatomic) UIPageControl *pageControl;
@property (nonatomic ,weak) NSTimer *timer;
@property (assign , nonatomic) int count;
@end
@implementation RoundView
-(instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        _count = 1;
        [self setupWithFrame:frame];
    }
    
    return self;
}

-(void)setBanners:(NSArray *)banners {
    _banners = banners;
    _count = (int)banners.count;
    //添加图片
    [self addImg:banners];
    //设置pageControl
    [self setupPageControl];
    //开始计时器
    [self startTimer];
}
#pragma mark - 设置界面
-(void)setupWithFrame:(CGRect)frame{

    
    UIScrollView *scrollV = [[UIScrollView alloc] initWithFrame:frame];
    scrollV.backgroundColor = [UIColor whiteColor];
    scrollV.bounces = NO;
    scrollV.showsHorizontalScrollIndicator = NO;
    scrollV.pagingEnabled = YES;
    [self addSubview:scrollV];
    scrollV.delegate = self;
    _scrollV = scrollV;
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:frame];
    imageV.image = [UIImage imageNamed:@"main_banner"];
    [_scrollV addSubview:imageV];
}

- (void)addImg:(NSArray *)banners{
    
    //添加图片
    for (int i = 0; i < _count; i ++) {
        CGRect rect = CGRectMake(i * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:rect];
        [_scrollV addSubview:imageV];
        NSString *url = banners[i][@"img"];
        [imageV sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"main_banner"]];
    }
    _scrollV.contentSize = CGSizeMake(_count * self.frame.size.width, self.frame.size.height);

}

- (void)setupPageControl {
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    CGFloat height = 30;
    CGFloat width = 60;
    pageControl.frame = CGRectMake(self.frame.size.width - width * 2, self.frame.size.height - height , width, height);
    pageControl.numberOfPages = _count;
    pageControl.hidesForSinglePage = YES;
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.tintColor = [UIColor whiteColor];
    _pageControl = pageControl;
    [self addSubview:pageControl];
}

#pragma mark  - 计时器相关方法
-(void)nexPage:(NSTimer *)timer;
{
    //设置下一页的页数
    NSInteger page = self.pageControl.currentPage +1;
    
    //设置回到第一页
    if (page == _count) {
        page = 0;
    }
    
    //设置滚动到下一页
    
    [_scrollV setContentOffset:CGPointMake(page * _scrollV.frame.size.width , 0) animated:YES];
}


-(void)startTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(nexPage:) userInfo:nil repeats:YES ];
    //设置多线程
    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)stopTimer
{
    [self.timer invalidate];
}


# pragma mark  - UIScrollViewDelegate

//
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //四舍五入 (int) n + 0.5 ;
    //拖动不超过一半,页码还是当前页码,拖动超过一半后则显示下一页的页码
    
    NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width + 0.5 ;
    self.pageControl.currentPage = page;
}


//设置用户开始拖拽时停止计时器
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //使当前计时器无效
    [self stopTimer];
}

//用户停止拖拽时,重新创建一个计时器对象
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}




@end
