//
//  JobRecommandCell.h
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/12.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXTagsView.h"
#import "JobModel.h"

@interface JobRecommandCell : UITableViewCell

@property(nonatomic,strong) UILabel *jobLab;
@property(nonatomic,strong) UILabel *companyLab;
@property(nonatomic,strong) UILabel *moneyLab;
@property(nonatomic,strong) UILabel *kmLab;
@property(nonatomic,strong) UIImageView *logoView;
@property(nonatomic,strong) UIButton *decBtn;

@property(nonatomic,strong) UIImageView *chatView;
@property(nonatomic,strong) HXTagsView *tagsView;
@property(nonatomic,strong) JobModel *model;

@end
