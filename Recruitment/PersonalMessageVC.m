//
//  MessageVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/6.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "PersonalMessageVC.h"
#import "PersonalMessageCell.h"

@interface PersonalMessageVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataArr;
@property (nonatomic,strong) NSArray *selectArr;
@end

@implementation PersonalMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArr = @[@[@{@"image":@"3",@"title":@"姓名",@"key":@"name"},
                       @{@"image":@"4",@"title":@"最高学历",@"key":@"education"},
                       @{@"image":@"6",@"title":@"工作年限",@"key":@"jobyear"}],
                     @[@{@"image":@"5",@"title":@"意向岗位",@"key":@"hopepostion"},
                       @{@"image":@"2",@"title":@"期望薪资",@"key":@"requestsalary"},
                       @{@"image":@"1",@"title":@"意向城市",@"key":@"hopelocation"}]
                     ];
    
    NSMutableArray *arrM = [NSMutableArray array];
    for (NSArray *arr in self.dataArr) {
        
        NSMutableArray *arrM1 = [NSMutableArray array];

        for (NSDictionary *dic in arr) {
            
            PersonModel *model = [PersonModel yy_modelWithJSON:dic];
            [arrM1 addObject:model];
        }
        
        [arrM addObject:arrM1];

    }
    
    self.dataArr = arrM;
    
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64-49)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 21*2+35)];
    UIButton *upBtn = [UIButton buttonWithframe:CGRectMake(25, 21, kScreen_Width-50, 35) text:@"提交" font:[UIFont systemFontOfSize:16] textColor:@"#FFFFFF" backgroundColor:@"#FF9123" normal:nil selected:nil];
    upBtn.layer.cornerRadius = 7;
    upBtn.layer.masksToBounds = YES;
    [footerView addSubview:upBtn];
    [upBtn addTarget:self action:@selector(upAction:) forControlEvents:UIControlEventTouchUpInside];

    
    _tableView.tableFooterView = footerView;
    
    // 选择项数据
    NSArray *selectArr = [InfoCache unarchiveObjectWithFile:SelectItem];;
    self.selectArr = selectArr;

}

- (void)upAction:(UIButton *)btn
{
    [self.view endEditing:YES];

    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];

    for (NSArray *arr in self.dataArr) {
        
        for (PersonModel *model in arr) {
            
            if (model.text.length == 0) {
                [self.view makeToast:@"您还有内容未填写完整"];
                return;
            }
            
            [paramDic  setValue:model.text forKey:model.key];

        }
        
    }
    
    NSLog(@"%@",paramDic);
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Update_peronal_info dic:paramDic showHUD:YES Succed:^(id responseObject) {
        
        // 登录通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kLoginNotification" object:self.title];
        
    } failure:^(NSError *error) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataArr count];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArr[section] count];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 10)];
    view.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PersonalMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[PersonalMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];

    }
    PersonModel *model = self.dataArr[indexPath.section][indexPath.row];
    cell.model = model;
    cell.selectArr = self.selectArr;
    return cell;
}



@end
