//
//  GameCenterCollectionViewCell.h
//  BiliBiliDemo
//
//  Created by XDH on 16/4/23.
//  Copyright © 2016年 XDH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameCenterCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *downloadBtn;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageV;

@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *summaryL;

@end
