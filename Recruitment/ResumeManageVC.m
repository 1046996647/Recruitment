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

@property (nonatomic,strong) NSMutableArray *dataArr;
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
    
    [self get_work_exp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 获取用户工作经历
- (void)get_work_exp
{
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Get_work_exp dic:paramDic showHUD:YES Succed:^(id responseObject) {
        
        NSMutableArray *arrM = [NSMutableArray array];
        NSArray *arr = responseObject[@"data"];
        for (NSDictionary *dic in arr) {
            PersonModel *model1 = [PersonModel yy_modelWithJSON:dic];
            [arrM addObject:model1];
        }
        
        self.dataArr = arrM;
        
        [_tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

// 删除工作经历
- (void)delete_jobhistory_info:(NSInteger)tag
{
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    
    [paramDic setValue:@(tag) forKey:@"orderNum"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Delete_jobhistory_info dic:paramDic showHUD:YES Succed:^(id responseObject) {
        
        
    } failure:^(NSError *error) {
        
    }];
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
    vc.block = ^{
        [self get_work_exp];
    };
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return self.dataArr.count;
//    return 2;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (13+101);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    EditEducationMsgVC *vc = [[EditEducationMsgVC alloc] init];
    vc.title = @"编辑工作经历";
    vc.index = indexPath.row;
    vc.model = self.dataArr[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    vc.block = ^{
        [self get_work_exp];
    };
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SubscriptionManageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[SubscriptionManageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.block = ^(NSInteger tag) {
            [self.dataArr removeObjectAtIndex:tag];
            [_tableView reloadData];
            
            [self delete_jobhistory_info:tag+1];
        };
    }
    
    PersonModel *model = self.dataArr[indexPath.row];
    
    [cell.jobBtn setImage:[UIImage imageNamed:@"94"] forState:UIControlStateNormal];
    [cell.jobBtn1 setImage:[UIImage imageNamed:@"93"] forState:UIControlStateNormal];
    [cell.addressBtn setImage:[UIImage imageNamed:@"92"] forState:UIControlStateNormal];
    
    NSString *beginTime = [model.begin_time stringByReplacingOccurrencesOfString:@"-" withString:@"."];
    NSString *endTime = [model.end_time stringByReplacingOccurrencesOfString:@"-" withString:@"."];
    [cell.jobBtn setTitle:[NSString stringWithFormat:@"%@-%@",beginTime,endTime] forState:UIControlStateNormal];
    [cell.jobBtn1 setTitle:model.company_name forState:UIControlStateNormal];
    [cell.addressBtn setTitle:model.position forState:UIControlStateNormal];

    cell.selectBtn.tag = indexPath.row;
    cell.type = self.type;
    cell.model = nil;
    
    
    return cell;
}

@end
