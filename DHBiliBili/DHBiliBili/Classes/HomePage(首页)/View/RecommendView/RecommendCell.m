//
//  RecommendCell.m
//  BiliBiliDemo
//
//  Created by XMG on 16/4/22.
//  Copyright © 2016年 XDH. All rights reserved.
//

#import "RecommendCell.h"

@interface RecommendCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation RecommendCell

- (void)setImage:(UIImage *)image
{
    _image = image;
    
    _imageView.image = image;
}
@end
