//
//  GameCenterCellItem.m
//  BiliBiliDemo
//
//  Created by XDH on 16/4/24.
//  Copyright © 2016年 XDH. All rights reserved.
//

#import "GameCenterCellItem.h"


@interface GameCenterCellItem()


@end
@implementation GameCenterCellItem

+(instancetype)gameItemWithDict:(NSDictionary *)dict {
    GameCenterCellItem *item = [[self alloc] init];
    item.title = dict[@"title"];
    item.summary = dict[@"summary"];
    item.cover = dict[@"cover"];
    item.download_link = dict[@"download_link"];
    
    return item;
}
@end
