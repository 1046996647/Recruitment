//
//  HelpMac.h
//  XiaoYing
//
//  Created by ZWL on 15/10/12.
//  Copyright (c) 2015年 ZWL. All rights reserved.
//

#ifndef RequestUrl_h
#define RequestUrl_h

//----------------------系统----------------------------
//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define iOS_Version_9  [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0

//是否是iOS 7 及 以上版本
#define iOS_Version_7  [[[UIDevice currentDevice] systemVersion] floatValue] > 7.0

//是否是iOS 8 及 以上版本
#define iOS_Version_8  [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0

#define Is_iOS_Version_7  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)?YES:NO


//判断iphone5
#define IS_IPHONE_5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

//判断iphone6
#define IS_iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

//判断iphone6+
#define IS_iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

//判断iphoneX
#define Device_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)


//-------------------获取设备大小尺寸-------------------------
//设备屏幕尺寸 屏幕Size
// iPhoneX适配(iPhone X状态条由20px变成了44px，UITabBar由49px变成了83px):减去24是我在代码里已经减去了64，减去34是49px变成了83px
#define kScreen_Height (Device_Is_iPhoneX ? ([UIScreen mainScreen].bounds.size.height - 24 - 34) : ([UIScreen mainScreen].bounds.size.height))

#define kScreen_Width ([UIScreen mainScreen].bounds.size.width)



#define scaleWidth kScreen_Width/375
#define scaleY kScreen_Height/568

//#define scaleX kScreen_Width/320

// 字体大小
#define SystemFont(size) [UIFont systemFontOfSize:size]

// 颜色
#define colorWithHexStr(str) [UIColor colorWithHexString:str];



// -------------------重写NSLog------------------------
#ifdef DEBUG
#define NSLog(format, ...) fprintf(stderr, "\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String])
#else
#define NSLog(format, ...) nil
#endif



#endif /* RequestUrl_h */


