//
//  JobViewCell.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/12/4.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "JobViewCell.h"

@implementation JobViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.tagsView];

    }
    return self;
    
}

- (HXTagsView *)tagsView
{
    if (!_tagsView) {
        //        NSArray *tagAry = @[@"薪假",@"公游",@"保险"];
        //    单行不需要设置高度,内部根据初始化参数自动计算高度
        _tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(80, 0, kScreen_Width-80-40, 0)];
        _tagsView.type = 0;
        _tagsView.tagHorizontalSpace = 5.0;
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

- (void)setModel:(JobViewModel *)model
{
    _model = model;
    
    if ([_model.title isEqualToString:@"公司性质"]) {
        
        _tagsView.hidden = NO;
        
        if (![model.content isEqualToString:@"不限"]) {
//            _jobLab.text = @"";
            self.detailTextLabel.text = @"";
            NSArray *tagArr = [model.content componentsSeparatedByString:@","];
            
            [_tagsView setTagAry:tagArr delegate:nil];
            
            
            _model.cellHeight = _tagsView.bottom;
        }
        else {
            _tagsView.hidden = YES;
            _model.cellHeight = 40;
        }

        
    }
    else {
        _tagsView.hidden = YES;
        
    }
}

@end
