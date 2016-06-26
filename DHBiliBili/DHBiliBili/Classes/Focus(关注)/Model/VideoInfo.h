//
//  VideoInfo.h
//  DHBiliBili
//
//  Created by XDH on 16/6/14.
//  Copyright © 2016年 XDH. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface VideoInfo : NSObject

@property (nonatomic, copy, readonly) NSString *headerImageUrl;
@property (nonatomic, copy, readonly) NSString *authorName;
@property (nonatomic, copy, readonly) NSString *createTime;
@property (nonatomic, copy, readonly) NSString *preViewImageUrl;
@property (nonatomic, copy, readonly) NSString *videoTitle;
@property (nonatomic, copy, readonly) NSString *playTimes;
@property (nonatomic, copy, readonly) NSString *commentNums;

+ (instancetype)videoInfoWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
