//
//  ZNHUtils.h
//  ZNeihan
//
//  Created by zengruofan on 16/11/4.
//  Copyright © 2016年 曾若凡. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^XRRefreshAndLoadMoreHandle)(void);

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
// 停止上拉加载
+ (void)endLoadMoreForScrollView:(UIScrollView *)scrollView;
// 隐藏footer
+ (void)hiddenFooterForScrollView:(UIScrollView *)scrollView;
// 隐藏header
+ (void)hiddenHeaderForScrollView:(UIScrollView *)scrollView;
// 下拉刷新
+ (void)addPullRefreshForScrollView:(UIScrollView *)scrollView pullRefreshCallBack:(XRRefreshAndLoadMoreHandle)pullRefreshCallBackBlock;
// 上拉加载
+ (void)addLoadMoreForScrollView:(UIScrollView *)scrollView loadMoreCallBack:(XRRefreshAndLoadMoreHandle)loadMoreCallBackBlock;
// 转换时间， 时间戳转时间
+ (NSString *)datestrFromDate:(NSDate *)date withDateFormat:(NSString *)format;
// 转换时间， 几天前，几分钟前
+ (NSString *)updateTimeForTimeInterval:(NSInteger)timeInterval;
// 公共富文本
+ (NSAttributedString *)attributedStringWithString:(NSString *)string keyWord:(NSString *)keyWord;

+ (NSAttributedString *)attributedStringWithString:(NSString *)string
                                           keyWord:(NSString *)keyWord
                                              font:(UIFont *)font
                                    highlightColor:(UIColor *)highlightColor
                                         textColor:(UIColor *)textColor;

+ (NSAttributedString *)attributedStringWithString:(NSString *)string
                                           keyWord:(NSString *)keyWord
                                              font:(UIFont *)font
                                    highlightColor:(UIColor *)highlightColor
                                         textColor:(UIColor *)textColor
                                         lineSpace:(CGFloat)lineSpace;

+ (NSString *)validString:(NSString *)string;

// 判断字符串是否为空
+ (BOOL)isBlankString:(NSString *)string;
// 是否是当前用户
+ (BOOL)isCurrentUserWithUserId:(NSInteger *)string;
// color生成image
+ (UIImage *)imageWithColor:(UIColor *)color;

@end
