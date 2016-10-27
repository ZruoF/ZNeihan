//
//  UIView+Frame.m
//  ZNeihan
//
//  Created by zengruofan on 16/10/27.
//  Copyright © 2016年 曾若凡. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView(Frame)

// x
-(void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

-(CGFloat) x {
    return self.frame.origin.x;
}

// y
-(void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

-(CGFloat) y {
    return self.frame.origin.y;
}

// centerX
-(void)setCenterX:(CGFloat)centerX {
    CGPoint point = self.center;
    point.x = centerX;
    self.center = point;
}

-(CGFloat) centerX {
    return self.center.x;
}

// centerY
-(void)setCenterY:(CGFloat)centerY {
    CGPoint point = self.center;
    point.y = centerY;
    self.center = point;
}

-(CGFloat) centerY {
    return self.center.y;
}

// width
-(void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

-(CGFloat) width {
    return self.frame.size.width;
}

// height
-(void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

-(CGFloat) height {
    return self.frame.size.height;
}

// top;
-(void)setTop:(CGFloat)top {
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

-(CGFloat) top {
    return self.frame.origin.y;
}

// bottom;
-(void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - self.frame.size.height;
    self.frame = frame;
}

-(CGFloat) bottom {
    return self.frame.origin.y + self.frame.size.height;
}

// left;
-(void)setLeft:(CGFloat)left {
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

-(CGFloat) left {
    return self.frame.origin.x;
}

// right;
-(void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - self.frame.size.width;
    self.frame = frame;
}

-(CGFloat) right {
    return self.frame.origin.x + self.frame.size.width;
}

// size
-(void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

-(CGSize) size {
    return self.frame.size;
}

// origin
-(void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

-(CGPoint) origin {
    return self.frame.origin;
}

@end
