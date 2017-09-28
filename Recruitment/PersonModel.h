//
//  PersonalModel.h
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/9.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonModel : NSObject<NSCoding>

// 自加
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *key;
@property(nonatomic,strong) NSString *text;
@property(nonatomic,strong) NSString *image;


@property(nonatomic,strong) NSString *userid;// 电话
@property(nonatomic,strong) NSString *uid;
@property(nonatomic,strong) NSString *passwd;
@property(nonatomic,strong) NSString *phone;// 手机
@property(nonatomic,strong) NSString *tele;// 手机
@property(nonatomic,strong) NSString *name;// 姓名
@property(nonatomic,strong) NSString *political;// 政治面貌
@property(nonatomic,strong) NSString *img;// 姓名
@property(nonatomic,strong) NSString *sex;// 头像
@property(nonatomic,strong) NSString *email;// 姓名
@property(nonatomic,strong) NSString *nation;// 民族
@property(nonatomic,strong) NSString *jiguan;// 籍贯
@property(nonatomic,strong) NSString *height;// 身高
@property(nonatomic,strong) NSString *type;// 人才类型
@property(nonatomic,strong) NSString *birth;// 生日
@property(nonatomic,strong) NSString *marry;// 婚姻状况
@property(nonatomic,strong) NSString *weight;// 体重
@property(nonatomic,strong) NSString *home;// 所在地
@property(nonatomic,strong) NSString *qq;
@property(nonatomic,strong) NSString *address;// 地址
@property(nonatomic,strong) NSString *requestjobtype;// 求职类型
@property(nonatomic,strong) NSString *requestsalary;// 待遇要求
@property(nonatomic,strong) NSString *requeststay;// 住房要求
@property(nonatomic,strong) NSString *jobstatus;// 到岗状况
@property(nonatomic,strong) NSString *hopepostion;// 期望职位
@property(nonatomic,strong) NSString *hopelocation;// 期望地区
@property(nonatomic,strong) NSString *graduatedfrom;// 毕业院校
@property(nonatomic,strong) NSString *education;// 学历
@property(nonatomic,strong) NSString *speciality;// 专业
@property(nonatomic,strong) NSString *graduatetime;// 毕业时间
@property(nonatomic,strong) NSString *foreignlanguage;// 第一外语
@property(nonatomic,strong) NSString *foreignlanguagelevel;// 外语水平
@property(nonatomic,strong) NSString *computerlevel;// 计算机水平
@property(nonatomic,strong) NSString *otherability;// 其他能力
@property(nonatomic,strong) NSString *certificate;// 相关证书
@property(nonatomic,strong) NSString *educationhistory;// 教育培训经历
@property(nonatomic,strong) NSString *jobyear;// 工作年限
@property(nonatomic,strong) NSString *selfevaluation;// 自我评价
@property(nonatomic,strong) NSString *views;// 简历浏览数
@property(nonatomic,strong) NSString *is_locks;// 是否锁定
@property(nonatomic,strong) NSString *is_hide;// 是否隐藏
@property(nonatomic,strong) NSString *form_percent;// 简历完善度
@property(nonatomic,strong) NSString *resumeNum;// 投递过的简历数量


@property(nonatomic,strong) NSArray *jobhistory;// 工作经历
@property(nonatomic,strong) NSString *begin_time;// 入职时间
@property(nonatomic,strong) NSString *end_time;// 离职时间
@property(nonatomic,strong) NSString *company_name;// 公司名称
@property(nonatomic,strong) NSString *position;// 职位
@property(nonatomic,strong) NSString *skill;// 工作内容
@property(nonatomic,strong) NSString *company_nature;// 公司性质

// 订阅职位
//@property(nonatomic,strong) NSString *key;// 关键词
@property(nonatomic,strong) NSString *area;// 工作地点
@property(nonatomic,strong) NSString *years;// 工作经验
@property(nonatomic,strong) NSString *edu;// 学历要求
@property(nonatomic,strong) NSString *ID;


@property(nonatomic,assign) NSInteger cellHeight;

@end
