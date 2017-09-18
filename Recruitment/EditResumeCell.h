//
//  EditResumeCell.h
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/9.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonModel.h"


@interface EditResumeCell : UITableViewCell

@property(nonatomic,strong) UIImageView *imgView;
@property(nonatomic,strong) UIView *hLine;
@property(nonatomic,strong) UILabel *jobLab;
@property(nonatomic,strong) UILabel *companyLab;
@property(nonatomic,strong) UILabel *responsibilityLab;
@property(nonatomic,strong) UILabel *extraLab;
@property(nonatomic,strong) UIView *line;

@property(nonatomic,strong) UILabel *timeLab;
@property(nonatomic,strong) UIView *hLine1;
@property(nonatomic,strong) UIView *view;
@property(nonatomic,strong) UIButton *jobEditBtn;

@property(nonatomic,strong) PersonModel *model;
@property(nonatomic,strong) NSIndexPath *indexPath;

@end
