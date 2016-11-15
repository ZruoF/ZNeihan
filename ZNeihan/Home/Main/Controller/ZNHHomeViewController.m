//
//  ZNHHomeViewController.m
//  ZNeihan
//
//  Created by zengruofan on 16/11/10.
//  Copyright © 2016年 曾若凡. All rights reserved.
//

#import "ZNHHomeViewController.h"
#import "ZNHCustomSegmentView.h"

@interface ZNHHomeViewController ()

@end

@implementation ZNHHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏
    [self setUpItems];
}

- (void)setUpItems {
    WeakSelf(weakSelf);
    // 精选关注
    ZNHCustomSegmentView *segment = [[ZNHCustomSegmentView alloc] initWithItemTitle:@[@"精选", @"关注"]];
    self.navigationItem.titleView = segment;
    segment.frame = CGRectMake(0, 0, 130, 35);
    [segment clickDefault];
    segment.ZNHCustomSegmentViewBtnClickHandle = ^(ZNHCustomSegmentView *segment, NSString *title, NSInteger currentIndex) {
//        BOOL isFeatured = (currentIndex == 0);
        NSLog(@"zengruofan %@",title);
    };
    
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
