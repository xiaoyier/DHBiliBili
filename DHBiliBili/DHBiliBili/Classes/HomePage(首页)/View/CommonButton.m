//
//  CommonButton.m
//  DHBiliBili
//
//  Created by XDH on 16/6/17.
//  Copyright © 2016年 XDH. All rights reserved.
//

#import "CommonButton.h"

@implementation CommonButton

-(void)layoutSubviews {
    [super layoutSubviews];
    //设置图片
    self.imageView.xdh_x = (self.xdh_width - self.imageView.xdh_width)* 0.5;
    self.imageView.xdh_y = 0;
    
    //设置label
    [self.titleLabel sizeToFit];
    self.titleLabel.xdh_x = (self.xdh_width - self.titleLabel.xdh_width )* 0.5;
    self.titleLabel.xdh_y = self.xdh_height - self.titleLabel.xdh_height;
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    self.titleLabel.textColor = [UIColor blackColor];
}

-(void)setHighlighted:(BOOL)highlighted {
    
}

@end
