//
//  JobDetailVC.h
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/8.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BaseViewController.h"
#import "JobModel.h"

@interface JobDetailVC : BaseViewController

@property(nonatomic,assign) NSInteger type;

@property (nonatomic,strong) JobModel *model;
@property (nonatomic,strong) NSString *compChatId;

@end
