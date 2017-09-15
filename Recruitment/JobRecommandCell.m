//
//  JobRecommandCell.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/12.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "JobRecommandCell.h"
#import "JobDetailVC.h"
#import "CompanyDetailVC.h"

@implementation JobRecommandCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 135)];
        baseView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:baseView];
        
        UIButton *topBtn = [UIButton buttonWithframe:CGRectMake(0, 0, kScreen_Width, 70) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:nil selected:nil];
        topBtn.tag = 0;
        [self.contentView addSubview:topBtn];
        [topBtn addTarget:self action:@selector(pushAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *bottomBtn = [UIButton buttonWithframe:CGRectMake(0, topBtn.bottom, kScreen_Width, 60) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:nil selected:nil];
        bottomBtn.tag = 1;
        [self.contentView addSubview:bottomBtn];
        [bottomBtn addTarget:self action:@selector(pushAction:) forControlEvents:UIControlEventTouchUpInside];
    
        _jobLab = [UILabel labelWithframe:CGRectMake(13, 10, 150, 20) text:@"福田店面销售代表" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self.contentView addSubview:_jobLab];
        
        _moneyLab = [UILabel labelWithframe:CGRectMake(kScreen_Width-34-12, 12, 34, 18) text:@"6-7k" font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentRight textColor:@"#CE4A12"];
        [self.contentView addSubview:_moneyLab];
        
        //单行滚动  ===============
        NSArray *tagAry = @[@"薪假",@"公游",@"保险"];
        //    单行不需要设置高度,内部根据初始化参数自动计算高度
        _tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(_jobLab.left, _moneyLab.bottom, 150, 0)];
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
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(_jobLab.left, _tagsView.bottom+5, kScreen_Width-_jobLab.left*2, 1)];
        line.backgroundColor = [UIColor colorWithHexString:@"#979797"];
        [self.contentView addSubview:line];

        UIImageView *logoView = [UIImageView imgViewWithframe:CGRectMake(_jobLab.left, line.bottom+8, 45, 45) icon:@"102"];
        logoView.layer.cornerRadius = 9;
        logoView.layer.masksToBounds = YES;
        [self.contentView addSubview:logoView];
        self.logoView = logoView;

        _companyLab = [UILabel labelWithframe:CGRectMake(logoView.right+11, logoView.top, kScreen_Width-12-(logoView.right+7), 17) text:@"浙江金狮工贸有限公司永康分公司" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self.contentView addSubview:_companyLab];
        
        // 公司地址
        UIButton *decBtn = [UIButton buttonWithframe:CGRectMake(_companyLab.left, _companyLab.bottom+6, 82, 17) text:@"永嘉" font:[UIFont systemFontOfSize:12] textColor:@"#999999" backgroundColor:nil normal:@"Shape" selected:nil];
        decBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        [self.contentView addSubview:decBtn];
        self.decBtn = decBtn;
        decBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        decBtn.userInteractionEnabled = NO;
        
        _chatView = [UIImageView imgViewWithframe:CGRectMake(kScreen_Width-15-12, line.bottom+23, 15, 14) icon:@"20"];
        logoView.layer.cornerRadius = 9;
        logoView.layer.masksToBounds = YES;
        [self.contentView addSubview:_chatView];
        
        line = [[UIView alloc] initWithFrame:CGRectMake(0, baseView.bottom, kScreen_Width, 8)];
        line.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
        [self.contentView addSubview:line];
        
    }
    return self;
}

- (void)pushAction:(UIButton *)btn
{
    if (btn.tag == 0) {
        JobDetailVC *vc = [[JobDetailVC alloc] init];
        vc.title = @"职位详情";
        vc.type = 1;
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }
    else {
        CompanyDetailVC *vc = [[CompanyDetailVC alloc] init];
        vc.title = @"公司详情";
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }
}

@end
