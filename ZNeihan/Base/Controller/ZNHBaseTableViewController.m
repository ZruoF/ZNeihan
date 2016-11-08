//
//  ZNHBaseTableViewController.m
//  ZNeihan
//
//  Created by zengruofan on 16/10/28.
//  Copyright © 2016年 曾若凡. All rights reserved.
//

#import "ZNHBaseTableViewController.h"
#import "AFNetworkReachabilityManager.h"
#import "ZNHBaseTableHeaderFooterView.h"
#import <objc/runtime.h>
#import "UIView+Layer.h"
#import "UIView+Tap.h"
#import "MJExtension.h"
#import "MJRefresh.h"

const char ZNHBaseTableVcNavRightItemHandleKey;
const char ZNHBaseTableVcNavLeftItemHandleKey;

@interface ZNHBaseTableViewController ()

@property (nonatomic, copy) ZNHTableVcCellSelectedHandle handle;
@property (nonatomic, weak) UIImageView *refreshImage;

@end

@implementation ZNHBaseTableViewController

@synthesize needCellSepLine = _needCellSepLine;
@synthesize sepLineColor = _sepLineColor;
@synthesize navItemTitle = _navItemTitle;
@synthesize navRightItem = _navRightItem;
@synthesize navLeftItem = _navLeftItem;
@synthesize hiddenStatusBar = _hiddenStatusBar;
@synthesize barStyle = _barStyle;
@synthesize dataArray = _dataArray;

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return  _dataArray;
}

// 加载tableView
- (ZNHBaseTableView *)tableView {
    if (!_tableView) {
        ZNHBaseTableView *tab = [[ZNHBaseTableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [self.view addSubview:tab];
        tab.dataSource = self;
        tab.delegate = self;
        tab.backgroundColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.00f];
        tab.separatorColor = kSeperatorColor;
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 添加空界面 显示文件
- (void)znh_addEmptyPageWithText: (NSString *)text {

}
// 设置导航栏 右边的item
- (void)znh_setUpNavRightItemTitle: (NSString *)itemText handle:(void(^)(NSString *rightItemTitle))Item {

}
// 设置导航栏 左边的item
- (void)znh_setUpNavLeftItemTitle: (NSString *)itemText handle:(void(^)(NSString *LeftItemTitle))Item{

}
//
- (void)znh_navItemHandle:(UIBarButtonItem *) item {
    // 这里只设置了 右侧的 按钮事件
    void(^handle)(NSString *) = objc_getAssociatedObject(self, &ZNHBaseTableVcNavRightItemHandleKey);
    if (handle) {
        handle(item.title);
    }
}

- (void)znh_setUpNavLeftItemTitle:(NSString *)itemText handle:(void (^)(NSString *))handle leftFlag:(BOOL)leftFlag {
    if (itemText.length == 0 || !handle) {
        if (itemText == nil) {
            itemText = @"";
        } else if ([itemText isKindOfClass:[NSNull class]]) {
            itemText = @"";
        }
        
        if (leftFlag) {
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:itemText style:UIBarButtonItemStylePlain target:nil action:nil];
        } else {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:itemText style:UIBarButtonItemStylePlain target:nil action:nil];
        }
    } else {
        if (leftFlag) {
            objc_setAssociatedObject(self, &ZNHBaseTableVcNavLeftItemHandleKey, handle, OBJC_ASSOCIATION_COPY_NONATOMIC);
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:itemText style:UIBarButtonItemStylePlain target:self action:@selector(znh_navItemHandle:)];
        } else {
            objc_setAssociatedObject(self, &ZNHBaseTableVcNavRightItemHandleKey, handle, OBJC_ASSOCIATION_COPY_NONATOMIC);
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:itemText style:UIBarButtonItemStylePlain target:self action:@selector(znh_navItemHandle:)];
        }
    }
}


// 监听通知
- (void)znh_observerNotiWithNotiName: (NSString *)notiName action:(SEL)action{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:action name:notiName object:nil];
}

// 设置刷新类型
- (void)setRefreshType:(ZNHBaseTableVcRefreshType)refreshType {
    _refreshType = refreshType;
    switch (refreshType) {
        case ZNHBaseTableVcRefreshTypeNone: // 无刷新
            
            break;
        case ZNHBaseTableVcRefreshTypeOnlyCanRefresh: // 只有下拉刷新
            [self znh_refresh];
            break;
        case ZNHBaseTableVcRefreshTypeOnlyCanLoadMore: // 只有上拉加载
            [self znh_loadMore];
            break;
        case ZNHBaseTableVcRefreshTypeRefreshAndLoadMore: // 上拉下拉都有
            [self znh_refresh];
            [self znh_loadMore];
            break;
        default:
            break;
    }
}

