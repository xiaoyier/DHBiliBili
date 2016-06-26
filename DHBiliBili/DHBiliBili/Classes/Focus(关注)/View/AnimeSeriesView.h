//
//  AnimeSeriesView.h
//  DHBiliBili
//
//  Created by XDH on 16/6/14.
//  Copyright © 2016年 XDH. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface AnimeSeriesView : UIView

@property (nonatomic, weak) UIViewController *owner;
@property (nonatomic, strong) NSArray *dataArray;

@end
