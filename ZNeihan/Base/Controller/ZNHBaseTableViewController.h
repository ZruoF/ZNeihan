//
//  ZNHBaseTableViewController.h
//  ZNeihan
//
//  Created by zengruofan on 16/10/28.
//  Copyright © 2016年 曾若凡. All rights reserved.
//

#import "ZNHBaseViewController.h"
#import "ZNHBaseTableViewCell.h"
#import "ZNHBaseTableView.h"

typedef void(^ZNHTableVcCellSelectedHandle) (ZNHBaseTableViewCell *cell, NSIndexPath *indexPath);

typedef NS_ENUM(NSInteger, ZNHBaseTableVcRefreshType) {
    // 无法刷新
    ZNHBaseTableVcRefreshTypeNone = 0,
    // 只能刷新
    ZNHBaseTableVcRefreshTypeOnlyCanRefresh,
    // 只能上拉刷新
    ZNHBaseTableVcRefreshTypeOnlyCanLoadMore,
    // 能刷新
    ZNHBaseTableVcRefreshTypeRefreshAndLoadMore
    
};

@interface ZNHBaseTableViewController : ZNHBaseViewController <UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *dataArray;
}

// 刚刚执行的是刷新
@property (nonatomic, assign) NSInteger isRefresh;
// 刚刚执行的是上拉刷新
@property (nonatomic, assign) NSInteger isLoadMore;
// 隐藏statusBar
@property (nonatomic, assign) BOOL hiddenStatusBar;
// statusBar 风格
@property (nonatomic, assign) UIStatusBarStyle barStyle;
// 右导航 item
@property (nonatomic, strong) UIBarButtonItem *navRightItem;
// 左导航 item
@property (nonatomic, strong) UIBarButtonItem *navLeftItem;
// 标题
@property (nonatomic, copy) NSString *navItemTitle;
// 表视图
@property (nonatomic, weak) ZNHBaseTableView *tableView;
// 表视图偏移
@property (nonatomic, assign) UIEdgeInsets tableEdgeInset;
// 分割线颜色
@property (nonatomic, assign) UIColor *sepLineColor;
// 数据源数量
@property (nonatomic, strong) NSMutableArray *dataArray;
// 加载刷新类型
@property (nonatomic, assign) ZNHBaseTableVcRefreshType refreshType;
// 是否需要系统的cell 分割线
@property (nonatomic, assign) BOOL needCellSepLine;
// 是否在下拉刷新
@property (nonatomic, assign, readonly) BOOL isHeaderRefreshing;
// 是否在上拉刷新
@property (nonatomic, assign, readonly) BOOL isFooterRefreshing;


// 添加空界面 显示文件
- (void)znh_addEmptyPageWithText: (NSString *)text;
// 设置导航栏 右边的item
- (void)znh_setUpNavRightItemTitle: (NSString *)itemText handle:(void(^)(NSString *rightItemTitle))Item;
// 设置导航栏 左边的item
- (void)znh_setUpNavLeftItemTitle: (NSString *)itemText handle:(void(^)(NSString *LeftItemTitle))Item;

// 监听通知
- (void)znh_observerNotiWithNotiName: (NSString *)notiName action:(SEL)action;

// 刷新数据
- (void)znh_reloadData;
// 开始下拉
- (void)znh_beginRefresh;
// 停止刷新
- (void)znh_endRefresh;
// 停止上拉加载
- (void)znh_endLoadMore;
// 隐藏刷新
- (void)znh_hiddenRefresh;
// 隐藏上拉加载
- (void)znh_hiddenLoadMore;
// 提示没有更多信息
- (void)znh_noticeNoMoreData;
// 配置数据
- (void)znh_commonConfigResponseWithResponse:(id)response isRefresh:(BOOL)isRefresh modelClass:(__unsafe_unretained Class) modelClass;
// 配置数据
- (void)znh_commonConfigResponseWithResponse:(id)response isRefresh:(BOOL)isRefresh modelClass:(__unsafe_unretained Class) modelClass emptyText:(NSString *)emptyText;

#pragma mark - 子类去重写
// 分组数量
- (NSInteger)znh_numberOfSections;
// 某个分组的cell 数量
- (NSInteger)znh_numberOfRowsInSection:(NSInteger)section;
// 某行的cell
- (ZNHBaseTableViewCell *)znh_cellAtIndexPath:(NSIndexPath *)indexPath;
// 点击某行
- (void)znh_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(ZNHBaseTableViewCell *)cell;
// 某行行高
- (CGFloat)znh_cellHeightAtIndexPath:(NSIndexPath *)indexPath;
// 某个组头
- (UIView *)znh_headerAtSection:(NSInteger) section;
// 某个组尾
- (UIView *)znh_footerAtSection:(NSInteger) section;
// 某个组头 高度
- (CGFloat)znh_sectionHeaderHeightAtSectoin:(NSInteger)section;
// 某个组尾 高度
- (CGFloat)znh_sectionFooterHeightAtSectoin:(NSInteger)section;
//分割线偏移
- (UIEdgeInsets)znh_sepEdgeInsetsAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark - 子类继承
// 刷新方法
- (void)znh_refresh;
// 上拉加载方法
- (void)znh_loadMore;

@property (nonatomic, assign) BOOL showRefreshIcon;

- (void)endRefreshIconAnimation;

@property (nonatomic, weak, readonly) UIView *refreshHeader;

#pragma mark - loading & alert
- (void)znh_showLoading;

- (void)znh_hiddenLoading;

- (void)znh_showTitle:(NSString *)title after:(NSTimeInterval)after;

@end
