//
//  MyAttentionCell.h
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/21.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobModel.h"

@interface MyAttentionCell : UITableViewCell

@property(nonatomic,strong) UIImageView *imgView;
@property(nonatomic,strong) UILabel *jobLab;
@property(nonatomic,strong) UILabel *companyLab;
@property(nonatomic,strong) UILabel *personsLab;
@property(nonatomic,strong) UILabel *timeLab;
@property(nonatomic,strong) JobModel *model;

@end
