//
//  UIView+Frame.h
//  ZNeihan
//
//  Created by zengruofan on 16/10/27.
//  Copyright © 2016年 曾若凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView(Frame)

// 起点 x 坐标
@property (nonatomic, assign) CGFloat x;

// 起点 y 坐标
@property (nonatomic, assign) CGFloat y;

// 中心 x 坐标
@property (nonatomic, assign) CGFloat centerX;

// 中心 y 坐标
@property (nonatomic, assign) CGFloat centerY;

// 宽度
@property (nonatomic, assign) CGFloat width;

// 高度
@property (nonatomic, assign) CGFloat height;

// 顶部
@property (nonatomic, assign) CGFloat top;

// 底部
@property (nonatomic, assign) CGFloat bottom;

// 左边
@property (nonatomic, assign) CGFloat left;

// 右边
@property (nonatomic, assign) CGFloat right;

// size
@property (nonatomic, assign) CGSize size;

// 起点坐标
@property (nonatomic, assign) CGPoint origin;

@end
