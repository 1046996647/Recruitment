//
//  SubscriptionJobVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/11.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "SubscriptionJobVC.h"
#import "SubscriptionManageVC.h"

@interface SubscriptionJobVC ()

@end

@implementation SubscriptionJobVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, (kScreen_Height-64-90)/2, kScreen_Width, 90)];
    [self.view addSubview:baseView];

    
    UILabel *label = [UILabel labelWithframe:CGRectMake(0, 0, baseView.width, 17) text:@"你还没有增加任何订阅，赶紧去添加吧" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentCenter textColor:@"#999999"];
    [baseView addSubview:label];
    
    UIButton *btn = [UIButton buttonWithframe:CGRectMake((kScreen_Width-125)/2, label.bottom+16, 125, 35) text:@"增加订阅" font:[UIFont systemFontOfSize:14] textColor:@"#FF9123" backgroundColor:nil normal:@"" selected:nil];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    btn.layer.borderColor = [UIColor colorWithHexString:@"#FF9123"].CGColor;
    btn.layer.borderWidth = 1;
    [baseView addSubview:btn];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
    // 管理
    UIButton *manageBtn = [UIButton buttonWithframe:CGRectMake(0, 0, 30, 17) text:@"管理" font:[UIFont systemFontOfSize:14] textColor:@"#030303" backgroundColor:nil normal:nil selected:nil];
//    [preBtn addTarget:self action:@selector(preAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:manageBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnAction
{
    SubscriptionManageVC *vc = [[SubscriptionManageVC alloc] init];
    vc.title = @"订阅管理";
    [self.navigationController pushViewController:vc animated:YES];
}

@end
