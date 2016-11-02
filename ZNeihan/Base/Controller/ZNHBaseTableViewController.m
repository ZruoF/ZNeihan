//
//  ZNHBaseTableViewController.m
//  ZNeihan
//
//  Created by zengruofan on 16/10/28.
//  Copyright © 2016年 曾若凡. All rights reserved.
//

#import "ZNHBaseTableViewController.h"

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
@synthesize hinddenStatusBar = _hinddenStatusBar;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
