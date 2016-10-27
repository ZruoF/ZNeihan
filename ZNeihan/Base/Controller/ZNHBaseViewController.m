//
//  ZNHBaseViewController.m
//  ZNeihan
//
//  Created by zengruofan on 16/10/24.
//  Copyright © 2016年 曾若凡. All rights reserved.
//

#import "ZNHBaseViewController.h"
#import "NSNotificationCenter+Addtion.h"
#import "ZNHCustomLoadingAnimationView.h"
#import "AFNetworkReachabilityManager.h"
#import "SDImageCache.h"
#import "YYWebImageManager.h"
#import "YYDiskCache.h"
#import "YYMemoryCache.h"
#import "ZNHCustomNoNetworkEmptyView.h"

@interface ZNHBaseViewController ()

@property (nonatomic, weak)ZNHCustomLoadingAnimationView *loadingView;

@property (nonatomic, weak) ZNHCustomNoNetworkEmptyView *noNetWorkEmptyView;

@end

@implementation ZNHBaseViewController

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UIView setAnimationsEnabled:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    NSArray *gestureArray = self.navigationController.view.gestureRecognizers;
    for (UIGestureRecognizer *gesture in gestureArray) {
        if ([gesture isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
            for(UIView *sub in self.view.subviews) {
                if ([sub isKindOfClass:[UIScrollView class]]) {
                    UIScrollView *sc = (UIScrollView *)sub;
                    [sc.panGestureRecognizer requireGestureRecognizerToFail:gesture];
                }
            }
        }
    }
}

-(void)viewDidLoad {
    [super viewDidLoad];
    [UIView setAnimationsEnabled:YES];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.view.backgroundColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.00f];
    
    [NSNotificationCenter addObserver:self action:@selector(requestSuccessNotification) name:kZNHRequestSuccessNotification];
}

-(void)requestSuccessNotification {
    [self hideLoadingAnimation];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)pop {
    if (self.navigationController == nil) return;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)popToRootVc {
    if (self.navigationController == nil) return;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)popToVc:(UIViewController *)vc {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return;
    if (self.navigationController == nil) return;
    [self.navigationController popToViewController:vc animated:YES];
}

-(void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)dismissWithCompletion:(void(^)()) completion {
    [self dismissViewControllerAnimated:YES completion:completion];
}

-(void)presentVc:(UIViewController *)vc {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    [self presentVc:vc completion:nil];
}

-(void)presentVc:(UIViewController *)vc completion:(void (^)()) completion {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    [self presentViewController:vc animated:YES completion:completion];
}

-(void)pushVc:(UIViewController *)vc {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    if (self.navigationController == nil) return ;
    if (vc.hidesBottomBarWhenPushed == NO) {
        vc.hidesBottomBarWhenPushed = YES;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)removeChildVc:(UIViewController *)childVc {
    if ([childVc isKindOfClass:[UIViewController class]] == NO) return ;
    [childVc.view removeFromSuperview];
    [childVc willMoveToParentViewController:nil];
    [childVc removeFromParentViewController];
}

-(void)addChildVc:(UIViewController *)childVc {
    if ([childVc isKindOfClass:[UIViewController class]] == NO) return ;
    [childVc willMoveToParentViewController:self];
    [self addChildViewController:childVc];
    [self.view addSubview:childVc.view];
    childVc.view.frame = self.view.bounds;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

// 没网 展现页面
-(ZNHCustomNoNetworkEmptyView *) customNoNetworkEmptyView {
    if (!_noNetWorkEmptyView) {
        ZNHCustomNoNetworkEmptyView *empty = [[ZNHCustomNoNetworkEmptyView alloc] init];
        [self.view addSubview:empty];
        _noNetWorkEmptyView = empty;
        
        WeakSelf(weakSelf);
        [empty mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.view);
        }];
        empty.customNoNetworkEmptyViewDidClickRetryHandle = ^(ZNHCustomNoNetworkEmptyView *empty) {
            [weakSelf loadData];
        };
    }
    return _noNetWorkEmptyView;

}

// 加载中
-(void)showLoadingAnimation {
    ZNHCustomLoadingAnimationView *animation = [[ZNHCustomLoadingAnimationView alloc] init];
    [animation showInView:self.view];
    _loadingView = animation;
    [self.view bringSubviewToFront:animation];
}
// 停止加载
-(void)hideLoadingAnimation {
    [_loadingView dismiss];
    _loadingView = nil;
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.view bringSubviewToFront:self.loadingView];
}

//请求数据，交给子类去实现
-(void)loadData {

}

-(BOOL)isNetworkReachable {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"menCache"];
    [[[YYWebImageManager sharedManager] cache].diskCache removeAllObjects];
    [[[YYWebImageManager sharedManager] cache].memoryCache removeAllObjects];
}

@end
