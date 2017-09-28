//
//  SystemMassageVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/11.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "SystemMassageVC.h"
#import "SystemMassageCell.h"
#import "SystemModel.h"
#import "SystemMsgDetailVC.h"

@interface SystemMassageVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *dataArr;
@property(nonatomic,strong) UITableView *tableView;

@end

@implementation SystemMassageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self system_message_list];

}

// 4.1    系统消息
- (void)system_message_list
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:System_message_list dic:dic showHUD:YES Succed:^(id responseObject) {
        
        NSArray *arr = responseObject[@"data"];
        if ([arr isKindOfClass:[NSArray class]]) {
            NSMutableArray *arrM = [NSMutableArray array];
            for (NSDictionary *dic in arr) {
                SystemModel *model1 = [SystemModel yy_modelWithJSON:dic];
                [arrM addObject:model1];
            }
            
            self.dataArr = arrM;
            [_tableView reloadData];

        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
//    return 10;
    
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 16+228;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SystemModel *model = self.dataArr[indexPath.row];

    SystemMsgDetailVC *vc = [[SystemMsgDetailVC alloc] init];
    vc.title = model.title;
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    SystemModel *model = self.dataArr[indexPath.row];
    cell.textLabel.text = model.title;
    
    return cell;
}
@end
