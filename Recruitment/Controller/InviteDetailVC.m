//
//  InviteDetailVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/11/7.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "InviteDetailVC.h"
#import "NSStringExt.h"
#import "JobDetailVC.h"

@interface InviteDetailVC ()

@end

@implementation InviteDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0)];
    baseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baseView];

    UILabel *comLab = [UILabel labelWithframe:CGRectMake(15, 11, kScreen_Width-15-12, 17) text:_model.title font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [baseView addSubview:comLab];
    
    UILabel *jobLab = [UILabel labelWithframe:CGRectMake(comLab.left, comLab.bottom+12, comLab.width, 13) text:@"" font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
    [baseView addSubview:jobLab];
    
    NSString *str1 = _model.jobName;
    NSMutableAttributedString *attStr = [NSString text:str1 fullText:[NSString stringWithFormat:@"邀请你参加%@面试",str1] location:5 color:[UIColor colorWithHexString:@"#FF9123"] font:nil];
    jobLab.attributedText = attStr;
    
    UILabel *contactLab = [UILabel labelWithframe:CGRectMake(comLab.left, jobLab.bottom+7, comLab.width, 13) text:[NSString stringWithFormat:@"联系人：%@",_model.name] font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
    [baseView addSubview:contactLab];
    
    UILabel *teleLab = [UILabel labelWithframe:CGRectMake(comLab.left, contactLab.bottom+7, comLab.width, 13) text:[NSString stringWithFormat:@"联系电话：%@",_model.tele] font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
    [baseView addSubview:teleLab];
    
    UILabel *addressLab = [UILabel labelWithframe:CGRectMake(comLab.left, teleLab.bottom+7, comLab.width, 13) text:[NSString stringWithFormat:@"面试地址：%@",_model.address] font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
    [baseView addSubview:addressLab];
    
    UILabel *otherLab = [UILabel labelWithframe:CGRectMake(comLab.left, addressLab.bottom+7, comLab.width, 0) text:[NSString stringWithFormat:@"其他信息：%@",_model.address] font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
    [baseView addSubview:otherLab];
    
    CGSize size = [NSString textHeight:[NSString stringWithFormat:@"其他信息：%@",_model.address] font:otherLab.font width:comLab.width];
    otherLab.height = size.height;
    
    baseView.height = otherLab.bottom+12;
    
    
    // 底部视图
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreen_Height-64-40, kScreen_Width, 40)];
    [self.view addSubview:bottomView];
    
    UIButton *jobBtn = [UIButton buttonWithframe:CGRectMake(0, 0, kScreen_Width/2, bottomView.height) text:@"职位详情" font:nil textColor:@"#FFFFFF" backgroundColor:@"#FF9123" normal:@"职位详情" selected:nil];
    [bottomView addSubview:jobBtn];
    jobBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    jobBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    [jobBtn addTarget:self action:@selector(jobAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *phoneBtn = [UIButton buttonWithframe:CGRectMake(jobBtn.width, jobBtn.top, jobBtn.width, bottomView.height) text:@"联系电话" font:nil textColor:@"#FFFFFF" backgroundColor:@"#FF9123" normal:@"ic_call-1" selected:nil];
    [bottomView addSubview:phoneBtn];
    phoneBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    phoneBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    [phoneBtn addTarget:self action:@selector(callAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(jobBtn.width-1, 10, 1, 20)];
    line.backgroundColor = [UIColor whiteColor];
    [jobBtn addSubview:line];
    
    [self invite_detail];

}

// 为了邀请面试红点提示消失
- (void)invite_detail
{
    
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    [paraDic setValue:_model.inviteId forKey:@"inviteId"];
    [AFNetworking_RequestData requestMethodPOSTUrl:Invite_detail dic:paraDic showHUD:NO Succed:^(id responseObject) {
        
        
    } failure:^(NSError *error) {
        
        
    }];
}

- (void)jobAction
{
    JobDetailVC *vc = [[JobDetailVC alloc] init];
    vc.title = @"职位详情";
    vc.model = _model;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)callAction
{
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",_model.tele];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
