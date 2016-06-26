//
//  UIImage+FileImage.m
//  
//
//  Created by IMAC on 16/4/17.
//  Copyright © 2016年 FZQ. All rights reserved.
//

#import "UIImage+FileImage.h"

@implementation UIImage (FileImage)

+ (nullable UIImage *)FileImageWithContentsOfFileName:(NSString *)fileName
{
    //生成图片
    UIImage *image = nil;
    
    
    //在图片名后插入@2x，获取图片
    image = [UIImage imageName:fileName addIdentification:@"@2x"];
    //判断图片是否存在，存在则加载成功
    if(image) return image;
    
    
    //在图片名后插入@3x，获取图片
    image = [UIImage imageName:fileName addIdentification:@"@3x"];
    //判断图片是否存在，存在则加载成功
    if(image) return image;

    
    //根据原图片名获取图片
    image = [UIImage imageName:fileName addIdentification:@""];
    //判断图片是否存在，存在则加载成功
    if(image) return image;
    
    
    //若都不存在，返回空值
    return nil;
}

//图片文件名
+ (UIImage *)imageName:(NSString *)imageName addIdentification:(NSString *)identification
{
    NSString *fullFileName = [imageName stringByAppendingString:identification];
    
    //根据文件名及类型为png格式获取全路径
    NSString *imagePath = [[NSBundle mainBundle]pathForResource:fullFileName ofType:@".png"];
    
    //若不存在，则去找文件名及类型为jpg格式的文件，获取全路径
    if (!imagePath)imagePath = [[NSBundle mainBundle]pathForResource:fullFileName ofType:@".jpg"];
    
    
    //根据全路径获取图片
    return [UIImage imageWithContentsOfFile:imagePath];
}

@end
