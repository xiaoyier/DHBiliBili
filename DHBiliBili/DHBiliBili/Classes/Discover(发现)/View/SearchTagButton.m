//
//  SearchTagButton.m
//  DHBiliBili
//
//  Created by XDH on 16/5/28.
//  Copyright © 2016年 XDH. All rights reserved.
//

#import "SearchTagButton.h"

@implementation SearchTagButton

+ (instancetype)button {
    SearchTagButton * btn = [self buttonWithType:UIButtonTypeCustom];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    btn.layer.borderWidth = 1;
    [btn.layer setBorderColorFromUIColor:RGBCOLOR(202, 202, 202)];
    return btn;
}

@end
