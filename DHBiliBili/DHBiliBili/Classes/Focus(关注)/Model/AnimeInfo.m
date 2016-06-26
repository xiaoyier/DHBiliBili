//
//  AnimeInfo.m
//  DHBiliBili
//
//  Created by XDH on 16/6/14.
//  Copyright © 2016年 XDH. All rights reserved.
//


#import "AnimeInfo.h"

@implementation AnimeInfo

+ (instancetype)animeInfoWithDictionary:(NSDictionary *)dict{
    AnimeInfo *animeInfo = [[AnimeInfo alloc]initWithDictionary:dict];
    return animeInfo;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        if (dict&&dict.count>0) {
            for (NSString *key in dict.allKeys) {
                [self setValue:dict[key] forKey:key];
            }
        }
    }
    return self;
}

@end
