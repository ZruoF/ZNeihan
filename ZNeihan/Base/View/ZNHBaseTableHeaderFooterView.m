//
//  ZNHBaseTableHeaderFooterView.m
//  ZNeihan
//
//  Created by zengruofan on 16/11/8.
//  Copyright © 2016年 曾若凡. All rights reserved.
//

#import "ZNHBaseTableHeaderFooterView.h"

@implementation ZNHBaseTableHeaderFooterView

// 快速选件一个不是从xib中加载的tableView header footer
+ (instancetype)headerFooterViewWithTableView:(UITableView *)tableView {
    if (tableView == nil) {
        return [[self alloc] init];
    }
    NSString *className = NSStringFromClass([self class]);
    NSString *identifier = [className stringByAppendingString:@"HeaderFooterID"];
    [tableView registerClass:[self class] forCellReuseIdentifier:identifier];
    return [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
}

// 快速选件一个从xib中加载的tableView header footer
+ (instancetype)nibHeaderFooterViewWithTableView:(UITableView *)tableView {
    if (tableView == nil) {
        return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
    }
    NSString *className = NSStringFromClass([self class]);
    NSString *identifier = [className stringByAppendingString:@"nibHeaderFooterID"];
    UINib *nib = [UINib nibWithNibName:className bundle:nil];
    [tableView registerNib:nib forHeaderFooterViewReuseIdentifier:identifier];
    return [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
}

@end
