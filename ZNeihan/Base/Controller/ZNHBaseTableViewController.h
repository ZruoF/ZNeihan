//
//  ZNHBaseTableViewController.h
//  ZNeihan
//
//  Created by zengruofan on 16/10/28.
//  Copyright © 2016年 曾若凡. All rights reserved.
//

#import "ZNHBaseViewController.h"
#import "ZNHBaseTableViewCell.h"

typedef void(^NHTableVcCellSelectedHandle) (ZNHBaseTableViewCell *cell, NSIndexPath *indexPath);

typedef NS_ENUM(NSInteger, ZNHBaseTableVcRefreshType) {
    // 无法刷新
    ZNCBaseTableVcRefreshTypeNone = 0,
    // 只能刷新
    ZNCBaseTableVcRefreshTypeOnlyCanRefresh,
    // 只能上拉刷新
    ZNCBaseTableVcRefreshTypeOnlyCanLoadMore,
    // 能刷新
    ZNCBaseTableVcRefreshTypeRefreshAndLoadMore
    
};

@interface ZNHBaseTableViewController : ZNHBaseViewController <UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *dataArray;
}

// 刚刚执行的是刷新
@property (nonatomic, assign) NSInteger isRefresh;
// 刚刚执行的是上拉刷新
@property (nonatomic, assign) NSInteger isLoadMore;
// 隐藏statusBar
@property (nonatomic, assign) BOOL hinddenStatusBar;
// statusBar 风格
@property (nonatomic, assign) UIStatusBarStyle barStyle;
// 右导航 item
@property (nonatomic, strong) UIBarButtonItem *navRightItem;
// 左导航 item
@property (nonatomic, strong) UIBarButtonItem *navLeftItem;
// 标题
@property (nonatomic, copy) NSString * navItemTitle;
// 表视图
@property (nonatomic, weak) ZNHBaseTableView *tableView;


// 添加空界面 显示文件
- (void)znh_addEmptyPageWithText: (NSString *)text;
// 设置导航栏 右边的item
- (void)znh_setUpNavRightItemTitle: (NSString *)itemText handle:(void(^)(NSString *rightItemTitle))Item;
// 设置导航栏 左边的item
- (void)znh_setUpNavLeftItemTitle: (NSString *)itemText handle:(void(^)(NSString *LeftItemTitle))Item;

// 监听通知
- (void)znh_observerNotiWithNotiName: (NSString *)notiName action:(SEL)action;

@end
