//
//  JobView1cell.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/12/4.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "JobView1cell.h"

@implementation JobView1cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _selectBtn = [UIButton buttonWithframe:CGRectZero text:nil font:nil textColor:nil backgroundColor:nil normal:@"" selected:@"Path 2"];
        [self.contentView addSubview:_selectBtn];
        _selectBtn.userInteractionEnabled = NO;
//        [_selectBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _jobLab = [UILabel labelWithframe:CGRectMake(13, 10, 150, 20) text:@"" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self.contentView addSubview:_jobLab];
        
    }
    return self;
    
}

- (void)setModel:(JobViewModel *)model
{
    _model = model;
    
    if (self.tag == 5) {
        
        _selectBtn.frame = CGRectMake(kScreen_Width-15-12, 8, 15, 15);
        
//        _jobLab.left = _selectBtn.right;
        _selectBtn.selected = _model.isSelected;

    }

    _jobLab.text = model.content;

    
}


@end
