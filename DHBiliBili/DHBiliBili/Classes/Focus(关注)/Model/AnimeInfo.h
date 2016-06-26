//
//  AnimeInfo.h
//  DHBiliBili
//
//  Created by XDH on 16/6/14.
//  Copyright © 2016年 XDH. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface AnimeInfo : NSObject

@property (nonatomic, copy) NSString *coverImageUrl;
@property (nonatomic, copy) NSString *animeName;
@property (nonatomic, copy) NSString *detail;

@property (nonatomic, assign, getter=isFollowed) BOOL followed;

+ (instancetype)animeInfoWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
