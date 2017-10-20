//
//  JobDetailCell.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/8.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "JobDetailCell.h"

@implementation JobDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        
        _jobLab = [UILabel labelWithframe:CGRectMake(13, 10, 150, 20) text:@"饰品抛光" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self.contentView addSubview:_jobLab];
        
        _companyLab = [UILabel labelWithframe:CGRectMake(_jobLab.left, _jobLab.bottom+8, 150, 18) text:@"福田龙飞进出口有限公司" font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
        [self.contentView addSubview:_companyLab];
        
        _moneyLab = [UILabel labelWithframe:CGRectMake(kScreen_Width-34-12, 12, 34, 18) text:@"6-7k" font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentRight textColor:@"#CE4A12"];
        [self.contentView addSubview:_moneyLab];
        
        _kmLab = [UILabel labelWithframe:CGRectMake(kScreen_Width-37-12, _moneyLab.bottom+6, 37, 17) text:@"5.2km" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentRight textColor:@"#999999"];
        [self.contentView addSubview:_kmLab];
        
        _addressView = [UIImageView imgViewWithframe:CGRectMake(_kmLab.left-10-7, _kmLab.center.y-7, 10, 13) icon:@""];
        _addressView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_addressView];
        
        _timeLab = [UILabel labelWithframe:CGRectMake(kScreen_Width-39-12, _kmLab.bottom+6, 39, 17) text:@"08-28" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentRight textColor:@"#999999"];
        [self.contentView addSubview:_timeLab];
        

        
        
    }
    return self;
}

- (void)setModel:(JobModel *)model
{
    _model = model;
    
//    _jobLab.left = 12;
//    _companyLab.left = _jobLab.left;
    //        _tagsView.left = _jobLab.left;
    
    _jobLab.text = model.job_name;
    _companyLab.text = model.company_name;
    _timeLab.text = model.update_time;
    _moneyLab.text = [NSString stringWithFormat:@"%@",model.pay];
    
}
@end
