//
//  ZNHBaseViewController.m
//  ZNeihan
//
//  Created by zengruofan on 16/10/24.
//  Copyright © 2016年 曾若凡. All rights reserved.
//

#import "ZNHBaseViewController.h"
#import "NSNotificationCenter+Addtion.h"
#import "ZNHCommonConstant.h"
#import "ZNHCustomLoadingAnimationView.h"
#import "AFNetworkReachabilityManager.h"
#import "SDImageCache.h"
#import "YYWebImageManager.h"
#import "YYDiskCache.h"
#import "YYMemoryCache.h"

@interface ZNHBaseViewController ()

@property (nonatomic, weak)ZNHCustomLoadingAnimationView *loadingView;

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

}

-(void)dismissWithCompletion:(void(^)()) completion {

}

-(void)presentVc:(UIViewController *)vc {

}

-(void)presentVc:(UIViewController *)vc completion:(void (^)()) completion {

}

-(void)pushVc:(UIViewController *)vc {

}

-(void)removeChildVc:(UIViewController *)Vc {

}

-(void)addChildVc:(UIViewController *)Vc {

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
