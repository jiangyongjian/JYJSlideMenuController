//
//  JYJProfileCell.h
//  JYJSlideMenuController
//
//  Created by JYJ on 2017/6/16.
//  Copyright © 2017年 baobeikeji. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JYJCommenItem;

@interface JYJProfileCell : UITableViewCell
/** item */
@property (nonatomic, strong) JYJCommenItem *item;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
