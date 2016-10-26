//
//  ZNHCustomLoadingAnimationView.m
//  ZNeihan
//
//  Created by zengruofan on 16/10/26.
//  Copyright © 2016年 曾若凡. All rights reserved.
//

#import "ZNHCustomLoadingAnimationView.h"

@interface ZNHCustomLoadingAnimationView ()

@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, strong) NSMutableArray *imageArray;

@end

@implementation ZNHCustomLoadingAnimationView

-(instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor =  [UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.00f];
    }
    return self;
}

-(void)showInView:(UIView *) view {

}

-(void)dismiss {

}

-(NSMutableArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [NSMutableArray new];
    }
    return _imageArray;
}

-(UIImageView *) imageView {
    if (!_imageView) {
        UIImageView *img = [[UIImageView alloc] init];
        [self addSubview:img];
        _imageView = img;
        for (NSInteger i = 0; i<17 ; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refreshjoke_loading_%ld", i%17]];
            [self.imageArray addObject:image];
        }
        self.imageView.animationDuration = 1.0;
        self.imageView.animationRepeatCount = 0;
        self.imageView.animationImages = self.imageArray;
    }
    return _imageView;
}


@end
