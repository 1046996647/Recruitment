//
//  SubscriptionManageCell.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/11.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "SubscriptionManageCell.h"

@implementation SubscriptionManageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(16, 13, kScreen_Width-32, 101)];
        baseView.backgroundColor = [UIColor whiteColor];
        baseView.layer.cornerRadius = 10;
        baseView.layer.masksToBounds = YES;
        [self.contentView addSubview:baseView];
        self.baseView = baseView;
        
        _selectBtn = [UIButton buttonWithframe:CGRectZero text:nil font:nil textColor:nil backgroundColor:nil normal:@"Group 3" selected:@""];
        [baseView addSubview:_selectBtn];
        
        _jobBtn = [UIButton buttonWithframe:CGRectMake(11, 5, kScreen_Width-11, 16) text:@"UI设计师" font:[UIFont systemFontOfSize:13] textColor:@"#999999" backgroundColor:nil normal:@"66" selected:@""];
        _jobBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _jobBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        [baseView addSubview:_jobBtn];
        _jobBtn.userInteractionEnabled = NO;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(_jobBtn.left+20, _jobBtn.bottom+6, baseView.width-12-(_jobBtn.left+20), 1)];
        view.backgroundColor = [UIColor colorWithHexString:@"#CACACA"];
        [baseView addSubview:view];
        self.view = view;
        
        _jobBtn1 = [UIButton buttonWithframe:CGRectMake(_jobBtn.left, view.bottom+14, _jobBtn.width, 16) text:@"UI设计师" font:[UIFont systemFontOfSize:13] textColor:@"#333333" backgroundColor:nil normal:@"Oval" selected:@""];
        _jobBtn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

        _jobBtn1.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        [baseView addSubview:_jobBtn1];
        _jobBtn1.userInteractionEnabled = NO;

        
        _addressBtn = [UIButton buttonWithframe:CGRectMake(_jobBtn.left, _jobBtn1.bottom+14, _jobBtn.width, 16) text:@"永嘉市" font:[UIFont systemFontOfSize:13] textColor:@"#333333" backgroundColor:nil normal:@"64" selected:@""];
        _addressBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

        _addressBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        [baseView addSubview:_addressBtn];
        _addressBtn.userInteractionEnabled = NO;

        
    }
    return self;
}

- (void)setModel:(SubscriptionManageModel *)model
{
    _model = model;
    
    if (self.type == 1) {
        
        _selectBtn.frame = CGRectMake(0, (self.baseView.height-36)/2, 30, 36);
        
        _jobBtn.left = _selectBtn.right;
        self.view.frame = CGRectMake(_jobBtn.left+20, _jobBtn.bottom+6, self.baseView.width-12-(_jobBtn.left+20), 1);
        _jobBtn1.left = _jobBtn.left;
        _addressBtn.left = _jobBtn.left;
    }
    else {
        _selectBtn.frame = CGRectZero;
        
        _jobBtn.left = _selectBtn.right+11;
        self.view.frame = CGRectMake(_jobBtn.left+20, _jobBtn.bottom+6, self.baseView.width-12-(_jobBtn.left+20), 1);
        _jobBtn1.left = _jobBtn.left;
        _addressBtn.left = _jobBtn.left;
    }
}

@end
