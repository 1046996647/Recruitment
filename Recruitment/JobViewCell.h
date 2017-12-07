//
//  JobViewCell.h
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/12/4.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HXTagsView.h"
#import "JobViewModel.h"

@interface JobViewCell : UITableViewCell

@property(nonatomic,strong) HXTagsView *tagsView;
@property(nonatomic,strong) UILabel *jobLab;
@property(nonatomic,strong) JobViewModel *model;


@end
