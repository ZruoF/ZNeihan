//
//  UIBarButtonItem+Addition.m
//  ZNeihan
//
//  Created by zengruofan on 16/10/24.
//  Copyright © 2016年 曾若凡. All rights reserved.
//

#import "UIBarButtonItem+Addition.h"
#import <objc/runtime.h>

typedef void (^ActionBlock)();
static char itemBlockKey;


@implementation UIBarButtonItem(Addition)

+(instancetype)itemWithTitle:(NSString *) title
                   tintColor:(UIColor *)tintColor
                   touchBack:(void(^)())block {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(itemTouch:)];
    item.tintColor = tintColor;
    item.block = block;
    return item;
}

+(void) itemTouch:(UIBarButtonItem *) item {
    if (item.block){
        item.block();
    }
}

-(void)setBlock:(ActionBlock) block {
    objc_setAssociatedObject(self, &itemBlockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(ActionBlock) block {
    return objc_getAssociatedObject(self, &itemBlockKey);
}

@end
