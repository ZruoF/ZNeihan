//
//  ZNHUtils.m
//  ZNeihan
//
//  Created by zengruofan on 16/11/4.
//  Copyright © 2016年 曾若凡. All rights reserved.
//  全局工具类

#import "ZNHUtils.h"
#import "MJRefresh.h"
#import "ZNHRefreshFooter.h"

@implementation ZNHUtils

// 开始下拉刷新
+ (void)beginPullRefreshForScrollView:(UIScrollView *)scrollView {
    [scrollView.mj_header beginRefreshing];
}
// 判断头部是否在刷新
+ (BOOL)headerIsRefreshForScrollView:(UIScrollView *)scrollView {
    return scrollView.mj_header.isRefreshing;
}
// 判断是否尾部在刷新
+ (BOOL)footerIsRefreshForScrollView:(UIScrollView *)scrollView {
    return scrollView.mj_footer.isRefreshing;
}
// 提示没有个多数据的情况,变为没有更多数据的状态
+ (void)noticeNoMoreDataForScrollView:(UIScrollView *)scrollView {
    [scrollView.mj_footer endRefreshingWithNoMoreData];
}
// 重置footer
+ (void)resetFooterForScrollView:(UIScrollView *)scrollView {
    [scrollView.mj_footer resetNoMoreData];
}
// 停止下拉刷新
+ (void)endRefreshForScrollView:(UIScrollView *)scrollView {
    [scrollView.mj_header endRefreshing];
}
// 停止上拉加载
+ (void)endLoadMoreForScrollView:(UIScrollView *)scrollView {
    [scrollView.mj_footer endRefreshing];
}
// 隐藏footer
+ (void)hiddenFooterForScrollView:(UIScrollView *)scrollView {
    scrollView.mj_footer.hidden = YES;
}
// 隐藏header
+ (void)hiddenHeaderForScrollView:(UIScrollView *)scrollView {
    scrollView.mj_header.hidden = YES;
}
// 下拉刷新
+ (void)addPullRefreshForScrollView:(UIScrollView *)scrollView pullRefreshCallBack:(XRRefreshAndLoadMoreHandle)pullRefreshCallBackBlock {
    if (scrollView == nil || pullRefreshCallBackBlock == nil) {
        return;
    }
    __weak typeof(UIScrollView *)weakScrollView = scrollView;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 顺序 觉得有问题  应该先清空 然后 再block
        if (pullRefreshCallBackBlock) {
            pullRefreshCallBackBlock();
        }
        if (weakScrollView.mj_header.hidden == NO) {
            [weakScrollView.mj_footer resetNoMoreData];
        }
    }];
    [header setTitle:@"释放更新" forState:MJRefreshStatePulling];
    [header setTitle:@"正在更新" forState:MJRefreshStateRefreshing];
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    header.stateLabel.font = [UIFont systemFontOfSize:13];
    header.stateLabel.textColor = kCommonBlackColor;
    header.lastUpdatedTimeLabel.hidden = YES;
    
    scrollView.mj_header = header;
    
}
// 上拉加载
+ (void)addLoadMoreForScrollView:(UIScrollView *)scrollView loadMoreCallBack:(XRRefreshAndLoadMoreHandle)loadMoreCallBackBlock {
    if (scrollView == nil || loadMoreCallBackBlock == nil) {
        return;
    }
    ZNHRefreshFooter * footer = [ZNHRefreshFooter footerWithRefreshingBlock:^{
        if (loadMoreCallBackBlock) {
            loadMoreCallBackBlock();
        }
    }];
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"内涵正在为您加载数据" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多了~" forState:MJRefreshStateNoMoreData];
    footer.stateLabel.textColor = kRGBColor(90, 90, 90);
    footer.stateLabel.font = kFont(13.0);
    scrollView.mj_footer = footer;
    footer.backgroundColor = kClearColor;
}
// 转换时间， 时间戳转时间
+ (NSString *)datestrFromDate:(NSDate *)date withDateFormat:(NSString *)format {
    NSDateFormatter * dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:format];
    return [dateFormat stringFromDate:date];
}
// 转换时间， 几天前，几分钟前
+ (NSString *)updateTimeForTimeInterval:(NSInteger)timeInterval {
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval createTime = timeInterval;
    NSTimeInterval time =currentTime - createTime;
    if (time < 60) {
        return @"刚刚";
    }
    NSInteger minutes = time / 60;
    if (minutes < 60) {
        return [NSString stringWithFormat:@"%ld分钟前", minutes];
    }
    NSInteger hours = time / 3600;
    if (hours < 24) {
        return [NSString stringWithFormat:@"%ld分钟前", hours];
    }
    NSInteger days = time / 3600 / 24;
    if (days < 30) {
        return [NSString stringWithFormat:@"%ld天前", days];
    }
    NSInteger months = time / 3600 / 24 / 30;
    if (months < 12) {
        return [NSString stringWithFormat:@"%ld月前", months];
    }
    NSInteger years = time / 3600 / 24 / 30 / 12;
    return [NSString stringWithFormat:@"%ld年前", years];
    
}
// 公共富文本
+ (NSAttributedString *)attributedStringWithString:(NSString *)string keyWord:(NSString *)keyWord {
    return [self attributedStringWithString:string keyWord:keyWord font:kFont(16) highlightColor:kCommonHighLightRedColor textColor:kCommonBlackColor];
}

