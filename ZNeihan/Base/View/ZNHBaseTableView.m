//
//  ZNHBaseTableView.m
//  ZNeihan
//
//  Created by zengruofan on 16/10/31.
//  Copyright © 2016年 曾若凡. All rights reserved.
//

#import "ZNHBaseTableView.h"

@implementation ZNHBaseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.tableFooterView = [UIView new];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)znh_updateWithUpdateBlock:(void(^)(ZNHBaseTableView *tableView)) updateBlock {
    if (updateBlock) {
        [self beginUpdates];
        updateBlock(self);
        [self endUpdates];
    }
}

- (UITableViewCell *)znh_cellAtIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath) return nil;
    NSInteger sectionNumber = self.numberOfSections;
    NSInteger section = indexPath.section;
    NSInteger rowNumber = [self numberOfRowsInSection:section];
    if (indexPath.section + 1 > sectionNumber || indexPath.section < 0) {
        // section 越界
        NSLog(@"刷新section: %ld 已经越界, 总组数: %ld", indexPath.section, sectionNumber);
        return nil;
    } else if (indexPath.row + 1 >rowNumber || indexPath.row < 0) {
        // row 越界
        NSLog(@"刷新row: %ld 已经越界, 总行数: %ld 所在section: %ld", indexPath.row, rowNumber, section);
        return nil;
    }
    return [self cellForRowAtIndexPath:indexPath];
}

// 注册普通的UITableViewCell
- (void)znh_registerCellClass:(Class)cellClass identifier:(NSString *)identifier {
    if (cellClass && identifier.length) {
        [self registerClass:cellClass forCellReuseIdentifier:identifier];
    }
}

// 注册一个从xib中加载的UITableViewCell
- (void)znh_registerCellNib:(Class)cellNib nibIdentifier:(NSString *)nibIdentifier {
    if (cellNib && nibIdentifier.length) {
        UINib *nib = [UINib nibWithNibName:[cellNib description] bundle:nil];
        [self registerNib:nib forCellReuseIdentifier:nibIdentifier];
    }
}

// 注册一个普通的UITableViewHeaderFooterView
- (void)znh_registerHeaderFooterClass:(Class)headerFooterClass identifier:(NSString *)identifier {
    if (headerFooterClass && identifier.length) {
        [self registerClass:headerFooterClass forCellReuseIdentifier:identifier];
    }
}

// 注册一个从xib中加载的UITableViewHeaderFooterView
- (void)znh_registerHeaderFooterNib:(Class)headerFooterNib nibIdentifier:(NSString *)nibIdentifier {
    if (headerFooterNib && nibIdentifier.length) {
        UINib *nib = [UINib nibWithNibName:[headerFooterNib description] bundle:nil];
        [self registerNib:nib forCellReuseIdentifier:nibIdentifier];
    }
}

#pragma mark - 只对已经存在的cell进行刷新，没有类似于系统的 如果不存在 默认insert操作
// 刷新单行 动画默认
-(void)znh_reloadSingleRowAtIndexPath:(NSIndexPath *)indexPath {
    [self znh_reloadSingleRowAtIndexPath:indexPath animation:None];
}
// 刷新单行 动画自定义
-(void)znh_reloadSingleRowAtIndexPath:(NSIndexPath *)indexPath animation:(ZNHBaseTableViewRoewAnimation)animation {
    if (!indexPath) return;
    NSInteger sectionNumber = self.numberOfSections;
    NSInteger section = indexPath.section;
    NSInteger rowNumber = [self numberOfRowsInSection:section];
    if (indexPath.section + 1 > sectionNumber || indexPath.section < 0) {
        return;
    } else if (indexPath.row + 1 > rowNumber || indexPath.row < 0) {
        return;
    } else {
        [self beginUpdates];
        [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimation)animation];
        [self endUpdates];
    }

}

// 刷新多行 动画默认
-(void)znh_reloadRowsAtIndexPath:(NSArray<NSIndexPath *> *)indexPaths {
    [self znh_reloadRowsAtIndexPath:indexPaths animation:None];
}
// 刷新多行 动画自定义
-(void)znh_reloadRowsAtIndexPath:(NSArray<NSIndexPath *> *)indexPaths animation:(ZNHBaseTableViewRoewAnimation)animation {
    if (!indexPaths.count) return;
    WeakSelf(weakSelf);
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSIndexPath class]]) {
            [weakSelf znh_reloadSingleRowAtIndexPath:obj animation:animation];
        }
    }];

}

// 刷新某个section 动画默认
-(void)znh_reloadSingleRowAtSection:(NSInteger)section {
    [self znh_reloadSingleRowAtSection:section animation:None];
}
// 刷新某个section 动画自定义
-(void)znh_reloadSingleRowAtSection:(NSInteger)section animation:(ZNHBaseTableViewRoewAnimation)animation {
    NSInteger sectionNumber = self.numberOfSections;
    if (section + 1 >sectionNumber || section <0) return;
    [self beginUpdates];
    [self reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:(UITableViewRowAnimation)animation];
    [self endUpdates];
}

// 刷新多个section 动画默认
-(void)znh_reloadRowsAtSection:(NSArray<NSNumber *> *)sections {
    [self znh_reloadRowsAtSection:sections animation:None];
}
// 刷新多个section 动画自定义
-(void)znh_reloadRowsAtSection:(NSArray<NSNumber *> *)sections animation:(ZNHBaseTableViewRoewAnimation)animation {
    if (!sections.count) return;
    WeakSelf(weakSelf);
    [sections enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            [weakSelf znh_reloadSingleRowAtSection:obj.integerValue animation:animation];
        }
    }];
}

