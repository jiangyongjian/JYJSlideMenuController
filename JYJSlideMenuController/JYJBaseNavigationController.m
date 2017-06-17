//
//  JYJBaseNavigationController.m
//  JYJSlideMenuController
//
//  Created by JYJ on 2017/6/15.
//  Copyright © 2017年 baobeikeji. All rights reserved.
//

#import "JYJBaseNavigationController.h"
#import "ViewController.h"
#import "UIImage+Extension.h"

@interface JYJBaseNavigationController () <UINavigationControllerDelegate>
@property (nonatomic, strong) id popDelegate;

@end

@implementation JYJBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    // 这句话很重要，可以到单独的控制器里去设置
    //    self.navigationBar.translucent = YES;
    
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

+ (void)initialize {
    // 设置UIUINavigationBar的主题
    [self setupNavigationBarTheme];
}

/**
 *  设置UIBarButtonItem的主题
 */
+ (void)setupNavigationBarTheme {
    // 通过appearance对象能修改整个项目中所有UIBarbuttonItem的样式
    //    UINavigationBar *appearance = [UINavigationBar appearance];
    UINavigationBar *appearance = [UINavigationBar appearanceWhenContainedIn:[self class], nil];
    
    // 1.设置导航条的背景
    [appearance setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithRed:38 / 255.0 green:41 / 255.0 blue:48 / 255.0 alpha:1.0]] forBarMetrics:UIBarMetricsDefault];
    
    // 设置文字
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    att[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [appearance setTitleTextAttributes:att];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count > 0) {// 如果现在push的不是栈底控制器(最先push进来的那个控制器)
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -15;
        
        UIButton *button = [[UIButton alloc] init];
        // 设置按钮的背景图片
        [button setImage:[UIImage imageNamed:@"navigation_back_normal"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigation_back_hl"] forState:UIControlStateHighlighted];
        // 设置按钮的尺寸为背景图片的尺寸
        button.frame = CGRectMake(0, 0, 33, 33);
        
        //监听按钮的点击
        [button addTarget:self action:@selector(backButtonTapClick) forControlEvents:UIControlEventTouchUpInside];
        
        //设置导航栏的按钮
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        viewController.navigationItem.leftBarButtonItems = @[negativeSpacer, backButton];
        //        viewController.navigationItem.leftBarButtonItem = backButton;
        // 就有滑动返回功能
        self.interactivePopGestureRecognizer.delegate = nil;
        
    }
    [super pushViewController:viewController animated:animated];
}

// 完全展示完调用
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 如果展示的控制器是根控制器，就还原pop手势代理
    if (viewController == [self.viewControllers firstObject]) {
        self.interactivePopGestureRecognizer.delegate = self.popDelegate;
    }
}

- (void)backButtonTapClick {
    [self popViewControllerAnimated:YES];
}
@end
