//
//  JYJSliderMenuTool.m
//  JYJSlideMenuController
//
//  Created by JYJ on 2017/6/16.
//  Copyright © 2017年 baobeikeji. All rights reserved.
//

#import "JYJSliderMenuTool.h"
#import "JYJBaseNavigationController.h"
#import "JYJAnimateViewController.h"

@implementation JYJSliderMenuTool

static UIWindow *window_;
/**
 * 根据底部控制器展示
 */
+ (void)showWithRootViewController:(UIViewController *)rootViewController {
    window_ = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window_.backgroundColor = [UIColor clearColor];
    window_.hidden = NO;
    
    JYJAnimateViewController *vc = [[JYJAnimateViewController alloc] init];
    vc.view.backgroundColor = [UIColor clearColor];
    vc.rootViewController = rootViewController;
    JYJBaseNavigationController *nav = [[JYJBaseNavigationController alloc] initWithRootViewController:vc];
    nav.view.backgroundColor = [UIColor clearColor];
    window_.rootViewController = nav;
    [window_ addSubview:nav.view];
}

/**
 * 隐藏
 */
+ (void)hide {
    window_.hidden = YES;
    window_.rootViewController = nil;
    window_ = nil;
}

@end