// 导航栏标题
- (void)setNavItemTitle:(NSString *)navItemTitle {
    if ([navItemTitle isKindOfClass:[NSString class]] == NO) return;
    if ([navItemTitle isEqualToString: _navItemTitle]) return;
    _navItemTitle = navItemTitle.copy;
    self.navigationItem.title = navItemTitle;
}

- (NSString *)navItemTitle {
    return self.navigationItem.title;
}

// statusBar 是否隐藏
- (void)setHiddenStatusBar:(BOOL)hiddenStatusBar {
    _hiddenStatusBar = hiddenStatusBar;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (BOOL)hiddenStatusBar {
    return _hiddenStatusBar;
}

// 状态栏样式
- (void)setBarStyle:(UIStatusBarStyle)barStyle {
    if (_barStyle == barStyle) return;
    _barStyle = barStyle;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (BOOL)prefersStatusBarHidden {
    return self.hiddenStatusBar;
}

- (void)setShowRefreshIcon:(BOOL)showRefreshIcon {
    _showRefreshIcon = showRefreshIcon;
    self.refreshImage.hidden = !showRefreshIcon;
}

- (UIImageView *)refreshImage {
    if (!_refreshImage) {
        UIImageView *refreshImg = [[UIImageView alloc] init];
        [self.view addSubview:refreshImg];
        _refreshImage = refreshImg;
        [self.view bringSubviewToFront:refreshImg];
        refreshImg.image = [UIImage imageNamed:@"refresh"];
        WeakSelf(weakSelf);
        [refreshImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.view).mas_offset(-15);
            make.size.mas_equalTo(CGSizeMake(44, 44));
            make.bottom.mas_equalTo(weakSelf.view).mas_offset(-20);
        }];
        refreshImg.layerCornerRadius = 22;
        refreshImg.backgroundColor = kWhiteColor;
        [refreshImg setTapActionWithBlock:^{
            [self startAnimation];
            [weakSelf znh_beginRefresh];
        }];
    }
    return _refreshImage;
}

- (UIView *)refreshHeader {
    return self.tableView.mj_header;
}


- (void)startAnimation {
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0];
    rotationAnimation.duration = 1.5;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    [self.refreshImage.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.barStyle;
}

// 左边item
-  (void)setNavLeftItem:(UIBarButtonItem *)navLeftItem {
    _navLeftItem = navLeftItem;
    self.navigationItem.leftBarButtonItem = navLeftItem;
}

- (UIBarButtonItem *)navLeftItem {
    return self.navigationItem.leftBarButtonItem;
}

// 右边item
- (void)setNavRightItem:(UIBarButtonItem *)navRightItem {
    _navRightItem = navRightItem;
    self.navigationItem.rightBarButtonItem = navRightItem;
}

- (UIBarButtonItem *)navRightItem {
    return self.navigationItem.rightBarButtonItem;
}

// 需要系统分割线
- (void)setNeedCellSepLine:(BOOL)needCellSepLine {
    _needCellSepLine = needCellSepLine;
    self.tableView.separatorStyle = needCellSepLine ? UITableViewCellSeparatorStyleSingleLine : UITableViewCellSeparatorStyleNone;
}

- (BOOL)needCellSepLine {
    return self.tableView.separatorStyle == UITableViewCellSeparatorStyleSingleLine;
}

- (void)znh_addRefresh {
    [ZNHUtils addPullRefreshForScrollView:self.tableView pullRefreshCallBack:^{
        [self znh_refresh];
    }];
}

- (void)znh_addLoadMore {
    [ZNHUtils addLoadMoreForScrollView:self.tableView loadMoreCallBack:^{
        [self znh_loadMore];
    }];
}

// 表视图偏移
- (void)setTableEdgeInset:(UIEdgeInsets)tableEdgeInset {
    _tableEdgeInset = tableEdgeInset;
    [self.view setNeedsUpdateConstraints]; // 去标记constraints需要在未来的某个点更新
    [self.view updateConstraintsIfNeeded]; // 立即触发约束更新，自动更新布局
    [self.view layoutIfNeeded]; // 标记设为需要布局
    [self.view setNeedsLayout]; // 实现布局
}

- (void) updateViewConstraints {
    [super updateViewConstraints];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
    [self.view sendSubviewToBack:self.tableView];
}

