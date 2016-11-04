//
//  UIView+Tap.h
//  ZNeihan
//
//  Created by zengruofan on 16/11/4.
//  Copyright © 2016年 曾若凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Tap)

// 动态添加手势
- (void)setTapActionWithBlock:(void (^)(void))block ;

@end
