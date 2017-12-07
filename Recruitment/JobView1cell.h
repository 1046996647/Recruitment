//
//  JobView1cell.h
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/12/4.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobViewModel.h"

@interface JobView1cell : UITableViewCell

@property(nonatomic,strong) UIButton *selectBtn;
@property(nonatomic,strong) JobViewModel *model;
@property(nonatomic,strong) UILabel *jobLab;
@property(nonatomic,assign) NSInteger row;
@property(nonatomic,assign) NSInteger tag;


@end