// 分割线颜色
- (void)setSepLineColor:(UIColor *)sepLineColor {
    if (!self.needCellSepLine) {
        return;
    }
    _sepLineColor = sepLineColor;
    if (sepLineColor) {
        self.tableView.separatorColor = sepLineColor;
    }
}

- (UIColor *)sepLineColor {
    return _sepLineColor;
}

// 头部正在刷新
- (BOOL)isHeaderRefreshing {
    return [ZNHUtils headerIsRefreshForScrollView:self.tableView];
}

// 尾部正在刷新
-  (BOOL)isFooterRefreshing {
    return [ZNHUtils footerIsRefreshForScrollView:self.tableView];
}

// 刷新数据
- (void)znh_reloadData {
    [self.tableView reloadData];
}

// 开始下拉
- (void)znh_beginRefresh {
    if (self.refreshType == ZNHBaseTableVcRefreshTypeOnlyCanRefresh || self.refreshType == ZNHBaseTableVcRefreshTypeRefreshAndLoadMore) {
        [ZNHUtils beginPullRefreshForScrollView:self.tableView];
    }
}

// 停止刷新
- (void)znh_endRefresh {
    if (self.refreshType == ZNHBaseTableVcRefreshTypeOnlyCanRefresh || self.refreshType == ZNHBaseTableVcRefreshTypeRefreshAndLoadMore) {
        [ZNHUtils endRefreshForScrollView:self.tableView];
    }
}

// 停止上拉加载
- (void)znh_endLoadMore {
    if (self.refreshType == ZNHBaseTableVcRefreshTypeOnlyCanLoadMore || self.refreshType == ZNHBaseTableVcRefreshTypeRefreshAndLoadMore) {
        [ZNHUtils endLoadMoreForScrollView:self.tableView];
    }
}

// 隐藏刷新
- (void)znh_hiddenRefresh {
    if (self.refreshType == ZNHBaseTableVcRefreshTypeOnlyCanRefresh || self.refreshType == ZNHBaseTableVcRefreshTypeRefreshAndLoadMore) {
        [ZNHUtils hiddenFooterForScrollView:self.tableView];
    }
}

// 隐藏上拉加载
- (void)znh_hiddenLoadMore{
    if (self.refreshType == ZNHBaseTableVcRefreshTypeOnlyCanLoadMore || self.refreshType == ZNHBaseTableVcRefreshTypeRefreshAndLoadMore) {
        [ZNHUtils hiddenHeaderForScrollView:self.tableView];
    }
}

// 提示没有更多信息
- (void)znh_noticeNoMoreData {
    if (self.refreshType == ZNHBaseTableVcRefreshTypeOnlyCanLoadMore || self.refreshType == ZNHBaseTableVcRefreshTypeRefreshAndLoadMore) {
        [ZNHUtils noticeNoMoreDataForScrollView:self.tableView];
    }
}
// 配置数据
- (void)znh_commonConfigResponseWithResponse:(id)response isRefresh:(BOOL)isRefresh modelClass:(__unsafe_unretained Class) modelClass {
    [self znh_commonConfigResponseWithResponse:response isRefresh:isRefresh modelClass:modelClass emptyText:nil];
}
// 配置数据
- (void)znh_commonConfigResponseWithResponse:(id)response isRefresh:(BOOL)isRefresh modelClass:(__unsafe_unretained Class) modelClass emptyText:(NSString *)emptyText {
    if ([response isKindOfClass:[NSArray class]] == NO) return;
    if (self.isRefresh) { // 刷新
        // 停止刷新
        [self znh_endRefresh];
        // 设置模型
        [self.dataArray removeAllObjects];
        self.dataArray = [modelClass mj_objectArrayWithKeyValuesArray:response];
        // 设置空界面占位文字
        if (emptyText.length) {
            [self znh_addEmptyPageWithText:emptyText];
        }
        // 刷新界面
        [self znh_reloadData];
    } else {         // 上拉刷新
        // 停止上拉
        [self znh_endLoadMore];
        if ([response count] == 0) {
            [self znh_noticeNoMoreData];
        } else {
            // 设置模型数组
            NSArray *newModels = [modelClass mj_objectArrayWithKeyValuesArray:response];
            if (newModels.count < 50) {
                [self znh_hiddenLoadMore];
            }
            [self.dataArray addObjectsFromArray:newModels];
            // 刷新界面
            [self znh_reloadData];
        }
    }
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>
// 分组数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self respondsToSelector:@selector(znh_numberOfSections)]) {
        return self.znh_numberOfSections;
    }
    return 0;
}

