//
//  ZNHBaseTableViewCell.h
//  ZNeihan
//
//  Created by zengruofan on 16/10/28.
//  Copyright © 2016年 曾若凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZNHBaseTableViewCell : UITableViewCell

@property (nonatomic, weak) UITableView *table;

//  快速创建一个不是从xib中加载的tableview cell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

//  快速创建一个从xib中加载的tableview cell
+ (instancetype)nibCellWithTableView:(UITableView *)tableView;

@end
