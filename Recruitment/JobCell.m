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
        
        _selectBtn = [UIButton buttonWithframe:CGRectZero text:nil font:nil textColor:nil backgroundColor:nil normal:@"31" selected:@"Rectangle 12"];
        [self.contentView addSubview:_selectBtn];
        [_selectBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];

        
        // 6-7k
        _moneyLab = [UILabel labelWithframe:CGRectMake(kScreen_Width-90-12, 12, 90, 18) text:@"" font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentRight textColor:@"#CE4A12"];
        [self.contentView addSubview:_moneyLab];
//        _moneyLab.backgroundColor = [UIColor redColor];
        
        // 福田店面销售代表
        _jobLab = [UILabel labelWithframe:CGRectMake(13, 10, _moneyLab.left-13-10, 20) text:@"" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self.contentView addSubview:_jobLab];
        
        // 5.2km
        _kmLab = [UILabel labelWithframe:CGRectMake(kScreen_Width-37-12, _moneyLab.bottom+6, 37, 17) text:@"" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentRight textColor:@"#999999"];
        [self.contentView addSubview:_kmLab];
        
        
        _addressView = [UIImageView imgViewWithframe:CGRectMake(_kmLab.left-10-7, _kmLab.center.y-7, 10, 13) icon:@"40"];
        _addressView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_addressView];
        
        // 福田龙飞进出口有限公司
        _companyLab = [UILabel labelWithframe:CGRectMake(_jobLab.left, _jobLab.bottom+8, _addressView.left-_jobLab.left-10, 18) text:@"" font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
        [self.contentView addSubview:_companyLab];
        
        // 08-28
        _timeLab = [UILabel labelWithframe:CGRectMake(kScreen_Width-39-12, _kmLab.bottom+6, 39, 17) text:@"" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentRight textColor:@"#999999"];
        [self.contentView addSubview:_timeLab];
        
        [self.contentView addSubview:self.tagsView];

        
    }
    return self;
}

- (HXTagsView *)tagsView
{
    if (!_tagsView) {
        //        NSArray *tagAry = @[@"薪假",@"公游",@"保险"];
        //    单行不需要设置高度,内部根据初始化参数自动计算高度
        _tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(13, _companyLab.bottom, _timeLab.left-13-5, 0)];
        _tagsView.type = 0;
        _tagsView.tagHorizontalSpace = 8.0;
        _tagsView.showsHorizontalScrollIndicator = NO;
        _tagsView.tagHeight = 22;
        _tagsView.titleSize = 12.0;
        _tagsView.tagOriginX = 0.0;
        _tagsView.titleColor = [UIColor colorWithHexString:@"#666666"];
        _tagsView.cornerRadius = _tagsView.tagHeight/2;
        _tagsView.userInteractionEnabled = NO;
        _tagsView.backgroundColor = [UIColor clearColor];
        _tagsView.borderColor = [UIColor colorWithHexString:@"#FFDDB0"];
        //        [_tagsView setTagAry:tagAry delegate:nil];
    }
    
    return _tagsView;
}

- (void)selectAction:(UIButton *)btn
{
    _model.isSelected = !_model.isSelected;
    btn.selected = _model.isSelected;
    
    if (self.block) {
        self.block(_model);
    }
}

- (void)setModel:(JobModel *)model
{
    _model = model;
    
    if (self.type == 1) {
        
        _selectBtn.frame = CGRectMake(0, 0, 44, 90);
        
        _jobLab.left = _selectBtn.right;
        _companyLab.left = _jobLab.left;
//        _tagsView.left = _jobLab.left;


    }
    
    if (_model.tag) {
        
        _tagsView.hidden = NO;
        
        NSArray *tagArr = [_model.tag componentsSeparatedByString:@","];

        [_tagsView setTagAry:tagArr delegate:nil];
        
        
        _model.cellHeight = _tagsView.bottom;


    }
    else {
        _tagsView.hidden = YES;

    }
    
    
    _jobLab.text = model.job_name;
    _companyLab.text = model.company_name;
    _timeLab.text = model.update_time;
    _moneyLab.text = [NSString stringWithFormat:@"%@",model.pay];
    _selectBtn.selected = _model.isSelected;
    _kmLab.text = model.area;

}

@end
