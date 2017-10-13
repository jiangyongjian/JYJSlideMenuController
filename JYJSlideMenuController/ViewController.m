//
//  ViewController.m
//  导航测试demo
//
//  Created by JYJ on 2017/6/5.
//  Copyright © 2017年 baobeikeji. All rights reserved.
//

#import "ViewController.h"
#import<MapKit/MapKit.h>
#import "JYJAnimateViewController.h"
#import "JYJOneViewController.h"

#define FBStatusBarH ([UIApplication sharedApplication].statusBarFrame.size.height)
#define FBNavigationBarH (FBStatusBarH + 44)

@interface ViewController () <UIGestureRecognizerDelegate>
/** tapGestureRec */
@property (nonatomic, weak) UITapGestureRecognizer *tapGestureRec;
/** panGestureRec */
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRec;
/** profileButton */
@property (nonatomic, weak) UIButton *profileButton;
/** hasClick */
@property (nonatomic, assign) BOOL hasClick;

/** vc */
@property (nonatomic, strong) JYJAnimateViewController *vc;
@end

@implementation ViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 这个方法是为了，不让隐藏状态栏的时候出现view上移
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    MKMapView *mapView = [[MKMapView alloc] init];
    mapView.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
    mapView.userTrackingMode = MKUserTrackingModeFollow;
    mapView.showsUserLocation = YES;
    [self.view addSubview:mapView];
    
    // 屏幕边缘pan手势(优先级高于其他手势)
    UIScreenEdgePanGestureRecognizer *leftEdgeGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self
                                                                                                          action:@selector(moveViewWithGesture:)];
    leftEdgeGesture.edges = UIRectEdgeLeft;// 屏幕左侧边缘响应
    [self.view addGestureRecognizer:leftEdgeGesture];
    // 这里是地图处理方式，遵守代理协议，实现代理方法
    leftEdgeGesture.delegate = self;
    
    // 如果是scrollView的话，下面这行代码就可以了不用遵守代理协议，实现代理方法
    //    [scrollView.panGestureRecognizer requireGestureRecognizerToFail:leftEdgeGesture];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    BOOL result = NO;
    if ([gestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
        result = YES;
    }
    return result;
}

- (void)moveViewWithGesture:(UIPanGestureRecognizer *)panGes {
    if (panGes.state == UIGestureRecognizerStateEnded) {
        if ([self.childViewControllers containsObject:self.vc]) return;
        [self profileCenter];
    }
}

- (void)msgClick {
    JYJOneViewController *vc = [[JYJOneViewController alloc] init];
    vc.view.backgroundColor = [UIColor greenColor];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)profileCenter {
    // 防止重复点击
    if (self.hasClick) return;
    self.hasClick = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.hasClick = NO;
    });
    
    // 展示个人中心
    JYJAnimateViewController *vc = [[JYJAnimateViewController alloc] init];
    self.vc = vc;
    vc.view.backgroundColor = [UIColor clearColor];
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
}

- (void)setupNav {
    UIView *navBarView = [[UIView alloc] init];
    navBarView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, FBNavigationBarH);
    navBarView.backgroundColor = [UIColor colorWithRed:38 / 255.0 green:41 / 255.0 blue:48 / 255.0 alpha:1.0];
    [self.view addSubview:navBarView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(0, FBStatusBarH, [UIScreen mainScreen].bounds.size.width, 44);
    titleLabel.text = @"摩 拜 单 车";
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = [UIColor colorWithRed:222 / 255.0 green:91 / 255.0 blue:78 / 255.0 alpha:1.0];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [navBarView addSubview:titleLabel];
    
    UIButton *profileButton = [[UIButton alloc] init];
    [profileButton setImage:[UIImage imageNamed:@"navigationbar_list_normal"] forState:UIControlStateNormal];
    [profileButton setImage:[UIImage imageNamed:@"navigationbar_list_hl"] forState:UIControlStateHighlighted];
    profileButton.frame = CGRectMake(0, FBNavigationBarH - 44, 80, 44);
    [profileButton addTarget:self action:@selector(profileCenter) forControlEvents:UIControlEventTouchUpInside];
    profileButton.imageEdgeInsets = UIEdgeInsetsMake(0, -35, 0, 0);
    profileButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [navBarView addSubview:profileButton];
    
    // 右边按钮
    UIButton *searchButton = [[UIButton alloc] init];
    [searchButton setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [searchButton setImage:[UIImage imageNamed:@"search_down"] forState:UIControlStateHighlighted];
    searchButton.frame = CGRectMake(0, 0, 44, 44);
    [searchButton addTarget:self action:@selector(msgClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *msgButton = [[UIButton alloc] init];
    [msgButton setImage:[UIImage imageNamed:@"notification"] forState:UIControlStateNormal];
    [msgButton setImage:[UIImage imageNamed:@"notification_down"] forState:UIControlStateHighlighted];
    msgButton.frame = CGRectMake(44, 0, 44, 44);
    [msgButton addTarget:self action:@selector(msgClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *rightView = [[UIView alloc] init];
    rightView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 88 - 5, FBStatusBarH, 88, 44);
    [rightView addSubview:searchButton];
    [rightView addSubview:msgButton];
    [navBarView addSubview:rightView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
