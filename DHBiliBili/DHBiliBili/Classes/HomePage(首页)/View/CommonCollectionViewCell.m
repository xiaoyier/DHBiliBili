//
//  CommonCollectionViewCell.m
//  DHBiliBili
//
//  Created by XDH on 16/6/17.
//  Copyright © 2016年 XDH. All rights reserved.
//

#import "CommonCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface CommonCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (weak, nonatomic) IBOutlet UILabel *titleL;

@end

@implementation CommonCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setItem:(RankCellItem *)item {
    _item = item;
    [_imageV sd_setImageWithURL:[NSURL URLWithString:item.pic]];
    _titleL.text = item.title;
}

@end
