//
//  ViewController.m
//  导航测试demo
//
//  Created by JYJ on 2017/6/5.
//  Copyright © 2017年 baobeikeji. All rights reserved.
//

#import "ViewController.h"
#import "JYJSliderMenuTool.h"
#import<MapKit/MapKit.h>


@interface ViewController () <UIGestureRecognizerDelegate>
/** tapGestureRec */
@property (nonatomic, weak) UITapGestureRecognizer *tapGestureRec;
/** panGestureRec */
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRec;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
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
        [self profileCenter];
    }
}

- (void)msgClick {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor greenColor];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)profileCenter {
    // 展示个人中心
    [JYJSliderMenuTool showWithRootViewController:self];
}

- (void)setupNav {
    self.title = @"摩 拜 单 车";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20], NSForegroundColorAttributeName:[UIColor colorWithRed:222 / 255.0 green:91 / 255.0 blue:78 / 255.0 alpha:1.0]}];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -15;
    
    UIButton *profileButton = [[UIButton alloc] init];
    // 设置按钮的背景图片
    [profileButton setImage:[UIImage imageNamed:@"navigationbar_list_normal"] forState:UIControlStateNormal];
    [profileButton setImage:[UIImage imageNamed:@"navigationbar_list_hl"] forState:UIControlStateHighlighted];
    // 设置按钮的尺寸为背景图片的尺寸
    profileButton.frame = CGRectMake(0, 0, 44, 44);
    //监听按钮的点击
    [profileButton addTarget:self action:@selector(profileCenter) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *profile = [[UIBarButtonItem alloc] initWithCustomView:profileButton];
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, profile];
    
    // 右边按钮
    UIButton *searchButton = [[UIButton alloc] init];
    [searchButton setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [searchButton setImage:[UIImage imageNamed:@"search_down"] forState:UIControlStateHighlighted];
    searchButton.frame = CGRectMake(0, 0, 44, 44);
    [searchButton addTarget:self action:@selector(msgClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *msgButton = [[UIButton alloc] init];
    [msgButton setImage:[UIImage imageNamed:@"notification"] forState:UIControlStateNormal];
    [msgButton setImage:[UIImage imageNamed:@"notification_down"] forState:UIControlStateHighlighted];
    msgButton.frame = CGRectMake(40, 0, 44, 44);
    [msgButton addTarget:self action:@selector(msgClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *rightView = [[UIView alloc] init];
    rightView.frame = CGRectMake(0, 0, 88, 44);
    [rightView addSubview:searchButton];
    [rightView addSubview:msgButton];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, rightItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
