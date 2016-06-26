//
//  SearchView.m
//  DHBiliBili
//
//  Created by XDH on 16/5/27.
//  Copyright © 2016年 XDH. All rights reserved.
//

#import "SearchView.h"
#import "SearchTagItem.h"
#import "SearchTagButton.h"


@interface SearchView ()

@property (weak, nonatomic) IBOutlet UIView *tagView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollV;
@property (weak, nonatomic) IBOutlet UIView *searchView;

@property (assign , nonatomic) BOOL isClicked;

@property (assign , nonatomic) CGFloat buttonStartX;
@property (weak , nonatomic) UIButton *lastBtn;
@end

@implementation SearchView


-(void)awakeFromNib {
    self.autoresizingMask = NO;
    _searchView.layer.cornerRadius = 5;
    _searchView.layer.masksToBounds = YES;
    _tagView.xdh_height = 400;
   
    
    
}
+(instancetype)loadView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}


-(void)setTagItems:(NSArray *)tagItems {
    _tagItems = tagItems;
    //设置按钮
    [self setAllTagButton];
}
- (IBAction)search {
    //搜索内容
    NSLog(@"搜索");
    
}
- (IBAction)clickMore:(UIButton *)sender {
    if (!sender.isSelected) {
        //_tagView.xdh_height = 400;
        self.xdh_height += 100;
        _scrollV.scrollEnabled = YES;
        sender.selected = YES;
    }else {
        //self.tagView.xdh_height = 77;
        self.xdh_height -= 100;
        _scrollV.contentOffset = CGPointMake(0, 0);
        _scrollV.scrollEnabled = NO;
        sender.selected = NO;
    }
    sender.imageView.transform = CGAffineTransformRotate(sender.imageView.transform, M_PI);
    
    self.scrollV.bounces = NO;
    self.scrollV.contentSize = self.tagView.frame.size;
    
    //调用代理方法
    if ([self.delegate respondsToSelector:@selector(buttonClicked:)]) {
        [self.delegate buttonClicked:sender];
    };
    

}
- (IBAction)scanQRcode {
    
    NSLog(@"扫描二维码");
}



-(void)setAllTagButton {
    //设置frame
    CGFloat margin = 10;
    CGFloat buttonW = 0;
    CGFloat buttonH = 30;
    CGFloat buttonX = 0;
    CGFloat buttonY = 0;
    NSInteger row = 0;
    NSInteger column = 0;
    //遍历模型数组
    for (int i = 0 ; i < _tagItems.count ; i++) {
        //取出item
        SearchTagItem *item = _tagItems[i];
        //添加按钮
        SearchTagButton *btn = [SearchTagButton button];
        //取出keyword
        [btn setTitle:item.keyword forState:UIControlStateNormal];
        //设置btn的字体
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        //设置按钮监听
        [btn addTarget:self action:@selector(tagBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        //计算按钮的frame
        buttonW = [btn.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:14]].width + 20;
        _buttonStartX = CGRectGetMaxX(_lastBtn.frame) + margin;
        
        buttonX = _buttonStartX;
        //判断是否超出范围
        if ((_buttonStartX + buttonW ) > (XDHScreenW - 3 * margin)) {
            //换行
            row ++;
            buttonX = 0;
        }
        
        if (i == 0) {
            buttonX = 0;
        }
        
        buttonY = row * (margin + buttonH);
        
        //设置frame
        btn.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        [_tagView addSubview:btn];
        _lastBtn = btn;
        //设置tagView的高度
        _tagView.xdh_height = CGRectGetMaxY(_lastBtn.frame);
        }
    
    
    
    
}

-(void)tagBtnClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(buttonClicked:)]) {
        [self.delegate buttonClicked:sender];
    }
}


@end
