//
//  ZNHBaseTableHeaderFooterView.h
//  ZNeihan
//
//  Created by zengruofan on 16/11/8.
//  Copyright © 2016年 曾若凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZNHBaseTableHeaderFooterView : UITableViewHeaderFooterView

// 快速选件一个不是从xib中加载的tableView header footer
+ (instancetype)headerFooterViewWithTableView:(UITableView *)tableView;

// 快速选件一个从xib中加载的tableView header footer
+ (instancetype)nibHeaderFooterViewWithTableView:(UITableView *)tableView;

@end
