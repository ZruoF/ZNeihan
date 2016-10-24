//
//  UIBarButtonItem+Addition.h
//  ZNeihan
//
//  Created by zengruofan on 16/10/24.
//  Copyright © 2016年 曾若凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Addition)
// 快速创建一个UIBarButtonItem对象 通过给定的标题和 tintcolor
+(instancetype)itemWithTitle:(NSString *) title tintColor:(UIColor *)tintColor touchBack:(void(^)())block;

@end
