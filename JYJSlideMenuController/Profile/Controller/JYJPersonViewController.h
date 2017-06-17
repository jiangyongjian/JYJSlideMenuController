//
//  JYJPersonViewController.h
//  导航测试demo
//
//  Created by JYJ on 2017/6/5.
//  Copyright © 2017年 baobeikeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYJPersonViewController : UIViewController
/** rootVc */
@property (nonatomic, strong) UIViewController *rootViewController;

/** hideStatusBar */
@property (nonatomic, assign) BOOL hideStatusBar;
@end
