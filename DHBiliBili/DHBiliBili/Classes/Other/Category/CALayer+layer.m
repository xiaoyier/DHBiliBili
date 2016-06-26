//
//  CALayer+layer.m
//  DHBiliBili
//
//  Created by XDH on 16/5/13.
//  Copyright © 2016年 XDH. All rights reserved.
//

#import "CALayer+layer.h"

@implementation CALayer (layer)
-(void)setBorderColorFromUIColor:(UIColor *)borderColorFromUIColor {
    self.borderColor = borderColorFromUIColor.CGColor;
}
@end
