//
//  UIImage+image.h
//  
//
//  Created by XDH on 16/3/26.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (image)
+(UIImage *)imageWithRenderingNormalImage:(UIImage *)image;

/**
 *  生成一张颜色为color的空白图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;
@end
