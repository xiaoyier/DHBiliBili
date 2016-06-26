//
//  DetailViewItem.h
//  DHBiliBili
//
//  Created by XDH on 16/6/15.
//  Copyright © 2016年 XDH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "owner.h"
#import "state.h"

@interface DetailViewItem : NSObject
@property (strong , nonatomic) NSString *aid;
@property (strong , nonatomic) NSString *pic;
@property (strong , nonatomic) NSString *title;
@property (strong , nonatomic) owner *owner;
@property (strong , nonatomic) state *stat;

@end
