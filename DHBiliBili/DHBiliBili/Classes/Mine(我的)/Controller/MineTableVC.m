//
//  MineTableVC.m
//  BiliBiliDemo
//
//  Created by XDH on 16/4/12.
//  Copyright © 2016年 XDH. All rights reserved.
//

#import "MineTableVC.h"

@implementation MineTableVC
-(void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    
    
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    self.navigationController.navigationBar.xdh_height -= 10;
//    NSLog(@"%@", self.navigationController.navigationBar.titleTextAttributes);
}
@end
