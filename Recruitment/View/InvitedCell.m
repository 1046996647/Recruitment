//
//  InvitedCell.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/11.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "InvitedCell.h"
#import "NSStringExt.h"

@implementation InvitedCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        

        _companyLab = [UILabel labelWithframe:CGRectMake(15, 10, kScreen_Width-15-12, 17) text:@"福田龙飞进出口有限公司" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self.contentView addSubview:_companyLab];
        
        _jobLab = [UILabel labelWithframe:CGRectMake(_companyLab.left, _companyLab.bottom+12, _companyLab.width, 13) text:@"" font:[UIFont systemFontOfSize:11] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
        [self.contentView addSubview:_jobLab];
        
        NSString *str1 = @"保险代理人";
        NSMutableAttributedString *attStr = [NSString text:str1 fullText:[NSString stringWithFormat:@"邀请你参加%@面试",str1] location:5 color:[UIColor colorWithHexString:@"#FF9123"] font:nil];
        _jobLab.attributedText = attStr;
        
        _timeLab = [UILabel labelWithframe:CGRectMake(_companyLab.left, _jobLab.bottom+8, _companyLab.width, 13) text:@"150-500人" font:[UIFont systemFontOfSize:11] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
        [self.contentView addSubview:_timeLab];
        
        
        
    }
    return self;
}

- (void)setModel:(JobModel *)model
{
    _model = model;
    
    _companyLab.text = model.title;
    
    NSString *str1 = model.jobName;
    NSMutableAttributedString *attStr = [NSString text:str1 fullText:[NSString stringWithFormat:@"邀请你参加%@面试",str1] location:5 color:[UIColor colorWithHexString:@"#FF9123"] font:nil];
    _jobLab.attributedText = attStr;

}












@end
