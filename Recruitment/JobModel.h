//
//  JobModel.h
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/8.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JobModel : NSObject

// 职位
@property (nonatomic,strong) NSString *company_name;
@property (nonatomic,strong) NSString *gender;
@property (nonatomic,strong) NSString *ID;// 职位id
@property (nonatomic,strong) NSString *info;// 岗位要求
@property (nonatomic,strong) NSString *job_name;
@property (nonatomic,strong) NSString *pay;
@property (nonatomic,strong) NSString *nums;
@property (nonatomic,strong) NSString *update_time;
@property (nonatomic,assign) BOOL isSelected;

// 职位详情
@property (nonatomic,strong) NSString *area;
@property (nonatomic,strong) NSString *edu;
@property (nonatomic,strong) NSString *cate_name;
@property (nonatomic,strong) NSString *jobs;// 职业类型
@property (nonatomic,strong) NSString *tele;
@property (nonatomic,strong) NSString *logo;
@property (nonatomic,strong) NSString *years;
@property (nonatomic,strong) NSString *persons;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *companyId;
@property (nonatomic,strong) NSString *favs;
@property (nonatomic,strong) NSArray *related_work;
@property (nonatomic,strong) NSString *resume; // 1已投递  0 未投递


// 公司详情
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *web;
//@property (nonatomic,strong) NSString *cid;

@end
