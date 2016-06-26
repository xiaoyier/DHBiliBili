//
//  RankCell.m
//  DHBiliBili
//
//  Created by XDH on 16/5/10.
//  Copyright © 2016年 XDH. All rights reserved.
//

#import "RankCell.h"
#import "RankCellItem.h"
#import <UIImageView+WebCache.h>
@interface RankCell()
@property (weak, nonatomic) IBOutlet UIImageView *picV;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *authorL;
@property (weak, nonatomic) IBOutlet UILabel *playL;
@property (weak, nonatomic) IBOutlet UILabel *commentL;
@property (weak, nonatomic) IBOutlet UIView *backgroundV;
@property (weak, nonatomic) IBOutlet UIView *rankBackgroundV;
@property (weak, nonatomic) IBOutlet UILabel *rankL;


@end

@implementation RankCell


- (void)awakeFromNib {
    //取消点击状态
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //设置圆角
    _backgroundV.layer.cornerRadius = 5;
    _backgroundV.clipsToBounds = YES;
    
    _rankBackgroundV.layer.cornerRadius = 5;
    
}
-(void)setItem:(RankCellItem *)item {
    _item = item;
   
    //设置标题首行缩进
    [self setTitle];
    
    _authorL.text = [NSString stringWithFormat:@"UP主:%@",item.author] ;
    NSInteger playCount = [item.play integerValue];
    NSString *playStr;
    if (playCount > 10000) {
        playStr = [NSString stringWithFormat:@"播放:%.1f万",playCount/10000.0];
    } else {
        playStr = [@"播放:" stringByAppendingString:item.play];
    }
    NSInteger commentCount = [item.comment integerValue];
    NSString *commentStr;
    if (commentCount > 10000) {
        commentStr = [NSString stringWithFormat:@"弹幕:%.1f万",commentCount/10000.0];
    } else {
        commentStr = [@"弹幕:" stringByAppendingString:item.comment];
    }
    _playL.text = playStr;
    _commentL.text = commentStr;
    
    [_picV sd_setImageWithURL:[NSURL URLWithString:item.pic] placeholderImage:[UIImage imageNamed:@"default_img"]];
    
    //设置排名
    _rankL.text = item.no;
    if ([item.no isEqualToString:@"1"]) {
        _rankBackgroundV.backgroundColor = [UIColor colorWithRed:1.0 green:0 blue:0 alpha:0.8];
    } else if ([item.no isEqualToString:@"2"]) {
        _rankBackgroundV.backgroundColor = [UIColor colorWithRed:1.0 green:0.5 blue:0 alpha:0.8];
    } else if ([item.no isEqualToString:@"3"]) {
        _rankBackgroundV.backgroundColor = [UIColor colorWithRed:1.0 green:0.7 blue:0 alpha:0.8];
    } else if (item.no == nil) {
        _rankBackgroundV.backgroundColor = [UIColor colorWithWhite:0.667 alpha:0.0];
    } else {
        _rankBackgroundV.backgroundColor = [UIColor colorWithWhite:0.667 alpha:0.8];
    }
}

-(void)setTitle{    
    //设置首行缩进,目的是对齐label
    if ([_item.title containsString:@"】"]) {
        NSMutableAttributedString *attreibuteString = [[NSMutableAttributedString alloc] initWithString:_item.title];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.headIndent = 6;
        [attreibuteString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, _item.title.length)];
        _titleL.attributedText = attreibuteString;
    } else {
        
        NSMutableAttributedString *attreibuteString = [[NSMutableAttributedString alloc] initWithString:_item.title];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.firstLineHeadIndent = 6;
        style.headIndent = 6;
        [attreibuteString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, _item.title.length)];
        _titleL.attributedText = attreibuteString;
    }
}


@end
