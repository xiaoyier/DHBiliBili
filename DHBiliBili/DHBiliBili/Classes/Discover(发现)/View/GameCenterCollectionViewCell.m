//
//  GameCenterCollectionViewCell.m
//  BiliBiliDemo
//
//  Created by XDH on 16/4/23.
//  Copyright © 2016年 XDH. All rights reserved.
//

#import "GameCenterCollectionViewCell.h"
@interface GameCenterCollectionViewCell ()


@end
@implementation GameCenterCollectionViewCell

- (void)awakeFromNib {
    //设置边框按钮颜色
    [_downloadBtn.layer setBorderColor:[UIColor colorWithRed:202/255.0 green:105/255.0 blue:142/255.0 alpha:1].CGColor];
}

@end
