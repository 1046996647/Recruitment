//
//  UITabBar+badge.h
//  Recruitment
//
//  Created by ZhangWeiLiang on 2018/1/26.
//  Copyright © 2018年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (badge)

- (void)showBadgeOnItemIndex:(int)index;   //显示小红点

- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点

@end
