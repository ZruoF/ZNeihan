//
//  UIView+Layer.h
//  ZNeihan
//
//  Created by zengruofan on 16/11/3.
//  Copyright © 2016年 曾若凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Layer)

- (void)setLayerCornerRadius: (CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

// 边角半径
@property (nonatomic, assign) CGFloat layerCornerRadius;
// 边线宽度
@property (nonatomic, assign) CGFloat layoutBorderWidth;
// 边线颜色
@property (nonatomic, strong) UIColor *layerBorderColor;

@end
