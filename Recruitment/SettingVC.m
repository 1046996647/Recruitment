//
//  SettingVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/11.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "SettingVC.h"
#import "MyCountVC.h"
#import "AboutUsVC.h"
#import "AppDelegate.h"


@interface SettingVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataArr;


@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 35)];
    
    UIButton *btn = [UIButton buttonWithframe:CGRectMake(13, 0, baseView.width-26, baseView.height) text:@"退出登录" font:[UIFont systemFontOfSize:14] textColor:@"#FFFFFF" backgroundColor:@"#FF9123" normal:@"" selected:nil];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    [baseView addSubview:btn];
    [btn addTarget:self action:@selector(exitAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.dataArr = @[@[@"我的账号"],
                     @[@"清除缓存"],
                     @[@"关于我们",@"用户协议",@"软件评分"]];
    
    
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64-49)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = baseView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)exitAction
{
    [InfoCache archiveObject:nil toFile:Person];
    
    [self.navigationController popToRootViewControllerAnimated:YES];

//    AppDelegate *appDelegate = [AppDelegate share];
//    [appDelegate.tabVC selectController:0];
    
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
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            MyCountVC *vc = [[MyCountVC alloc] init];
            vc.title = @"我的账号";
            [self.navigationController pushViewController:vc animated:YES];
            
        }

    }
    if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            [SVProgressHUD showWithStatus:@"缓存清除中..."];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD showSuccessWithStatus:@"缓存清除成功!"];

                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

                    [SVProgressHUD dismiss];
                    
                    
                });
            });
            
            
        }

    }
    if (indexPath.section == 2) {
        
        if (indexPath.row == 0) {
            
            AboutUsVC *vc = [[AboutUsVC alloc] init];
            vc.title = @"关于我们";
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row == 1) {
            

            
        }
        if (indexPath.row == 2) {
            
            //            OpinionVC *vc = [[OpinionVC alloc] init];
            //            vc.title = @"意见反馈";
            //            [self.navigationController pushViewController:vc animated:YES];
            
        }
    }

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 21;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    cell.textLabel.text = self.dataArr[indexPath.section][indexPath.row];
    
    return cell;
}

@end
