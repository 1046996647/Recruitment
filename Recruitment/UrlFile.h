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
#define BaseUrl  @"http://api.52ykjob.com:8080/52dyjob/index.php/"

// 调试
//#define BaseUrl  @"http://106.14.212.85:8080/52dyjob/index.php/"

// 注册
#define Regist  [NSString stringWithFormat:@"%@User/regist",BaseUrl]

// 注册时个人信息
#define Update_peronal_info  [NSString stringWithFormat:@"%@User/update_peronal_info",BaseUrl]

// 2.3	获取热门职位
#define Get_hot_jobs  [NSString stringWithFormat:@"%@Jobs/get_hot_jobs",BaseUrl]

// 2.1	搜索职位
#define Get_jobs_list  [NSString stringWithFormat:@"%@Jobs/get_jobs_list",BaseUrl]

// 2.2	职位详情
#define Get_jobs_detail  [NSString stringWithFormat:@"%@Jobs/detail",BaseUrl]

// 3.1	公司详情
#define Get_company_detail  [NSString stringWithFormat:@"%@Company/detail",BaseUrl]

// 1.4	更新基本信息
#define Update_basic_info  [NSString stringWithFormat:@"%@User/update_basic_info",BaseUrl]

// 1.4	更新联系方式
#define Update_contact_info  [NSString stringWithFormat:@"%@User/update_contact_info",BaseUrl]

// 1.4	更新求职意向
#define Update_hope_info  [NSString stringWithFormat:@"%@User/update_hope_info",BaseUrl]

// 1.4	更新技能特长
#define Update_skill_info  [NSString stringWithFormat:@"%@User/update_skill_info",BaseUrl]

// 1.10	更新教育经历
#define Update_educate_info  [NSString stringWithFormat:@"%@User/update_educate_info",BaseUrl]

// 1.11	新增工作经历
#define Add_jobhistory_info  [NSString stringWithFormat:@"%@User/add_jobhistory_info",BaseUrl]

// 1.12	删除工作经历
#define Delete_jobhistory_info  [NSString stringWithFormat:@"%@User/delete_jobhistory_info",BaseUrl]

// 1.13	修改工作经历
#define Update_jobhistory_info  [NSString stringWithFormat:@"%@User/update_jobhistory_info",BaseUrl]


// 选择项(个人信息)
#define Get_setting  [NSString stringWithFormat:@"%@Tool/get_setting",BaseUrl]

// 选择项(岗位)
#define Get_jobs_cate  [NSString stringWithFormat:@"%@User/get_jobs_cate",BaseUrl]

// 登录
#define Login  [NSString stringWithFormat:@"%@User/login",BaseUrl]

// 返回用户表该用户所有信息
#define Get_user_info  [NSString stringWithFormat:@"%@User/get_user_info",BaseUrl]

// 获取部分用户信息
#define Get_ui_info  [NSString stringWithFormat:@"%@User/get_ui_info",BaseUrl]

// 获取用户工作经历
#define Get_work_exp  [NSString stringWithFormat:@"%@QuickGet/get_work_exp",BaseUrl]

// 1.13	删除工作经历
#define Delete_jobhistory_info  [NSString stringWithFormat:@"%@User/delete_jobhistory_info",BaseUrl]

// 1.16	上传头像
#define Upload_user_img  [NSString stringWithFormat:@"%@User/upload_user_img",BaseUrl]


#endif /* UrlFile_h */