// 指定租返回的cell数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(znh_numberOfRowsInSection:)]) {
        return [self znh_numberOfRowsInSection:section];
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(znh_headerAtSection:)]) {
        return [self znh_headerAtSection:section];
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(znh_footerAtSection:)]) {
        return [self znh_footerAtSection:section];
    }
    return nil;
}

// 每一行 返回指定的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self respondsToSelector:@selector(znh_cellAtIndexPath:)]) {
        return [self znh_cellAtIndexPath:indexPath];
    }
    // 创建cell
    ZNHBaseTableViewCell *cell = [ZNHBaseTableViewCell cellWithTableView:self.tableView];
    // 返回cell
    return cell;
}

// 点击某行 触发的事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZNHBaseTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([self respondsToSelector:@selector(znh_didSelectCellAtIndexPath:cell:)]) {
        [self znh_didSelectCellAtIndexPath:indexPath cell:cell];
    }
}

// 设置分割线偏移间距并适配
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.needCellSepLine) {
        return;
    }
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    if ([self respondsToSelector:@selector(znh_sepEdgeInsetsAtIndexPath:)]) {
        edgeInsets = [self znh_sepEdgeInsetsAtIndexPath:indexPath];
    }
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) [tableView setSeparatorInset:edgeInsets];
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) [tableView setLayoutMargins:edgeInsets];
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) [cell setSeparatorInset:edgeInsets];
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])[cell setLayoutMargins:edgeInsets];
}

// 每一行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self respondsToSelector:@selector(znh_cellHeightAtIndexPath:)]) {
        return [self znh_cellHeightAtIndexPath:indexPath];
    }
    return tableView.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(znh_sectionHeaderHeightAtSectoin:)]) {
        return [self znh_sectionHeaderHeightAtSectoin:section];
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(znh_sectionFooterHeightAtSectoin:)]) {
        return [self znh_sectionFooterHeightAtSectoin:section];
    }
    return 0.01;
}

#pragma mark - 子类去重写
// 分组数量
- (NSInteger)znh_numberOfSections {
    return 0;
}
// 某个分组的cell 数量
- (NSInteger)znh_numberOfRowsInSection:(NSInteger)section {
    return 0;
}
// 某行的cell
- (ZNHBaseTableViewCell *)znh_cellAtIndexPath:(NSIndexPath *)indexPath {
    return [ZNHBaseTableViewCell cellWithTableView:self.tableView];
}
// 点击某行
- (void)znh_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(ZNHBaseTableViewCell *)cell {
    
}
// 某行行高
- (CGFloat)znh_cellHeightAtIndexPath:(NSIndexPath *)indexPath {
    return 0;
}
// 某个组头
- (UIView *)znh_headerAtSection:(NSInteger) section {
    return [ZNHBaseTableHeaderFooterView headerFooterViewWithTableView:self.tableView];
}
// 某个组尾
- (UIView *)znh_footerAtSection:(NSInteger) section {
    return [ZNHBaseTableHeaderFooterView headerFooterViewWithTableView:self.tableView];
}
// 某个组头 高度
- (CGFloat)znh_sectionHeaderHeightAtSectoin:(NSInteger)section {
    return 0.01;
}
// 某个组尾 高度
- (CGFloat)znh_sectionFooterHeightAtSectoin:(NSInteger)section {
    return 0.01;
}
//分割线偏移
- (UIEdgeInsets)znh_sepEdgeInsetsAtIndexPath:(NSIndexPath *)indexPath {
    return UIEdgeInsetsMake(0, 15, 0, 0);
}

#pragma mark - 子类继承
// 刷新方法
- (void)znh_refresh {
    if (self.refreshType == ZNHBaseTableVcRefreshTypeNone || self.refreshType == ZNHBaseTableVcRefreshTypeOnlyCanLoadMore) {
        return;
    }
    self.isRefresh = YES;
    self.isLoadMore = NO;
}
// 上拉加载方法
- (void)znh_loadMore {
    if (self.refreshType == ZNHBaseTableVcRefreshTypeNone || self.refreshType == ZNHBaseTableVcRefreshTypeOnlyCanRefresh) {
        return;
    }
    if (self.dataArray.count == 0) {
        return;
    }
    self.isRefresh = NO;
    self.isLoadMore = YES;
}

- (void)endRefreshIconAnimation {
    [self.refreshImage.layer removeAnimationForKey:@"rotationAnimation"];
}

#pragma mark - loading & alert
- (void)znh_showLoading {

}

- (void)znh_hiddenLoading {

}

- (void)znh_showTitle:(NSString *)title after:(NSTimeInterval)after {

}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
