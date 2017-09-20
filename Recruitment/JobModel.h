//
//  JobModel.h
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/8.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JobModel : NSObject

@property (nonatomic,strong) NSString *company_name;
@property (nonatomic,strong) NSString *gender;
@property (nonatomic,strong) NSString *ID;
@property (nonatomic,strong) NSString *info;// 岗位要求
@property (nonatomic,strong) NSString *job_name;
@property (nonatomic,strong) NSString *pay;
@property (nonatomic,strong) NSString *nums;
@property (nonatomic,strong) NSString *update_time;
@property (nonatomic,assign) BOOL isSelected;



@end
