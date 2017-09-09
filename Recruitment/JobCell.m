//
//  JobCell.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/7.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "JobCell.h"

@implementation JobCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _selectBtn = [UIButton buttonWithframe:CGRectZero text:nil font:nil textColor:nil backgroundColor:nil normal:@"31" selected:@""];
        [self.contentView addSubview:_selectBtn];

        
        _jobLab = [UILabel labelWithframe:CGRectMake(13, 10, 150, 20) text:@"福田店面销售代表" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
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
        
        //单行滚动  ===============
        NSArray *tagAry = @[@"薪假",@"公游",@"保险"];
        //    单行不需要设置高度,内部根据初始化参数自动计算高度
        _tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(_jobLab.left, _companyLab.bottom, 150, 0)];
        _tagsView.type = 1;
        _tagsView.tagHorizontalSpace = 5.0;
        _tagsView.showsHorizontalScrollIndicator = NO;
        _tagsView.tagHeight = 15.0;
        _tagsView.titleSize = 10.0;
        _tagsView.tagOriginX = 0.0;
        _tagsView.titleColor = [UIColor colorWithHexString:@"#666666"];
        _tagsView.cornerRadius = _tagsView.tagHeight/2;
        _tagsView.userInteractionEnabled = NO;
        _tagsView.backgroundColor = [UIColor clearColor];
        _tagsView.borderColor = [UIColor colorWithHexString:@"#FFDDB0"];
        [_tagsView setTagAry:tagAry delegate:nil];
        [self.contentView addSubview:_tagsView];
        
        
    }
    return self;
}

- (void)setModel:(JobModel *)model
{
    _model = model;
    
    if (self.type == 1) {
        
        _selectBtn.frame = CGRectMake(14, (90-15)/2, 15, 15);
        
        _jobLab.left = _selectBtn.right+12;
        _companyLab.left = _jobLab.left;
        _tagsView.left = _jobLab.left;
    }
}

@end
