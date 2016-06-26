//
//  CommonTableViewCell.m
//  DHBiliBili
//
//  Created by XDH on 16/6/18.
//  Copyright © 2016年 XDH. All rights reserved.
//

#import "CommonTableViewCell.h"

@implementation CommonTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setFrame:(CGRect)frame {
    frame.size.height -= 15;
    [super setFrame:frame];
}
@end
