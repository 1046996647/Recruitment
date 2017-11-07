//
//  MessageTableView.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/10/9.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "MessageTableView.h"
#import "MessageCell.h"
#import "InvitedVC.h"
#import "SubscriptionJobVC.h"
#import "SystemMassageVC.h"
#import "LoginVC.h"
#import "WZLBadgeImport.h"

@implementation MessageTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.dataArr = @[@{@"image":@"114",@"title":@"系统消息",@"detailTitle":@"有趣内容和最新功能都在这里"},
                         @{@"image":@"113",@"title":@"订阅职位",@"detailTitle":@"订阅职位的职位在这里"},
                         @{@"image":@"112",@"title":@"面试邀请",@"detailTitle":@"HR邀请您去面试的信息"},];
        
        
        
        self.delegate  = self;
        self.dataSource = self;
        self.isNew = YES;
    }
    return self;
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
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }
    
    PersonModel *model = [InfoCache unarchiveObjectWithFile:Person];
    
    if (indexPath.row == 1) {
        
        if (!model) {
            LoginVC *vc = [[LoginVC alloc] init];
            [self.viewController.navigationController pushViewController:vc animated:YES];
            
            return;
        }
        
        SubscriptionJobVC *vc = [[SubscriptionJobVC alloc] init];
        vc.title = @"订阅职位";
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 2) {
        
        if (!model) {
            LoginVC *vc = [[LoginVC alloc] init];
            [self.viewController.navigationController pushViewController:vc animated:YES];
            
            return;
        }
        InvitedVC *vc = [[InvitedVC alloc] init];
        vc.title = @"面试邀请";
        [self.viewController.navigationController pushViewController:vc animated:YES];
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
    
    if (indexPath.row == 2) {
        cell.redDot.hidden = self.isNew;
    }
    
    return cell;
}

@end
