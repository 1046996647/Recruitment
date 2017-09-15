//
//  PersonalCenterVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/6.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "PersonalCenterVC.h"
#import "PersonalCell.h"
#import "LoginVC.h"
#import "MyCollectionVC.h"
#import "OpinionVC.h"
#import "SettingVC.h"
#import "SubscriptionManageVC.h"

@interface PersonalCenterVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataArr;
@property (nonatomic,strong) UILabel *label;


@end

@implementation PersonalCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIButton *btn = [UIButton buttonWithframe:CGRectMake(0, 0, kScreen_Width, 90) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:nil selected:nil];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];

    
    UIImageView *imgView = [UIImageView imgViewWithframe:CGRectMake(9, 9, 72, 72) icon:@"96"];
    
    UILabel *label = [UILabel labelWithframe:CGRectMake(imgView.right+12, (btn.height-18)/2, 100, 18) text:@"登录/注册" font:[UIFont systemFontOfSize:17] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    self.label = label;
    
    [btn addSubview:imgView];
    [btn addSubview:label];
    
    self.dataArr = @[@[@{@"image":@"23",@"title":@"我的收藏"},@{@"image":@"109",@"title":@"我的关注"}],
                     @[@{@"image":@"108",@"title":@"订阅管理"},@{@"image":@"107",@"title":@"薪资测评"}],
                     @[@{@"image":@"106",@"title":@"联系客服"},@{@"image":@"105",@"title":@"意见反馈"}],
                     @[@{@"image":@"104",@"title":@"设置"}]];
    
    
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64-49)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.tableHeaderView = btn;
    

}

- (void)btnAction:(UIButton *)btn
{
    NSString *userid = [InfoCache unarchiveObjectWithFile:@"userid"];
    if (!userid) {
        LoginVC *vc = [[LoginVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }

}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    PersonModel *person = [InfoCache unarchiveObjectWithFile:Person];
    self.label.text = person.name;
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
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *userid = [InfoCache unarchiveObjectWithFile:@"userid"];
    if (!userid) {
        LoginVC *vc = [[LoginVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
        return;
    }
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            MyCollectionVC *vc = [[MyCollectionVC alloc] init];
            vc.title = @"我的收藏";
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        if (indexPath.row == 1) {
            
        }
    }
    if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            SubscriptionManageVC *vc = [[SubscriptionManageVC alloc] init];
            vc.title = @"订阅管理";
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        if (indexPath.row == 1) {
            
        }
    }
    if (indexPath.section == 2) {
        
        if (indexPath.row == 0) {
            

            
        }
        if (indexPath.row == 1) {
            
            OpinionVC *vc = [[OpinionVC alloc] init];
            vc.title = @"意见反馈";
            [self.navigationController pushViewController:vc animated:YES];
            
        }
    }
    if (indexPath.section == 3) {
        
        if (indexPath.row == 0) {
            
            SettingVC *vc = [[SettingVC alloc] init];
            vc.title = @"设置";
            [self.navigationController pushViewController:vc animated:YES];
            
        }
  
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PersonalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[PersonalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary *dic = self.dataArr[indexPath.section][indexPath.row];
    cell.imgView.image = [UIImage imageNamed:dic[@"image"]];
    cell.label.text = dic[@"title"];
    
    return cell;
}


@end
