//
//  ModelChangeTool.h
//  DHBiliBili
//
//  Created by XDH on 16/6/15.
//  Copyright © 2016年 XDH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RankCellItem.h"
#import "DetailViewItem.h"
#import "RecommandCellItem.h"

@interface ModelChangeTool : NSObject

+(RankCellItem *)DetailViewItemToRankcellItem:(DetailViewItem *)detailCellItem;
+(RankCellItem *)RecommandCellItemToRankcellItem:(RecommandCellItem *)RecommandCellItem;
@end
