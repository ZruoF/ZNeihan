//
//  ZNHMainTabberViewController.m
//  ZNeihan
//
//  Created by zengruofan on 16/11/9.
//  Copyright © 2016年 曾若凡. All rights reserved.
//

#import "ZNHMainTabberViewController.h"
#import "ZNHBaseNavigationViewController.h"

@interface ZNHMainTabberViewController ()

@end

@implementation ZNHMainTabberViewController

+ (void)initialize {
    // 设置不透明
    [[UITabBar appearance] setTranslucent:NO];
    // 设置背景颜色
    [UITabBar appearance].barTintColor = [UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1.00f];
    
    // 拿到整个导航控制器的外观
    UITabBarItem *item = [UITabBarItem appearance];
    item.titlePositionAdjustment = UIOffsetMake(0, 1.5);
    
    // 普通状态
    NSMutableDictionary * normalAtts = [NSMutableDictionary dictionary];
    normalAtts[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    normalAtts[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.62f green:0.62f blue:0.63f alpha:1.00f];
    [item setTitleTextAttributes:normalAtts forState:UIControlStateNormal];
    // 选中状态
    NSMutableDictionary * selectAtts = [NSMutableDictionary dictionary];
    selectAtts[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    selectAtts[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1.00f];
    [item setTitleTextAttributes:selectAtts forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewControllerWithClass:[ZNHBaseNavigationViewController description] imagename:@"home" title:@"首页"];
    [self addChildViewControllerWithClass:[ZNHBaseNavigationViewController description] imagename:@"Found" title:@"发现"];
    [self addChildViewControllerWithClass:[ZNHBaseNavigationViewController description] imagename:@"audit" title:@"审核"];
    [self addChildViewControllerWithClass:[ZNHBaseNavigationViewController description] imagename:@"newstab" title:@"消息"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 添加子控制器
- (void)addChildViewControllerWithClass:(NSString *)classname
                              imagename:(NSString *)imagename
                                  title:(NSString *)title {
//    UIViewController *vc = [[NSClassFromString(classname) alloc] init];
    
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor grayColor];
    
    ZNHBaseNavigationViewController *nav = [[ZNHBaseNavigationViewController alloc] initWithRootViewController:vc];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:imagename];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:[imagename stringByAppendingString:@"_press"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];
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
