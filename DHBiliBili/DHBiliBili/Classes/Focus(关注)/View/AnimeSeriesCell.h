//
//  AnimeSeriesCell.h
//  DHBiliBili
//
//  Created by XDH on 16/6/14.
//  Copyright © 2016年 XDH. All rights reserved.
//


#import <UIKit/UIKit.h>

@class AnimeSeriesCell;
@protocol AnimeSeriesCellDelegate <NSObject>

- (void)animeSeriesCellfollowValueChange:(AnimeSeriesCell *)cell;

@end

@class AnimeInfo;
@interface AnimeSeriesCell : UITableViewCell

@property (nonatomic,strong) AnimeInfo *animeInfo;
@property (nonatomic,weak) id<AnimeSeriesCellDelegate> delegate;

@end
