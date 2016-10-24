//
//  NSNotificationCenter+Addtion.m
//  ZNeihan
//
//  Created by zengruofan on 16/10/24.
//  Copyright © 2016年 曾若凡. All rights reserved.
//

#import "NSNotificationCenter+Addtion.h"

@implementation NSNotificationCenter(Addtion)

// 只发送一个通知
+(void)postNotification:(NSString *)notiname {
    [[NSNotificationCenter defaultCenter] postNotificationName:notiname object:nil];
}

/*
 *  发送一个通知
 *  @param notiname 通知名字
 *  @param object 通知内容
 */
+(void)postNotification:(NSString *)notiname object:(id)object {
    if (object == nil) {
        [self postNotification:notiname];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:notiname object:object userInfo:nil];
    }
}

/*
 * 移除所有通知的注册者
 */
+(void)removeAllObserverForObj:(id)obj {
    [[NSNotificationCenter defaultCenter] removeObserver:obj];
}

// 注册一个通知
+(void)addObserver:(id)observer action:(SEL)action name:(NSString *)name {
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:action name:name object:nil];
}

@end
