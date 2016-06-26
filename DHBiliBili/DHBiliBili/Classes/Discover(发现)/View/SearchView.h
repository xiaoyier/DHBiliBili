//
//  SearchView.h
//  DHBiliBili
//
//  Created by XDH on 16/5/27.
//  Copyright © 2016年 XDH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol searchButtonDelegate <NSObject>

-(void)buttonClicked:(UIButton *)sender;

@end

@interface SearchView : UIView
@property (weak, nonatomic) IBOutlet UIButton *viewMoreBtn;

+(instancetype) loadView;

@property (weak , nonatomic) id <searchButtonDelegate> delegate;

@property (strong , nonatomic) NSArray *tagItems;


@end
