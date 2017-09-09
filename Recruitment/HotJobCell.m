//
//  HotJobCell.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/7.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "HotJobCell.h"

@implementation HotJobCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _jobLab = [UILabel labelWithframe:self.contentView.bounds text:@"销售" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentCenter textColor:@"#FF9123"];
        _jobLab.layer.cornerRadius = 5;
        _jobLab.layer.masksToBounds = YES;
        _jobLab.layer.borderColor = [UIColor colorWithHexString:@"#FF9123"].CGColor;
        _jobLab.layer.borderWidth = 1;
        [self.contentView addSubview:_jobLab];
    }
    return self;
}


@end
