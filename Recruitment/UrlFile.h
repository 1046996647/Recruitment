//
//  UrlFile.h
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/13.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#ifndef UrlFile_h
#define UrlFile_h

// 服务器
#define BaseUrl  @"http://106.14.212.85:8080/52dyjob/index.php/"

// 调试
//#define BaseUrl  @"http://106.14.212.85:8080/52dyjob/index.php/"

// 注册
#define Regist  [NSString stringWithFormat:@"%@User/regist",BaseUrl]

// 注册时个人信息
#define Update_peronal_info  [NSString stringWithFormat:@"%@User/update_peronal_info",BaseUrl]

// 1.4	更新基本信息
#define Update_basic_info  [NSString stringWithFormat:@"%@User/update_basic_info",BaseUrl]


// 选择项
#define Get_setting  [NSString stringWithFormat:@"%@Tool/get_setting",BaseUrl]

// 登录
#define Login  [NSString stringWithFormat:@"%@User/login",BaseUrl]

// 返回用户表该用户相关信息
#define Get_user_info  [NSString stringWithFormat:@"%@User/get_user_info",BaseUrl]


#endif /* UrlFile_h */
