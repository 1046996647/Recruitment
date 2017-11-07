//
//  MessageVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/6.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "MessageVC.h"
#import "MessageTableView.h"

@interface MessageVC ()

@property(nonatomic,strong) MessageTableView *tableView;

@end

@implementation MessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    _tableView = (MessageTableView *)[MessageTableView tableViewWithframe:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64-49)];
    [self.view addSubview:_tableView];
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
            _tableView.isNew = NO;

        }
        else {
            _tableView.isNew = YES;

        }
        [_tableView reloadData];

        
    } failure:^(NSError *error) {
        

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