#pragma mark - 对cell进行删除操作
// 删除单行 动画默认
-(void)znh_deleteSingleRowAtIndexPath:(NSIndexPath *)indexPath {
    [self znh_deleteSingleRowAtIndexPath:indexPath animation:None];
}
// 删除单行 动画自定义
-(void)znh_deleteSingleRowAtIndexPath:(NSIndexPath *)indexPath animation:(ZNHBaseTableViewRoewAnimation)animation {
    if (!indexPath) return;
    NSInteger sectionNumber = self.numberOfSections;
    NSInteger section = indexPath.section;
    NSInteger rowNumber = [self numberOfRowsInSection:section];
    if (indexPath.section + 1 > sectionNumber || indexPath.section < 0) {
        return;
    } else if (indexPath.row + 1 > rowNumber || indexPath.row < 0) {
        return;
    } else {
        [self beginUpdates];
        [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimation)animation];
        [self endUpdates];
    }

    
}

// 删除多行 动画默认
-(void)znh_deleteRowsAtIndexPath:(NSArray<NSIndexPath *> *)indexPaths {
    [self znh_deleteRowsAtIndexPath:indexPaths animation:None];
}
// 删除多行 动画自定义
-(void)znh_deleteRowsAtIndexPath:(NSArray<NSIndexPath *> *)indexPaths animation:(ZNHBaseTableViewRoewAnimation)animation {
    if (!indexPaths.count) return;
    WeakSelf(weakSelf);
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSIndexPath class]]) {
            [weakSelf znh_deleteSingleRowAtIndexPath:obj animation:animation];
        }
    }];
}

// 删除某个section 动画默认
-(void)znh_deleteSingleRowAtSection:(NSInteger)section {
    [self znh_deleteSingleRowAtSection:section animation:None];
}
// 删除某个section 动画自定义
-(void)znh_deleteSingleRowAtSection:(NSInteger)section animation:(ZNHBaseTableViewRoewAnimation)animation {
    NSInteger sectionNumber = self.numberOfSections;
    if (section + 1 > sectionNumber || section < 0) return;
    [self beginUpdates];
    [self deleteSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:(UITableViewRowAnimation)animation];
    [self endUpdates];
}

// 删除多个section 动画默认
-(void)znh_deleteRowsAtSection:(NSArray<NSNumber *> *)sections {
    [self znh_deleteRowsAtSection:sections animation:None];
}
// 删除多个section 动画自定义
-(void)znh_deleteRowsAtSection:(NSArray<NSNumber *> *)sections animation:(ZNHBaseTableViewRoewAnimation)animation {
    if (!sections.count) return;
    WeakSelf(weakSelf);
    [sections enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if( [obj isKindOfClass:[NSNumber class]]) {
            [weakSelf znh_deleteSingleRowAtSection:obj.integerValue animation:animation];
        }
    }];
}

#pragma mark - 对cell进行添加操作
// 添加单行 动画默认
-(void)znh_insertSingleRowAtIndexPath:(NSIndexPath *)indexPath {
    [self znh_insertSingleRowAtIndexPath:indexPath animation:None];
}
// 添加单行 动画自定义
-(void)znh_insertSingleRowAtIndexPath:(NSIndexPath *)indexPath animation:(ZNHBaseTableViewRoewAnimation)animation {
    if (!indexPath) return;
    NSInteger sectionNumber = self.numberOfSections;
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    NSInteger rowNumber = [self numberOfRowsInSection:section];
    if (section + 1 > sectionNumber || section < 0) {
        return;
    } else if (row + 1 > rowNumber || row < 0) {
        return;
    } else {
        [self beginUpdates];
        [self insertRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimation)animation];
        [self endUpdates];
    }
}

// 添加多行 动画默认
-(void)znh_insertRowsAtIndexPath:(NSArray<NSIndexPath *> *)indexPaths {
    [self znh_insertRowsAtIndexPath:indexPaths animation:None];
}
// 添加多行 动画自定义
-(void)znh_insertRowsAtIndexPath:(NSArray<NSIndexPath *> *)indexPaths animation:(ZNHBaseTableViewRoewAnimation)animation {
    if (!indexPaths.count) return;
    WeakSelf(weakSelf);
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSIndexPath class]]) {
            [weakSelf znh_insertSingleRowAtIndexPath:obj animation:animation];
        }
    }];
}

// 添加某个section 动画默认
-(void)znh_insertSingleRowAtSection:(NSInteger)section {
    [self znh_insertSingleRowAtSection:section animation:None];
}
// 添加某个section 动画自定义
-(void)znh_insertSingleRowAtSection:(NSInteger)section animation:(ZNHBaseTableViewRoewAnimation)animation {
    NSInteger sectionNumber = self.numberOfSections;
    if (section + 1 > sectionNumber || section < 0) return;
    
    [self beginUpdates];
    [self insertSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:(UITableViewRowAnimation)animation];
    [self endUpdates];
}

// 添加多个section 动画默认
-(void)znh_insertRowsAtSection:(NSArray<NSNumber *> *)sections {
    [self znh_insertRowsAtSection:sections animation:None];
}
// 添加多个section 动画自定义
-(void)znh_insertRowsAtSection:(NSArray<NSNumber *> *)sections animation:(ZNHBaseTableViewRoewAnimation)animation {
    if (!sections.count) return;
    WeakSelf(weakSelf);
    [sections enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            [weakSelf znh_insertSingleRowAtSection:obj.integerValue animation:animation];
        }
    }];
}

@end
