//
//  UIImage+image.m
//  彩票
//
//  Created by XDH on 16/3/26.
//
//

#import "UIImage+image.h"

@implementation UIImage (image)

//返回不渲染的图片
+(UIImage *)imageWithRenderingNormalImage:(UIImage *)image {
    return  [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

/**
 *  生成一张颜色为color的空白图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color
{
    //描述矩形 宽高为1X1
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    //开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    //获取当前位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
    //    CGContextAddPath(context, path.CGPath);
    //设置填充上下文的颜色
    CGContextSetFillColorWithColor(context, [color CGColor]);
    //渲染上下文(这里才开始填充)
    CGContextFillRect(context, rect);
    //获取位图
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //结束上下文
    UIGraphicsEndImageContext();
    return image;
}
@end
