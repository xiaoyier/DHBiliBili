//
//  UIImage+FileImage.h
//  
//
//  Created by IMAC on 16/4/17.
//  Copyright © 2016年 FZQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (FileImage)

/**
 *  根据图片名无缓存的方式加载图片
 *
 *  @param fileName 图片名（不含@2x,@3x及后缀名）
 *
 *  @return 返回无缓存的图片
 */
+ (nullable UIImage *)FileImageWithContentsOfFileName:(NSString * __nonnull)fileName;
@end