+ (NSAttributedString *)attributedStringWithString:(NSString *)string
                                           keyWord:(NSString *)keyWord
                                              font:(UIFont *)font
                                    highlightColor:(UIColor *)highlightColor
                                         textColor:(UIColor *)textColor {
    return [self attributedStringWithString:string keyWord:keyWord font:font highlightColor:highlightColor textColor:textColor lineSpace:2.0];
}

+ (NSAttributedString *)attributedStringWithString:(NSString *)string
                                           keyWord:(NSString *)keyWord
                                              font:(UIFont *)font
                                    highlightColor:(UIColor *)highlightColor
                                         textColor:(UIColor *)textColor
                                         lineSpace:(CGFloat)lineSpace {
    if (string.length) {
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:string];
        // 没有关键字
        if (!keyWord || keyWord.length == 0) {
            NSRange allRange = NSMakeRange(0, string.length);
            [attStr addAttribute:NSFontAttributeName value:font range:allRange];
            [attStr addAttribute:NSForegroundColorAttributeName value:textColor range:allRange];
            [attStr addAttribute:NSForegroundColorAttributeName value:highlightColor range:allRange];
            
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
            style.lineSpacing = lineSpace;
            
            [attStr addAttribute:NSParagraphStyleAttributeName value:style range:allRange];
            return attStr;
        }
        NSRange range = [string rangeOfString:keyWord options:NSCaseInsensitiveSearch];
        // 找到关键字了
        if (range.location != NSNotFound) {
            [attStr addAttribute:NSFontAttributeName value:font range:range];
            [attStr addAttribute:NSForegroundColorAttributeName value:textColor range:range];
            [attStr addAttribute:NSForegroundColorAttributeName value:highlightColor range:range];
            
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
            style.lineSpacing = lineSpace;
            
            [attStr addAttribute:NSParagraphStyleAttributeName value:style range:range];
            return attStr;
        } else {
            NSRange allRange = NSMakeRange(0, string.length);
            [attStr addAttribute:NSFontAttributeName value:font range:allRange];
            [attStr addAttribute:NSForegroundColorAttributeName value:textColor range:allRange];
            [attStr addAttribute:NSForegroundColorAttributeName value:highlightColor range:allRange];
            
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
            style.lineSpacing = lineSpace;
            
            [attStr addAttribute:NSParagraphStyleAttributeName value:style range:allRange];
            return attStr;
        }
        return attStr.copy;
    }
    return [[NSAttributedString alloc] init];
}

+ (NSString *)validString:(NSString *)string {
    if ([self isBlankString:string]) {
        return kEmptyStr;
    }
    return string;
}

// 判断字符串是否为空
+ (BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) return YES;
    if ([string isKindOfClass:[NSNull class]]) return YES;
    if ([string isKindOfClass:[NSDictionary class]]) return YES;
    if ([string isKindOfClass:[NSString class]] == NO) return YES;
    if ([string isEqualToString:@""]) return YES;
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) return YES;
    return NO;
}
// 是否是当前用户
+ (BOOL)isCurrentUserWithUserId:(NSInteger *)string {
    return YES;
}
// color生成image
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
