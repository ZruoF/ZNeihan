//
//  ZNHUtils.h
//  ZNeihan
//
//  Created by zengruofan on 16/11/4.
//  Copyright © 2016年 曾若凡. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^XRRefreshAndLoadMoreHandle) (void);

@interface ZNHUtils : NSObject

// 开始下拉刷新
+ (void)beginPullRefreshForScrollView:(UIScrollView *)scrollView;
// 判断头部是否在刷新
+ (BOOL)headerIsRefreshForScrollView:(UIScrollView *)scrollView;
// 判断是否尾部在刷新
+ (BOOL)footerIsRefreshForScrollView:(UIScrollView *)scrollView;
// 提示没有个多数据的情况
+ (void)noticeNoMoreDataForScrollView:(UIScrollView *)scrollView;
// 重置footer
+ (void)resetFooterForScrollView:(UIScrollView *)scrollView;
// 停止下拉刷新
+ (void)endRefreshForScrollView:(UIScrollView *)scrollView;
// 



@end
