//
//  ResumeManageVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/12.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ResumeManageVC.h"

#import "SubscriptionManageCell.h"
#import "EditJobMsgVC.h"
#import "EditEducationMsgVC.h"

@interface ResumeManageVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *dataArr;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,assign) NSInteger type;


@end

@implementation ResumeManageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 47)];
    
    UIButton *btn = [UIButton buttonWithframe:CGRectMake(13, 12, kScreen_Width-26, 35) text:@"+ 增加工作经历" font:[UIFont systemFontOfSize:14] textColor:@"#FFFFFF" backgroundColor:@"#FF9123" normal:@"" selected:nil];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    [baseView addSubview:btn];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = baseView;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 管理
    UIButton *manageBtn = [UIButton buttonWithframe:CGRectMake(0, 0, 30, 17) text:@"管理" font:[UIFont systemFontOfSize:14] textColor:@"#030303" backgroundColor:nil normal:nil selected:nil];
    [manageBtn setTitle:@"完成" forState:UIControlStateSelected];
    [manageBtn addTarget:self action:@selector(manageAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:manageBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)manageAction:(UIButton *)btn
{
    btn.selected = !btn.selected;
    
    self.type = btn.selected;
    
    [_tableView reloadData];
}

- (void)btnAction
{
    EditEducationMsgVC *vc = [[EditEducationMsgVC alloc] init];
    vc.title = @"编辑工作经历";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return self.dataArr.count;
    return 2;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (13+101);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    EditEducationMsgVC *vc = [[EditEducationMsgVC alloc] init];
    vc.title = @"编辑工作经历";
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SubscriptionManageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[SubscriptionManageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.jobBtn setImage:[UIImage imageNamed:@"94"] forState:UIControlStateNormal];
    [cell.jobBtn1 setImage:[UIImage imageNamed:@"93"] forState:UIControlStateNormal];
    [cell.addressBtn setImage:[UIImage imageNamed:@"92"] forState:UIControlStateNormal];
    
    [cell.jobBtn setTitle:@"2016.09-2017.09" forState:UIControlStateNormal];
    [cell.jobBtn1 setTitle:@"杭州晖鸿科技有限公司" forState:UIControlStateNormal];
    [cell.addressBtn setTitle:@"UI设计师" forState:UIControlStateNormal];

    
    cell.type = self.type;
    cell.model = nil;
    
    
    return cell;
}

@end
