//
//  ModelChangeTool.m
//  DHBiliBili
//
//  Created by XDH on 16/6/15.
//  Copyright © 2016年 XDH. All rights reserved.
//

#import "ModelChangeTool.h"


@implementation ModelChangeTool
+(RankCellItem *)DetailViewItemToRankcellItem:(DetailViewItem *)detailCellItem {
    RankCellItem *item = [[RankCellItem alloc] init];

    item.author = detailCellItem.owner.name;
    item.comment = detailCellItem.stat.danmaku;
    item.play = detailCellItem.stat.view;
    item.title = detailCellItem.title;
    item.pic = detailCellItem.pic;
    item.aid = detailCellItem.aid;
    
    return item;
}
+(RankCellItem *)RecommandCellItemToRankcellItem:(RecommandCellItem *)RecommandCellItem {
    RankCellItem *item = [[RankCellItem alloc] init];
    
    item.author = @"";
    item.comment = RecommandCellItem.danmaku;
    item.play = RecommandCellItem.play;
    item.title = RecommandCellItem.title;
    item.pic = RecommandCellItem.cover;
    item.aid = RecommandCellItem.param;
    
    return item;
}
@end
