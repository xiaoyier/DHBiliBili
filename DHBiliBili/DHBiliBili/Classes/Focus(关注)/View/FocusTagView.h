//
//  FocusTagView.h
//  DHBiliBili
//
//  Created by XDH on 16/6/14.
//  Copyright © 2016年 XDH. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef void (^ButtonClickBlock) ();

@interface TagRefreshButton : UIButton

@end

@interface FocusTagView : UIView

@property (nonatomic, copy) NSArray *tagArray;

//预留刷新按钮点击Block
@property (nonatomic, copy) ButtonClickBlock refreshButtonBlock;

//预留关注按钮点击Block
@property (nonatomic, copy) ButtonClickBlock focusButtonBlock;

@end
