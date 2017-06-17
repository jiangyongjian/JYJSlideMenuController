//
//  JYJPersonViewController.m
//  导航测试demo
//
//  Created by JYJ on 2017/6/5.
//  Copyright © 2017年 baobeikeji. All rights reserved.
//

#import "JYJPersonViewController.h"
#import "JYJMyWalletViewController.h"
#import "JYJMyCardViewController.h"
#import "JYJMyTripViewController.h"
#import "JYJMyFriendViewController.h"
#import "JYJMyStickerViewController.h"
#import "JYJCommenItem.h"
#import "JYJProfileCell.h"
#import "JYJPushBaseViewController.h"
#import "JYJAnimateViewController.h"


@interface JYJPersonViewController () <UITableViewDelegate, UITableViewDataSource>
/** tableView */
@property (nonatomic, weak) UITableView *tableView;
/** headerIcon */
@property (nonatomic, weak) UIImageView *headerIcon;
/** data */
@property (nonatomic, strong) NSArray *data;
@end

@implementation JYJPersonViewController

- (NSArray *)data {
    if (!_data) {
        self.data = [NSArray array];
    }
    return _data;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
    
    [self setupData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tableView.frame = self.view.bounds;
    self.headerIcon.frame = CGRectMake(self.tableView.frame.size.width / 2 - 36, 39, 72, 72);
}

- (void)setupUI {
    UITableView *tableView = [[UITableView alloc] init];
    tableView.scrollEnabled = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:247 / 255.0 blue:250 / 255.0 alpha:1.0];
    headerView.frame = CGRectMake(0, 0, 0, 150);
    self.tableView.tableHeaderView = headerView;
    
    /** 头像图片 */
    UIImageView *headerIcon = [[UIImageView alloc] init];
    headerIcon.image = [UIImage imageNamed:@"avatar_login"];
    headerIcon.frame = CGRectMake(0, 39, 72, 72);
    headerIcon.layer.cornerRadius = 36;
    headerIcon.clipsToBounds = YES;
    [headerView addSubview:headerIcon];
    self.headerIcon = headerIcon;
}


- (void)setupData {
    JYJCommenItem *myWallet = [JYJCommenItem itemWithIcon:@"menu_wallet" title:@"我的钱包" subtitle:@"" destVcClass:[JYJMyWalletViewController class]];
    
    JYJCommenItem *myCoupon = [JYJCommenItem itemWithIcon:@"menu_promo" title:@"我的卡券" subtitle:@"" destVcClass:[JYJMyCardViewController class]];
    
    JYJCommenItem *myTrip = [JYJCommenItem itemWithIcon:@"menu_trips" title:@"我的行程" subtitle:nil destVcClass:[JYJMyTripViewController class]];
    
    JYJCommenItem *myFriend = [JYJCommenItem itemWithIcon:@"menu_invite" title:@"邀请好友" subtitle:nil destVcClass:[JYJMyFriendViewController class]];
    
    JYJCommenItem *mySticker = [JYJCommenItem itemWithIcon:@"menu_sticker" title:@"我的贴纸" subtitle:nil destVcClass:[JYJMyStickerViewController class]];
    self.data = @[myWallet, myCoupon, myTrip, myFriend, mySticker];
}

#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 创建cell
    JYJProfileCell *cell = [JYJProfileCell cellWithTableView:tableView];
    cell.item = self.data[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    JYJCommenItem *item = self.data[indexPath.row];
    if (item.destVcClass == nil) return;
    
    JYJPushBaseViewController *vc = [[item.destVcClass alloc] init];
    vc.title = item.title;
    vc.animateViewController = (JYJAnimateViewController *)self.parentViewController;
    [self.parentViewController.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
