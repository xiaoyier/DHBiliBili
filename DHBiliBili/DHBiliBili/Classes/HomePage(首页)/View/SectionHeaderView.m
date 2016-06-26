//
//  SectionHeaderView.m
//  DHBiliBili
//
//  Created by XDH on 16/6/25.
//  Copyright © 2016年 XDH. All rights reserved.
//

#import "SectionHeaderView.h"
@interface SectionHeaderView ()
@property (weak , nonatomic) UIImageView *imageV;
@property (weak , nonatomic) UILabel *titleL;
@end
@implementation SectionHeaderView

-(void)setIcon:(NSString *)icon {
    _icon = icon;
    self.imageV.image = [UIImage imageNamed:icon];
}
-(void)setTitle:(NSString *)title {
    _title = title;
    self.titleL.text = title;
    [self.titleL sizeToFit];
}
-(instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
    }
    
    return self;
}

-(void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    UIImageView *imagev = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 25, 25)];
     self.imageV = imagev;
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(35, 7, 0, 0 )];
    titleL.font = [UIFont systemFontOfSize:15];
    self.titleL = titleL;
    [self addSubview:titleL];
   
    [self addSubview:imagev];
}

@end
