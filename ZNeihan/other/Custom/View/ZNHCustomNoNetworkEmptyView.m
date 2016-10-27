//
//  ZNHCustomNoNetworkEmptyView.m
//  ZNeihan
//
//  Created by zengruofan on 16/10/27.
//  Copyright © 2016年 曾若凡. All rights reserved.
//  没有网络时候显示的图

#import "ZNHCustomNoNetworkEmptyView.h"
#import "UIView+Frame.h"

@interface ZNHCustomNoNetworkEmptyView ()

@property (nonatomic, weak) UIImageView *topTipImageView;

@property (nonatomic, weak) UIButton *retrybtn;

@end

@implementation ZNHCustomNoNetworkEmptyView

-(UIImageView *)topTipImageView {
    if(!_topTipImageView){
        UIImageView *img = [[UIImageView alloc] init];
        [self addSubview:img];
        _topTipImageView = img;
        img.layer.masksToBounds = YES;
        img.backgroundColor = kCommonBgColor;
    }
    return _topTipImageView;
}

-(UIButton *)retrybtn {
    if(!_retrybtn){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        _retrybtn = btn;
        
        btn.backgroundColor = kOrangeColor;
        [btn setTitle:@"马上重试" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = kFont(15);
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.adjustsImageWhenDisabled = NO;
        btn.adjustsImageWhenHighlighted = NO;
    }
    return _retrybtn;
}

-(void)btnClick:(UIButton *)btn {
    if (_customNoNetworkEmptyViewDidClickRetryHandle) {
        self.customNoNetworkEmptyViewDidClickRetryHandle(self);
    }
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat topTipW = 100;
    CGFloat topTipX = kScreenWidth / 2.0 - topTipW / 2.0;
    CGFloat topTipY = 150;
    CGFloat topTipH = 100;
    self.topTipImageView.frame = CGRectMake(topTipX, topTipY, topTipW, topTipH);
    
    CGFloat retryX = topTipX + 20;
    CGFloat retryY = self.topTipImageView.bottom + 15;
    CGFloat retryW = 60;
    CGFloat retryH = 25;
    self.retrybtn.frame = CGRectMake(retryX, retryY, retryW, retryH);
}

@end
