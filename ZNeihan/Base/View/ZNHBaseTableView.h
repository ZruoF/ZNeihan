//
//  ZNHBaseTableView.h
//  ZNeihan
//
//  Created by zengruofan on 16/10/31.
//  Copyright © 2016年 曾若凡. All rights reserved.
//

#import <UIKit/UIKit.h>
// 滑入动画效果
typedef NS_ENUM(NSInteger, ZNHBaseTableViewRoewAnimation) {
    Fade = UITableViewRowAnimationFade,
    Right = UITableViewRowAnimationRight,
    Left = UITableViewRowAnimationLeft,
    Top = UITableViewRowAnimationTop,
    Bottom = UITableViewRowAnimationBottom,
    None = UITableViewRowAnimationNone,
    Middle = UITableViewRowAnimationMiddle,
    Automatic = 100
};

@class ZNHBaseTableViewCell;

@interface ZNHBaseTableView : UITableView

- (void)znh_updateWithUpdateBlock:(void(^)(ZNHBaseTableView *tableView)) updateBlock;

- (UITableViewCell *)znh_cellAtIndexPath:(NSIndexPath *)indexPath;

// 注册普通的UITableViewCell
- (void)znh_registerCellClass:(Class)cellClass identifier:(NSString *)identifier;

// 注册一个从xib中加载的UITableViewCell
- (void)znh_registerCellNib:(Class)cellNib nibIdentifier:(NSString *)nibIdentifier;

// 注册一个普通的UITableViewHeaderFooterView
- (void)znh_registerHeaderFooterClass:(Class)headerFooterClass identifier:(NSString *)identifier;

// 注册一个从xib中加载的UITableViewHeaderFooterView
- (void)znh_registerHeaderFooterNib:(Class)headerFooterNib nibIdentifier:(NSString *)nibIdentifier;

#pragma mark - 只对已经存在的cell进行刷新，没有类似于系统的 如果不存在 默认insert操作
// 刷新单行 动画默认
-(void)znh_reloadSingleRowAtIndexPath:(NSIndexPath *)indexPath;
// 刷新单行 动画自定义
-(void)znh_reloadSingleRowAtIndexPath:(NSIndexPath *)indexPath animation:(ZNHBaseTableViewRoewAnimation)animation;

// 刷新多行 动画默认
-(void)znh_reloadRowsAtIndexPath:(NSArray<NSIndexPath *> *)indexPaths;
// 刷新多行 动画自定义
-(void)znh_reloadRowsAtIndexPath:(NSArray<NSIndexPath *> *)indexPaths animation:(ZNHBaseTableViewRoewAnimation)animation;

// 刷新某个section 动画默认
-(void)znh_reloadSingleRowAtSection:(NSInteger)section;
// 刷新某个section 动画自定义
-(void)znh_reloadSingleRowAtSection:(NSInteger)section animation:(ZNHBaseTableViewRoewAnimation)animation;

// 刷新多个section 动画默认
-(void)znh_reloadRowsAtSection:(NSArray<NSNumber *> *)sections;
// 刷新多个section 动画自定义
-(void)znh_reloadRowsAtSection:(NSArray<NSNumber *> *)sections animation:(ZNHBaseTableViewRoewAnimation)animation;

#pragma mark - 对cell进行删除操作
// 删除单行 动画默认
-(void)znh_deleteSingleRowAtIndexPath:(NSIndexPath *)indexPath;
// 删除单行 动画自定义
-(void)znh_deleteSingleRowAtIndexPath:(NSIndexPath *)indexPath animation:(ZNHBaseTableViewRoewAnimation)animation;

// 删除多行 动画默认
-(void)znh_deleteRowsAtIndexPath:(NSArray<NSIndexPath *> *)indexPaths;
// 删除多行 动画自定义
-(void)znh_deleteRowsAtIndexPath:(NSArray<NSIndexPath *> *)indexPaths animation:(ZNHBaseTableViewRoewAnimation)animation;

// 删除某个section 动画默认
-(void)znh_deleteSingleRowAtSection:(NSInteger)section;
// 删除某个section 动画自定义
-(void)znh_deleteSingleRowAtSection:(NSInteger)section animation:(ZNHBaseTableViewRoewAnimation)animation;

// 删除多个section 动画默认
-(void)znh_deleteRowsAtSection:(NSArray<NSNumber *> *)sections;
// 删除多个section 动画自定义
-(void)znh_deleteRowsAtSection:(NSArray<NSNumber *> *)sections animation:(ZNHBaseTableViewRoewAnimation)animation;

#pragma mark - 对cell进行添加操作
// 添加单行 动画默认
-(void)znh_insertSingleRowAtIndexPath:(NSIndexPath *)indexPath;
// 添加单行 动画自定义
-(void)znh_insertSingleRowAtIndexPath:(NSIndexPath *)indexPath animation:(ZNHBaseTableViewRoewAnimation)animation;

// 添加多行 动画默认
-(void)znh_insertRowsAtIndexPath:(NSArray<NSIndexPath *> *)indexPaths;
// 添加多行 动画自定义
-(void)znh_insertRowsAtIndexPath:(NSArray<NSIndexPath *> *)indexPaths animation:(ZNHBaseTableViewRoewAnimation)animation;

// 添加某个section 动画默认
-(void)znh_insertSingleRowAtSection:(NSInteger)section;
// 添加某个section 动画自定义
-(void)znh_insertSingleRowAtSection:(NSInteger)section animation:(ZNHBaseTableViewRoewAnimation)animation;

// 添加多个section 动画默认
-(void)znh_insertRowsAtSection:(NSArray<NSNumber *> *)sections;
// 添加多个section 动画自定义
-(void)znh_insertRowsAtSection:(NSArray<NSNumber *> *)sections animation:(ZNHBaseTableViewRoewAnimation)animation;

@end
