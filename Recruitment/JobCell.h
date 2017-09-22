//
//  JobCell.h
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/7.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HXTagsView.h"
#import "JobModel.h"

typedef void(^JobSendModelBlock)(JobModel *model);

@interface JobCell : UITableViewCell

@property(nonatomic,strong) UIButton *selectBtn;
@property(nonatomic,strong) UILabel *jobLab;
@property(nonatomic,strong) UILabel *companyLab;
@property(nonatomic,strong) UILabel *moneyLab;
@property(nonatomic,strong) UILabel *kmLab;
@property(nonatomic,strong) UILabel *timeLab;
@property(nonatomic,strong) UIImageView *addressView;
@property(nonatomic,strong) HXTagsView *tagsView;


@property(nonatomic,strong) JobModel *model;
@property(nonatomic,assign) NSInteger type;

@property(nonatomic,copy) JobSendModelBlock block;

@end
