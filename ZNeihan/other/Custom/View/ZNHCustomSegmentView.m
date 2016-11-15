//
//  ZNHCustomSegmentView.m
//  ZNeihan
//
//  Created by zengruofan on 16/11/11.
//  Copyright © 2016年 曾若凡. All rights reserved.
//

#import "ZNHCustomSegmentView.h"
#import "UIView+Layer.h"

@implementation ZNHCustomSegmentView {
    NSArray *_itemTitles;
    UIButton *_selectedBtn;
}

- (instancetype)initWithItemTitle:(NSArray *)itemTitles {
    if (self = [super init]) {
        _itemTitles = itemTitles;
        
        self.layerCornerRadius = 3.0;
        self.layerBorderColor = kCommonTintColor;
        self.layerBorderWidth = 1.0;
        
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews{
    if (_itemTitles.count > 0) {
        NSInteger i = 0;
        for (id obj in _itemTitles) {
            if ([obj isKindOfClass:[NSString class]]) {
                NSString *objStr = (NSString *)obj;
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                [self addSubview:btn];
                btn.backgroundColor = kCommonBgColor;
                [btn setTitle:objStr forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
                [btn setTitleColor:[UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1.0f] forState:UIControlStateNormal];
                btn.titleLabel.font = kFont(16);
                i = i+1;
                btn.tag = i;
                [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                btn.adjustsImageWhenDisabled = NO;
                btn.adjustsImageWhenHighlighted = NO;
            }
        }
    }
}

- (void)clickDefault{
    if (_itemTitles.count == 0) {
        return;
    }
    [self btnClick:(UIButton *)[self viewWithTag:1]];
}

- (void)btnClick:(UIButton *)btn {
    _selectedBtn.backgroundColor = kCommonBgColor;
    btn.backgroundColor = [UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1.00f];
    
    _selectedBtn.selected = NO;
    btn.selected = YES;
    _selectedBtn = btn;
    
    NSString *title = btn.currentTitle;
    if (self.ZNHCustomSegmentViewBtnClickHandle) {
        self.ZNHCustomSegmentViewBtnClickHandle(self, title, btn.tag - 1);
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (_itemTitles.count > 0) {
        CGFloat btnw = self.width / _itemTitles.count;
        for (int i=0; i<_itemTitles.count; i++) {
            UIButton *btn = (UIButton *)[self viewWithTag:i+1];
            btn.frame = CGRectMake(btnw * i, 0, btnw, self.height);
        }
    }
}

@end
