//
//  ZNHBaseTableViewController.m
//  ZNeihan
//
//  Created by zengruofan on 16/10/28.
//  Copyright © 2016年 曾若凡. All rights reserved.
//

#import "ZNHBaseTableViewController.h"
#import <objc/runtime.h>
#import "UIView+Layer.h"
#import "UIView+Tap.h"

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
    
}

- (void)znh_addLoadMore {

}

// 刷新数据
- (void)znh_reloadData {
    
}
// 开始下拉
- (void)znh_beginRefresh {

}
// 停止刷新
- (void)znh_endRefresh {

}
// 隐藏刷新
- (void)znh_hiddenRefresh {

}
// 提示么有更多信息
- (void)znh_noticeNoMoreData {

}
// 配置数据
- (void)znh_commonConfigResponseWithResponse:(id)response isRefresh:(BOOL)isRefresh modelClass:(__unsafe_unretained Class) modelClass {

}
// 配置数据
- (void)znh_commonConfigResponseWithResponse:(id)response isRefresh:(BOOL)isRefresh modelClass:(__unsafe_unretained Class) modelClass emptyText:(NSString *)emptyText {

}

#pragma mark - 子类去重写
// 分组数量
- (NSInteger)znh_numberOfSections {

}
// 某个分组的cell 数量
- (NSInteger)znh_numberOfRowsInSection:(NSInteger)section {

}
// 某行的cell
- (ZNHBaseTableViewCell *)znh_cellAtIndexPath:(NSIndexPath *)indexPath {

}
// 点击某行
- (void)znh_didSelectCellAtIndexPath:(NSInteger)indexPath cell:(ZNHBaseTableViewCell *)cell {

}
// 某行行高
- (CGFloat)znh_cellHeightAtIndexPath:(NSIndexPath *)indexPath {

}
// 某个组头
- (UIView *)znh_headerAtSection:(NSInteger) section {

}
// 某个组尾
- (UIView *)znh_footerAtSection:(NSInteger) section {

}
// 某个组头 高度
- (CGFloat)znh_sectionHeaderHeightAtSectoin:(NSInteger)section {

}
// 某个组尾 高度
- (CGFloat)znh_sectionFooterHeightAtSectoin:(NSInteger)section {

}
//分割线偏移
- (UIEdgeInsets)znh_sepEdgeInsetsAtIndexPath:(NSIndexPath *)indexPath {

}

#pragma mark - 子类继承
// 刷新方法
- (void)znh_refresh {

}
// 上拉加载方法
- (void)znh_loadMore {

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

@end
