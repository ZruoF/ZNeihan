//
//  ZNHCustomNoNetworkEmptyView.h
//  ZNeihan
//
//  Created by zengruofan on 16/10/27.
//  Copyright © 2016年 曾若凡. All rights reserved.
//  没有网络时候显示的图

#import <UIKit/UIKit.h>

@interface ZNHCustomNoNetworkEmptyView : UIView

// 没有网络 重试
@property (nonatomic, copy) void(^customNoNetworkEmptyViewDidClickRetryHandle)(ZNHCustomNoNetworkEmptyView *view);

@end
