//
//  ZNHBaseNavigationViewController.m
//  ZNeihan
//
//  Created by 曾若凡 on 16/10/21.
//  Copyright © 2016年 曾若凡. All rights reserved.
//

#import "ZNHBaseNavigationViewController.h"

@interface ZNHBaseNavigationViewController () <UIGestureRecognizerDelegate>

@end

@implementation ZNHBaseNavigationViewController

+ (void)initialize {
    // 设置为不透明
    [[UINavigationBar appearance] setTranslucent:NO];
    // 设置导航栏颜色
    [UINavigationBar appearance].barTintColor =
        [UIColor colorWithRed:0.86f green:0.85f blue:0.80f alpha:1.00f];
    // 设置导航栏标题文字颜色，创建字典保存文字大小和颜色
    NSMutableDictionary *color = [NSMutableDictionary dictionary];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little
preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
