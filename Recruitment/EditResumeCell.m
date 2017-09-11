//
//  EditResumeCell.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/9.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "EditResumeCell.h"

@implementation EditResumeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _imgView = [UIImageView imgViewWithframe:CGRectMake(10, (self.contentView.height-14)/2.0, 12, 12) icon:@"91"];
        [self.contentView addSubview:_imgView];
        
        _timeLab = [UILabel labelWithframe:CGRectMake(_imgView.right+11, 10, 97, 14) text:@"2016.09-2017.09" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self.contentView addSubview:_timeLab];
        
        _jobLab = [UILabel labelWithframe:CGRectMake(_timeLab.left, _timeLab.bottom+6, 150, _timeLab.height) text:@"福田店面销售代表" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
        [self.contentView addSubview:_jobLab];
        
        _companyLab = [UILabel labelWithframe:CGRectMake(_jobLab.left, _jobLab.bottom+6, 150, _timeLab.height) text:@"福田龙飞进出口有限公司" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
        [self.contentView addSubview:_companyLab];
        
        _responsibilityLab = [UILabel labelWithframe:CGRectMake(_jobLab.left, _companyLab.bottom+6, kScreen_Width-12-(_jobLab.left), _timeLab.height) text:@"独立完成项目，从交互原型到效果图设计、切图标注等工作。" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
        [self.contentView addSubview:_responsibilityLab];
        
        
        _line = [[UIView alloc] initWithFrame:CGRectMake(_imgView.center.x-.5, _imgView.bottom, 1, 71)];
        _line.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
        [self.contentView addSubview:_line];
        
        UIButton *jobEditBtn = [UIButton buttonWithframe:CGRectMake(kScreen_Width-20-10, 8, 20, 20) text:nil font:nil textColor:nil backgroundColor:nil normal:@"95" selected:nil];
//        [jobEditBtn addTarget:self action:@selector(wantAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:jobEditBtn];
        self.jobEditBtn = jobEditBtn;
        
    }
    return self;
}



@end
