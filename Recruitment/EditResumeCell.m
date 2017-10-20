//
//  EditResumeCell.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/9.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "EditResumeCell.h"
#import "ResumeManageVC.h"
#import "EditEducationMsgVC.h"


@implementation EditResumeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        _line = [[UIView alloc] initWithFrame:CGRectMake(_imgView.center.x-.5, 0, 1, 71)];
        _line.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
        [self.contentView addSubview:_line];
        
        _imgView = [UIImageView imgViewWithframe:CGRectMake(10, (self.contentView.height-14)/2.0, 12, 12) icon:@"91"];
        [self.contentView addSubview:_imgView];

        _timeLab = [UILabel labelWithframe:CGRectMake(_imgView.right+11, 10, 97, 20) text:@"2016.09-2017.09" font:[UIFont systemFontOfSize:16] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self.contentView addSubview:_timeLab];
//        _timeLab.backgroundColor = [UIColor greenColor];

        
        _hLine = [[UIView alloc] initWithFrame:CGRectZero];
        _hLine.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
        [self.contentView addSubview:_hLine];
        
        _jobLab = [UILabel labelWithframe:CGRectMake(_timeLab.left, _timeLab.bottom+6, 150, _timeLab.height) text:@"福田店面销售代表" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
        [self.contentView addSubview:_jobLab];
        
        _companyLab = [UILabel labelWithframe:CGRectMake(_jobLab.left, _jobLab.bottom+6, 150, _timeLab.height) text:@"福田龙飞进出口有限公司" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
        [self.contentView addSubview:_companyLab];
        
        _responsibilityLab = [UILabel labelWithframe:CGRectMake(_jobLab.left, _companyLab.bottom+6, kScreen_Width-12-(_jobLab.left), _timeLab.height) text:@"独立完成项目，从交互原型到效果图设计、切图标注等工作。" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
        _responsibilityLab.numberOfLines = 0;
        [self.contentView addSubview:_responsibilityLab];
        
        _extraLab = [UILabel labelWithframe:CGRectMake(_jobLab.left, _responsibilityLab.bottom+6, kScreen_Width-12-(_jobLab.left), _timeLab.height) text:@"自我评价" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
        _extraLab.numberOfLines = 0;
        [self.contentView addSubview:_extraLab];
    
        _hLine1 = [[UIView alloc] initWithFrame:CGRectZero];
        _hLine1.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
        [self.contentView addSubview:_hLine1];
        
        _jobEditBtn = [UIButton buttonWithframe:CGRectMake(kScreen_Width-20-10, 8, 20, 20) text:nil font:nil textColor:nil backgroundColor:nil normal:@"95" selected:nil];
        [_jobEditBtn addTarget:self action:@selector(jobEditAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_jobEditBtn];
//        self.jobEditBtn = jobEditBtn;
        
//        _view = [[UIView alloc] initWithFrame:CGRectMake(_jobLab.left, lin.bottom+9, kScreen_Width-38, 1)];
//        _view.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
//        [self.contentView addSubview:_view];
        
    }
    return self;
}

- (void)jobEditAction
{
    if (self.indexPath.section == 0) {
        EditEducationMsgVC *vc = [[EditEducationMsgVC alloc] init];
        vc.title = @"求职意向";
        vc.model = self.model;
        [self.viewController.navigationController pushViewController:vc animated:YES];
        
    }
    if (self.indexPath.section == 1) {
        ResumeManageVC *vc = [[ResumeManageVC alloc] init];
        vc.title = @"工作经历";
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }
    if (self.indexPath.section == 2) {
        EditEducationMsgVC *vc = [[EditEducationMsgVC alloc] init];
        vc.title = @"教育经历";
        vc.model = self.model;

        [self.viewController.navigationController pushViewController:vc animated:YES];
    }
    if (self.indexPath.section == 3) {
        EditEducationMsgVC *vc = [[EditEducationMsgVC alloc] init];
        vc.title = @"技能特长";
        vc.model = self.model;

        [self.viewController.navigationController pushViewController:vc animated:YES];
    }
    if (self.indexPath.section == 4) {
        EditEducationMsgVC *vc = [[EditEducationMsgVC alloc] init];
        vc.title = @"联系方式";
        vc.model = self.model;

        [self.viewController.navigationController pushViewController:vc animated:YES];
    }
    

}

- (void)setModel:(PersonModel *)model
{
    _model = model;
    
    _jobEditBtn.hidden = NO;

    if (self.indexPath.section == 0) {
        _imgView.hidden = YES;
        _line.hidden = YES;
        _hLine1.hidden = YES;
        _hLine.hidden = NO;
        _extraLab.hidden = YES;
        
        _timeLab.frame = CGRectMake(12, 10, kScreen_Width-12, 20);
        _hLine.frame = CGRectMake(14, _timeLab.bottom+6, kScreen_Width-28, 1);
        _jobLab.frame = CGRectMake(_timeLab.left, _hLine.bottom+6, _timeLab.width, _timeLab.height);
        _companyLab.frame = CGRectMake(_timeLab.left, _jobLab.bottom+6, _timeLab.width, _timeLab.height);
        _responsibilityLab.hidden = YES;

//        _responsibilityLab.frame = CGRectMake(12, 10, kScreen_Width-50, 14);
        
        _timeLab.text = model.hopepostion;
        _jobLab.text = [NSString stringWithFormat:@"%@|%@|%@|%@",model.requestjobtype,model.hopelocation,model.requestsalary,model.requeststay];
        _companyLab.text = model.jobstatus;

        
        model.cellHeight = _companyLab.bottom+12;
    }
    
    if (self.indexPath.section == 1) {
        _imgView.hidden = NO;
        _line.hidden = NO;
        _hLine.hidden = YES;
        _extraLab.hidden = YES;

        _timeLab.frame = CGRectMake(_imgView.right+12, 10, kScreen_Width-(_imgView.right+12), 20);
//        _hLine.frame = CGRectMake(14, _timeLab.bottom+6, kScreen_Width-28, 14);
        _jobLab.frame = CGRectMake(_timeLab.left, _timeLab.bottom+6, _timeLab.width, _timeLab.height);
        _companyLab.frame = CGRectMake(_timeLab.left, _jobLab.bottom+6, _timeLab.width, _timeLab.height);
        
        NSString *beginTime = [model.begin_time stringByReplacingOccurrencesOfString:@"-" withString:@"."];
        NSString *endTime = [model.end_time stringByReplacingOccurrencesOfString:@"-" withString:@"."];

        _timeLab.text = [NSString stringWithFormat:@"%@-%@",beginTime,endTime];
        _jobLab.text = model.position;
        _companyLab.text = [NSString stringWithFormat:@"%@ %@",model.company_name,model.company_nature];
        
        _responsibilityLab.hidden = NO;

        CGSize size = [NSString textHeight:model.skill font:_responsibilityLab.font width:_responsibilityLab.width];
        _responsibilityLab.frame = CGRectMake(_timeLab.left, _companyLab.bottom+6, kScreen_Width-_timeLab.left-12, size.height);
        _responsibilityLab.text = model.skill;
        
        _hLine1.hidden = NO;
        _hLine1.frame = CGRectMake(_timeLab.left, _responsibilityLab.bottom+11, kScreen_Width-_timeLab.left-12, 1);
        
        if (self.indexPath.row == 0) {
            _jobEditBtn.hidden = NO;
            _line.frame = CGRectMake(_imgView.center.x-.5, _imgView.bottom, 1, _hLine1.bottom-_imgView.bottom);

        }
        else {
            _jobEditBtn.hidden = YES;
            _line.frame = CGRectMake(_imgView.center.x-.5, 0, 1, _hLine1.bottom);
            
        }
        
        model.cellHeight = _hLine1.bottom+1;


    }
    if (self.indexPath.section == 2) {
        _imgView.hidden = YES;
        _line.hidden = YES;
        _hLine.hidden = YES;
        _hLine1.hidden = YES;
        _extraLab.hidden = YES;

        _timeLab.frame = CGRectMake(12, 10, kScreen_Width-12, 20);
        //        _hLine.frame = CGRectMake(14, _timeLab.bottom+6, kScreen_Width-28, 14);
        _jobLab.frame = CGRectMake(_timeLab.left, _timeLab.bottom+6, _timeLab.width, _timeLab.height);
        _companyLab.frame = CGRectMake(_timeLab.left, _jobLab.bottom+6, _timeLab.width, _timeLab.height);
        _responsibilityLab.hidden = NO;
        _responsibilityLab.frame = CGRectMake(12, _companyLab.bottom+6, kScreen_Width-24, 14);
        
        _timeLab.text = model.graduatedfrom;
        _jobLab.text = [NSString stringWithFormat:@"%@ %@",model.education,model.speciality];
        
        NSString *graduatetime = [model.graduatetime stringByReplacingOccurrencesOfString:@"-" withString:@"."];
        _companyLab.text = graduatetime;
        
        CGSize size = [NSString textHeight:model.educationhistory font:_responsibilityLab.font width:_responsibilityLab.width];
        _responsibilityLab.height = size.height;
        _responsibilityLab.text = model.educationhistory;
        
        model.cellHeight = _responsibilityLab.bottom+12;
    }
    
    if (self.indexPath.section == 3) {
        _imgView.hidden = YES;
        _line.hidden = YES;
        _hLine.hidden = YES;
        _hLine1.hidden = YES;
        _extraLab.hidden = NO;

        _timeLab.frame = CGRectMake(12, 10, kScreen_Width-12, 20);
        //        _hLine.frame = CGRectMake(14, _timeLab.bottom+6, kScreen_Width-28, 14);
        _jobLab.frame = CGRectMake(_timeLab.left, _timeLab.bottom+6, _timeLab.width, _timeLab.height);
        _companyLab.frame = CGRectMake(_timeLab.left, _jobLab.bottom+6, _timeLab.width, _timeLab.height);
        _responsibilityLab.hidden = NO;
        _responsibilityLab.frame = CGRectMake(12, _companyLab.bottom+6, kScreen_Width-12, 14);
        _extraLab.frame = CGRectMake(_timeLab.left, _responsibilityLab.bottom+6, _timeLab.width, _timeLab.height);
        
        _timeLab.text = [NSString stringWithFormat:@"%@ %@",model.foreignlanguage,model.foreignlanguagelevel];
        _jobLab.text = [NSString stringWithFormat:@"计算机水平 %@",model.computerlevel];
        _companyLab.text = [NSString stringWithFormat:@"相关证书：%@",model.certificate];
        _responsibilityLab.text = [NSString stringWithFormat:@"其他能力：%@",model.otherability];

        CGSize size = [NSString textHeight:model.selfevaluation font:_extraLab.font width:_extraLab.width];
        _extraLab.height = size.height;
        _extraLab.text = model.selfevaluation;
        
        model.cellHeight = _extraLab.bottom+12;

        
    }
    if (self.indexPath.section == 4) {
        _imgView.hidden = YES;
        _line.hidden = YES;
        _hLine.hidden = YES;
        _hLine1.hidden = YES;
        _extraLab.hidden = YES;

        _timeLab.frame = CGRectMake(12, 10, kScreen_Width-12, 20);
        //        _hLine.frame = CGRectMake(14, _timeLab.bottom+6, kScreen_Width-28, 14);
        _jobLab.frame = CGRectMake(_timeLab.left, _timeLab.bottom+6, _timeLab.width, _timeLab.height);
        _companyLab.frame = CGRectMake(_timeLab.left, _jobLab.bottom+6, _timeLab.width, _timeLab.height);
        _responsibilityLab.hidden = YES;
//        _responsibilityLab.frame = CGRectMake(12, 10, kScreen_Width-50, 14);
        
        _timeLab.text = model.phone;
        _jobLab.text = [NSString stringWithFormat:@"QQ:%@ %@",model.qq,model.email];
        _companyLab.text = model.address;
        
        model.cellHeight = _companyLab.bottom+12;

        
    }
}

@end
