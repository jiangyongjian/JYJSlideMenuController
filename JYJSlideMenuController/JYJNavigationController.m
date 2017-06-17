//
//  JYJNavigationController.m
//  JYJSlideMenuController
//
//  Created by JYJ on 2017/6/14.
//  Copyright © 2017年 baobeikeji. All rights reserved.
//

#import "JYJNavigationController.h"

@interface JYJNavigationController ()

@end

@implementation JYJNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/**
 * 这个方法是为了，后台进入前台，导航栏的位置会改变
 */
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.navigationBar.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
}

@end
