//
//  EditResumeVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/9.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "EditResumeVC.h"
#import "EditResumeCell.h"
#import "HeaderView.h"
#import "EditJobMsgVC.h"
#import "EditEducationMsgVC.h"

@interface EditResumeVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataArr;


@end

@implementation EditResumeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 头视图
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0)];
    headView.backgroundColor = [UIColor whiteColor];
    
    // 简历信息
    UIButton *userBtn = [UIButton buttonWithframe:CGRectMake(6, 14, 66, 66) text:nil font:nil textColor:nil backgroundColor:nil normal:@"96" selected:nil];
//    [userBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:userBtn];
    
    UILabel *signLabel = [UILabel labelWithframe:CGRectMake(userBtn.right+16, 11, 250, 18) text:@"天天" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [headView addSubview:signLabel];
    
    UIButton *editBtn = [UIButton buttonWithframe:CGRectMake(signLabel.right+11, signLabel.top, 20, 20) text:nil font:nil textColor:nil backgroundColor:nil normal:@"95" selected:nil];
    [editBtn addTarget:self action:@selector(personalAction) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:editBtn];
    
    UILabel *infoLabel = [UILabel labelWithframe:CGRectMake(signLabel.left, editBtn.bottom+5, 300, 14) text:@"女|本科|两年|永嘉" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
    [headView addSubview:infoLabel];
    
    UILabel *phoneLabel = [UILabel labelWithframe:CGRectMake(signLabel.left, infoLabel.bottom+5, 300, 14) text:@"188426825" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
    [headView addSubview:phoneLabel];
    
    UILabel *hopeLabel = [UILabel labelWithframe:CGRectMake(signLabel.left, phoneLabel.bottom+5, 300, 14) text:@"我毕业于杭州大学，希望多多看我的简历哦~" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
    [headView addSubview:hopeLabel];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, hopeLabel.bottom+9, kScreen_Width, 25)];
    view.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
    [headView addSubview:view];
    
    // 求职意向
    UIButton *wantBtn = [UIButton buttonWithframe:CGRectMake(userBtn.left, 0, 60, view.height) text:@"求职意向" font:[UIFont systemFontOfSize:10] textColor:@"#333333" backgroundColor:nil normal:@"88" selected:nil];
    wantBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [view addSubview:wantBtn];

    
    UILabel *jobLabel = [UILabel labelWithframe:CGRectMake(11, view.bottom+12, 200, 14) text:@"UI设计师" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [headView addSubview:jobLabel];
    
    UIButton *jobEditBtn = [UIButton buttonWithframe:CGRectMake(kScreen_Width-20-10, view.bottom+8, 20, 20) text:nil font:nil textColor:nil backgroundColor:nil normal:@"95" selected:nil];
    [jobEditBtn addTarget:self action:@selector(wantAction) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:jobEditBtn];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(19, jobLabel.bottom+9, kScreen_Width-38, 1)];
    view.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
    [headView addSubview:view];
    
    UILabel *moneyLabel = [UILabel labelWithframe:CGRectMake(jobLabel.left, view.bottom+9, 200, 14) text:@"全职|永嘉市|面议" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
    [headView addSubview:moneyLabel];
    
    UILabel *timeLabel = [UILabel labelWithframe:CGRectMake(jobLabel.left, moneyLabel.bottom+9, 200, 14) text:@"全职|永嘉市|面议" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
    [headView addSubview:timeLabel];
    
    headView.height = timeLabel.bottom+12;
    
    
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64-49)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.tableHeaderView = headView;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 预览
    UIButton *preBtn = [UIButton buttonWithframe:CGRectMake(0, 0, 30, 17) text:@"预览" font:[UIFont systemFontOfSize:14] textColor:@"#030303" backgroundColor:nil normal:nil selected:nil];
    [preBtn addTarget:self action:@selector(preAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:preBtn];
    
    if ([self.title isEqualToString:@"预览"]) {
        editBtn.hidden = YES;
        jobEditBtn.hidden = YES;
        self.navigationItem.rightBarButtonItem = nil;
    }

}

- (void)preAction
{
    EditResumeVC *vc = [[EditResumeVC alloc] init];
    vc.title = @"预览";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)personalAction
{
    EditJobMsgVC *vc = [[EditJobMsgVC alloc] init];
    vc.title = @"基本信息";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)wantAction
{
    EditEducationMsgVC *vc = [[EditEducationMsgVC alloc] init];
    vc.title = @"求职意向";
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    return [self.dataArr count];
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 94;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *imgArr = @[@"89",@"90"];
    NSArray *titleArr1 = @[@"工作经历",@"教育经历"];
    HeaderView *headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 25)];
    [headerView.btn setTitle:titleArr1[section] forState:UIControlStateNormal];
    [headerView.btn setImage:[UIImage imageNamed:imgArr[section]] forState:UIControlStateNormal];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ([self.title isEqualToString:@"预览"]) {
        return 0;

        
    }
    else {
        return 62;

    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    NSArray *titleArr1 = @[@"+ 增加工作经历",@"+ 增加教育经历"];
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 62)];
    footView.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithframe:CGRectMake(12, 14, kScreen_Width-24, 35) text:titleArr1[section] font:[UIFont systemFontOfSize:14] textColor:@"#FF9123" backgroundColor:nil normal:@"" selected:nil];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    btn.layer.borderColor = [UIColor colorWithHexString:@"#FF9123"].CGColor;
    btn.layer.borderWidth = 1;
    [footView addSubview:btn];
    btn.tag = section;
    [btn addTarget:self action:@selector(footAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return footView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EditResumeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[EditResumeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if ([self.title isEqualToString:@"预览"]) {
        cell.jobEditBtn.hidden = YES;
        
    }
    else {
        cell.jobEditBtn.hidden = NO;
        
    }
    
    return cell;
}

- (void)footAction:(UIButton *)btn
{
    if (btn.tag == 0) {
        
        EditJobMsgVC *vc = [[EditJobMsgVC alloc] init];
        vc.title = @"编辑工作经历";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else {
        EditEducationMsgVC *vc = [[EditEducationMsgVC alloc] init];
        vc.title = @"编辑教育经历";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
