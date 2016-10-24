//
//  ZNHBaseViewController.h
//  ZNeihan
//
//  Created by zengruofan on 16/10/24.
//  Copyright © 2016年 曾若凡. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ZNHBaseViewControllerHandle)();

@interface ZNHBaseViewController : UIViewController

-(void)pop;

-(void)popToRootVc;

-(void)popToVc:(UIViewController *)vc;

-(void)dismiss;

-(void)dismissWithCompletion:(void(^)()) completion;

-(void)presentVc:(UIViewController *)vc;

-(void)presentVc:(UIViewController *)vc completion:(void (^)()) completion;

-(void)pushVc:(UIViewController *)vc;

-(void)removeChildVc:(UIViewController *)Vc;

-(void)addChildVc:(UIViewController *)Vc;

// 加载中
-(void)showLoadingAnimation;
// 停止加载
-(void)hideLoadingAnimation;

//请求数据，交给子类去实现
-(void)loadData;

@property (nonatomic, assign) BOOL isNetworkReachable;

@end
