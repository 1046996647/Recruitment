//
//  CheckedCell.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/11.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "CheckedCell.h"

@implementation CheckedCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _imgView = [UIImageView imgViewWithframe:CGRectMake(9, 13, 60, 60) icon:@"102"];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imgView];
        
        
        _companyLab = [UILabel labelWithframe:CGRectMake(_imgView.right+7, 10, kScreen_Width-(_imgView.right+7)-12, 17) text:@"福田龙飞进出口有限公司" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
        [self.contentView addSubview:_companyLab];
        
        _typeLab = [UILabel labelWithframe:CGRectMake(_companyLab.left, _companyLab.bottom+8, _companyLab.width, _companyLab.height) text:@"私营企业|饰品" font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self.contentView addSubview:_typeLab];
        
        _peopleLab = [UILabel labelWithframe:CGRectMake(_companyLab.left, _typeLab.bottom+8, _companyLab.width, _companyLab.height) text:@"150-500人" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
        [self.contentView addSubview:_peopleLab];
        

        
//        _timeLab = [UILabel labelWithframe:CGRectMake(kScreen_Width-39-12, _kmLab.bottom+6, 39, 17) text:@"08-28" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentRight textColor:@"#999999"];
//        [self.contentView addSubview:_timeLab];
    
        
        
    }
    return self;
}

@end
