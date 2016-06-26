//
//  RecommandCollectionViewCell.m
//  DHBiliBili
//
//  Created by XDH on 16/6/21.
//  Copyright © 2016年 XDH. All rights reserved.
//

#import "RecommandCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface RecommandCollectionViewCell()
//图片
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
//标题
@property (weak, nonatomic) IBOutlet UILabel *titleL;
//播放数
@property (weak, nonatomic) IBOutlet UILabel *playCountL;
//弹幕数
@property (weak, nonatomic) IBOutlet UILabel *danmakuCountL;


@end

@implementation RecommandCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setItem:(RecommandCellItem *)item {
    _item = item;
    [_imageV sd_setImageWithURL:[NSURL URLWithString:item.cover]];
    _titleL.text = item.title;
    _playCountL.text = item.play;
    _danmakuCountL.text = item.danmaku;
}

@end
