//
//  MyAttentionVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/21.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "MyAttentionVC.h"
#import "MyAttentionCell.h"
#import "CompanyDetailVC.h"

@interface MyAttentionVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation MyAttentionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [self get_concern_list];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)get_concern_list
{
    
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Get_concern_list dic:paraDic showHUD:YES Succed:^(id responseObject) {
        
        NSArray *arr = responseObject[@"data"];
        if ([arr isKindOfClass:[NSArray class]]) {
            
            NSMutableArray *arrM = [NSMutableArray array];
            for (NSDictionary *dic in arr) {
                JobModel *model = [JobModel yy_modelWithJSON:dic];
                [arrM addObject:model];
            }
            
            self.dataArr = arrM;
            [_tableView reloadData];
            
        }
        
        
    } failure:^(NSError *error) {
        
        
    }];
}

- (void)cellctionAction:(JobModel *)model

{
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    [paraDic setValue:model.companyId forKey:@"companyId"];
    [paraDic setValue:@"1" forKey:@"del"];// 取消收藏
    
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Company_concern dic:paraDic showHUD:YES Succed:^(id responseObject) {
        
        
    } failure:^(NSError *error) {
        
        
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
//    return 10;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;

}

//修改左滑的按钮的字
-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexpath {
    
    return @"删除";
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self cellctionAction:self.dataArr[indexPath.row]];
    [self.dataArr removeObjectAtIndex:indexPath.row];
    [_tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CompanyDetailVC *vc = [[CompanyDetailVC alloc] init];
    vc.title = @"公司详情";
    vc.model = self.dataArr[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyAttentionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[MyAttentionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    cell.model = self.dataArr[indexPath.row];
    
    return cell;
}

@end
