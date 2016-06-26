//
//  UIView+Frame.m
//  BuDeJie
//
//  Created by XDH on 16/4/26.
//  Copyright © 2016年 XDH. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
- (CGFloat)xdh_height
{
    return self.frame.size.height;
}
- (void)setXdh_height:(CGFloat)xdh_height
{
    CGRect frame = self.frame;
    frame.size.height = xdh_height;
    self.frame = frame;
}
- (CGFloat)xdh_width
{
    return self.frame.size.width;
}

- (void)setXdh_width:(CGFloat)xdh_width
{
    CGRect frame = self.frame;
    frame.size.width = xdh_width;
    self.frame = frame;
}

- (CGFloat)xdh_x
{
    return self.frame.origin.x;
}
- (void)setXdh_x:(CGFloat)xdh_x
{
    CGRect frame = self.frame;
    frame.origin.x = xdh_x;
    self.frame = frame;
}

- (CGFloat)xdh_y
{
    return self.frame.origin.y;
}
- (void)setXdh_y:(CGFloat)xdh_y
{
    CGRect frame = self.frame;
    frame.origin.y = xdh_y;
    self.frame = frame;
}
-(CGFloat)xdh_centerX {
    return self.center.x;
}
-(void)setXdh_centerX:(CGFloat)xdh_centerX {
    CGPoint center = self.center;
    center.x = xdh_centerX;
    self.center = center;
}
-(CGFloat)xdh_centerY {
    return self.center.y;
}
-(void)setXdh_centerY:(CGFloat)xdh_centerY {
    CGPoint center = self.center;
    center.y = xdh_centerY;
    self.center = center;
}
@end
