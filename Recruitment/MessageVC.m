//
//  MessageVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/6.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "MessageVC.h"
#import "MessageCell.h"
#import "InvitedVC.h"
#import "SubscriptionJobVC.h"
#import "SystemMassageVC.h"

@interface MessageVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataArr;

@end

@implementation MessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArr = @[@{@"image":@"114",@"title":@"系统消息",@"detailTitle":@"有趣内容和最新功能都在这里"},
                     @{@"image":@"113",@"title":@"订阅职位",@"detailTitle":@"订阅职位的职位在这里"},
                     @{@"image":@"112",@"title":@"面试邀请",@"detailTitle":@"HR邀请您去面试的信息"},];
    
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64-49)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        SystemMassageVC *vc = [[SystemMassageVC alloc] init];
        vc.title = @"系统消息";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 1) {
        SubscriptionJobVC *vc = [[SubscriptionJobVC alloc] init];
        vc.title = @"订阅职位";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 2) {
        InvitedVC *vc = [[InvitedVC alloc] init];
        vc.title = @"面试邀请";
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];

    }
    NSDictionary *dic = self.dataArr[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:dic[@"image"]];
    cell.textLab.text = dic[@"title"];
    cell.detailLab.text = dic[@"detailTitle"];
    
    return cell;
}



@end
