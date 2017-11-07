//
//  MyAttentionCell.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/21.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "MyAttentionCell.h"

@implementation MyAttentionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _imgView = [UIImageView imgViewWithframe:CGRectMake(12, (90-60)/2.0, 60, 60) icon:nil];
        _imgView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_imgView];
        
        _companyLab = [UILabel labelWithframe:CGRectMake(_imgView.right+12, 9, kScreen_Width-(_imgView.right+12)-12, 20) text:@"福田龙飞进出口有限公司" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self.contentView addSubview:_companyLab];
        
        _jobLab = [UILabel labelWithframe:CGRectMake(_companyLab.left, _companyLab.bottom+8, 150, 18) text:@"饰品抛光" font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
        [self.contentView addSubview:_jobLab];
        
        _timeLab = [UILabel labelWithframe:CGRectMake(kScreen_Width-39-12, _jobLab.bottom+8, 39, 18) text:@"08-28" font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentRight textColor:@"#666666"];
        [self.contentView addSubview:_timeLab];
        
        _personsLab = [UILabel labelWithframe:CGRectMake(_companyLab.left, _jobLab.bottom+8, _timeLab.left-(_imgView.right+12)-10, 18) text:@"150人" font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
        [self.contentView addSubview:_personsLab];
        
        

    }
    return self;
}

@end
