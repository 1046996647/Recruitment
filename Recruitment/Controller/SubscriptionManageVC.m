//
//  SubscriptionManageVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/11.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "SubscriptionManageVC.h"
#import "SubscriptionManageCell.h"

@interface SubscriptionManageVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *dataArr;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,assign) NSInteger type;


@end

@implementation SubscriptionManageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 47)];
    
    UIButton *btn = [UIButton buttonWithframe:CGRectMake(13, 12, kScreen_Width-26, 35) text:@"+ 增加订阅" font:[UIFont systemFontOfSize:14] textColor:@"#FFFFFF" backgroundColor:@"#FF9123" normal:@"" selected:nil];
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
    
    [self get_ordered_jobs];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)get_ordered_jobs
{

    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Get_ordered_jobs dic:paraDic showHUD:YES Succed:^(id responseObject) {
        
        NSArray *arr = responseObject[@"data"];
        if ([arr isKindOfClass:[NSArray class]]) {
            
            NSMutableArray *arrM = [NSMutableArray array];
            for (NSDictionary *dic in arr) {
                PersonModel *model1 = [PersonModel yy_modelWithJSON:dic];
                [arrM addObject:model1];
            }
            self.dataArr = arrM;
            
            [_tableView reloadData];

            
            
        }

        
    } failure:^(NSError *error) {
        

    }];
}

// 删除订阅职位
- (void)udpate_ordered_jobs:(NSInteger)tag
{
    PersonModel *model = self.dataArr[tag];
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    
    [paramDic setValue:model.ID forKey:@"id"];
    [paramDic setValue:@"delete" forKey:@"act"];

    [AFNetworking_RequestData requestMethodPOSTUrl:Udpate_ordered_jobs dic:paramDic showHUD:YES Succed:^(id responseObject) {
        
        
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
    self.type = 0;
    [_tableView reloadData];
    
    EditEducationMsgVC *vc = [[EditEducationMsgVC alloc] init];
    vc.title = @"增加订阅";
    [self.navigationController pushViewController:vc animated:YES];
    vc.block = ^{
        
        [self get_ordered_jobs];
        
        if (self.block) {
            self.block();
        }
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
    vc.title = @"增加订阅";
    vc.model = self.dataArr[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    vc.block = ^{
        [self get_ordered_jobs];
        
        if (self.block) {
            self.block();
        }
    };
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SubscriptionManageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[SubscriptionManageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.block = ^(NSInteger tag) {
            
            [self udpate_ordered_jobs:tag];
            
            [self.dataArr removeObjectAtIndex:tag];
            [_tableView reloadData];
            
        };
    }
    
    PersonModel *model = self.dataArr[indexPath.row];
    
    [cell.jobBtn setTitle:model.key forState:UIControlStateNormal];
    [cell.jobBtn1 setTitle:model.key forState:UIControlStateNormal];
    [cell.addressBtn setTitle:model.area forState:UIControlStateNormal];
    
    cell.type = self.type;
    cell.model = nil;
    
    
    return cell;
}

@end
