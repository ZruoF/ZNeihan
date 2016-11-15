//
//  ZNHCustomSegmentView.h
//  ZNeihan
//
//  Created by zengruofan on 16/11/11.
//  Copyright © 2016年 曾若凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZNHCustomSegmentView : UIView

- (instancetype)initWithItemTitle:(NSArray *)itemTitles;


// 从0开始
@property (nonatomic, copy) void(^ZNHCustomSegmentViewBtnClickHandle)(ZNHCustomSegmentView *segment, NSString *currentTitle, NSInteger currentIndex);

- (void)clickDefault;

@end
