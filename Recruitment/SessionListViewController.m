//
//  MessageVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/6.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "SessionListViewController.h"
#import "MessageTableView.h"
#import "NTESSessionViewController.h"


@interface SessionListViewController ()

@property(nonatomic,strong) MessageTableView *msgTableView;

@end

@implementation SessionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#EDEEEF"];


    _msgTableView = (MessageTableView *)[MessageTableView tableViewWithframe:CGRectMake(0, 0, kScreen_Width, 60*3+10)];
    _msgTableView.scrollEnabled = NO;
//    [self.view addSubview:_msgTableView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 10)];
    view.backgroundColor = [UIColor colorWithHexString:@"#EDEEEF"];
    _msgTableView.tableFooterView = view;
    
    self.tableView.tableHeaderView = _msgTableView;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self is_new];
}

- (void)is_new
{

    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Is_new dic:paraDic showHUD:NO Succed:^(id responseObject) {

        NSNumber *code = [responseObject objectForKey:@"status"];
        
        if (code.boolValue) {
            _msgTableView.isNew = NO;

        }
        else {
            _msgTableView.isNew = YES;

        }
        [_msgTableView reloadData];

        
    } failure:^(NSError *error) {
        

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 聊天
- (void)onSelectedRecent:(NIMRecentSession *)recent
             atIndexPath:(NSIndexPath *)indexPath
{
    NTESSessionViewController *vc = [[NTESSessionViewController alloc] initWithSession:recent.session];
    vc.title = @"聊天";
    [self.navigationController pushViewController:vc animated:YES];
}



@end
