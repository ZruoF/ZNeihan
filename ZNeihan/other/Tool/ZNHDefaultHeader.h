//
//  ZHNDefaultHeader.h
//  ZNeihan
//
//  Created by 曾若凡 on 16/10/23.
//  Copyright © 2016年 曾若凡. All rights reserved.
//

#ifndef ZHNDefaultHeader_h
#define ZHNDefaultHeader_h

/**
 *  弱指针
 */
#define WeakSelf(weakSelf) __weak __typeof(&*self) weakSelf = self;

#pragma mark -颜色
#define  kCommonBgColor [UIColor colorWithRed:0.86f green:0.85f blue:0.80f alpha:1.00f]
#define kOrangeColor [UIColor orangeColor]


#pragma mark - 系统UI
#define kNavigationBarHeight 44
#define kStatusBarHeight 20
#define kTopBarHeight 64
#define kToolBarHeight 44
#define kTabBarHeight 49
#define kiPhone4_W 320
#define kiPhone4_H 480
#define kiPhone5_W 320
#define kiPhone5_H 568
#define kiPhone6_W 375
#define kiPhone6_H 667
#define kiPhone6P_W 414
#define kiPhone6P_H 736

/***  当前屏幕宽度 */
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
/***  当前屏幕高度 */
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
/***  普通字体 */
#define kFont(size) [UIFont systemFontOfSize:size]
/***  粗体 */
#define kBoldFont(size) [UIFont boldSystemFontOfSize:size]
/***  普通字体 */
#define kFont(size) [UIFont systemFontOfSize:size]
#define kLineHeight (1 / [UIScreen mainScreen].scale)

#pragma mark - 字符串转化
#define kEmptyStr @""
#define kIntToStr(i) [NSString stringWithFormat:@"%d", i]
#define kIntegerToStr(i) [NSString stringWithFormat:@"%ld", i]
#define kValidStr(str) [NHUtils validString:str]


#endif /* ZHNDefaultHeader_h */
