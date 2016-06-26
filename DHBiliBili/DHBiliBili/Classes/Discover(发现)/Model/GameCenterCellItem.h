//
//  GameCenterCellItem.h
//  BiliBiliDemo
//
//  Created by XDH on 16/4/24.
//  Copyright © 2016年 XDH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameCenterCellItem : NSObject

@property (strong , nonatomic) NSString *title;
@property (strong , nonatomic) NSString *summary;

@property (strong , nonatomic) NSString *cover;

@property (strong , nonatomic) NSString *download_link;
+(instancetype)gameItemWithDict:(NSDictionary *)dict;
@end
