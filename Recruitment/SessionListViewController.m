//
//  MessageVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/6.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "SessionListViewController.h"
#import "NTESSessionViewController.h"


@interface SessionListViewController ()<UIViewControllerPreviewingDelegate>

@property (nonatomic,assign) BOOL supportsForceTouch;


@end

@implementation SessionListViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#EDEEEF"];
    
//    self.tableView1 = [[UITableView alloc] init];
//    self.tableView1 = self.tableView;
    
    self.supportsForceTouch = [self.traitCollection respondsToSelector:@selector(forceTouchCapability)] && self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable;

//    _msgView = [[MessageTableView alloc] initWithFrame:CGRectMake(0, -(60*3+10), kScreen_Width, 60*3+10)];
    _msgView = [[MessageTableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 60*3+10)];
    _msgView.scrollEnabled = NO;
//    [self.view addSubview:_msgView];
//    _msgView.hidden = NO;
//    _msgView.backgroundColor = [UIColor redColor];

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 10)];
    view.backgroundColor = [UIColor colorWithHexString:@"#efefef"];
    _msgView.tableFooterView = view;

    self.tableView.contentInset = UIEdgeInsetsMake(_msgView.height, 0, 0, 0);
    
    // 面试邀请和信箱
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(is_new) name:@"KInterviewNotification" object:nil];
    
    if (self.recentSessions.count == 0) {
        
        _msgView.top = 0;
        [self.view addSubview:_msgView];

    }
    else {
        _msgView.top = -(60*3+10);
        [self.tableView addSubview:_msgView];

    }
//    self.tableView1.tableHeaderView = _msgView;

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    self.tableView.tableHeaderView = _msgTableView;

    [self is_new];
}

- (void)is_new
{
    
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Is_new dic:paraDic showHUD:NO Succed:^(id responseObject) {
        
        //        {
        //            countInvite = 12;
        //            countMess = 7;
        //            message = "";
        //            status = 1;
        //        }
        NSNumber *countInvite = [responseObject objectForKey:@"countInvite"];
        NSNumber *countMess = [responseObject objectForKey:@"countMess"];
        
        _msgView.number = countInvite.integerValue;
        [_msgView reloadData];
        
        
    } failure:^(NSError *error) {
        
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.supportsForceTouch) {
        id<UIViewControllerPreviewing> preview = [self registerForPreviewingWithDelegate:self sourceView:cell];
//        [self.previews setObject:preview forKey:@(indexPath.row)];
    }
    
//    if (self.recentSessions.count == 0) {
//
//        _msgView.hidden = NO;
//
//    }
//    else {
//        _msgView.hidden = YES;
//
////        self.tableView.tableHeaderView = _msgView;
//        [self.tableView1 addSubview:_msgView];
//
//    }
    if (self.recentSessions.count == 0) {
        
        _msgView.top = 0;
        [self.view addSubview:_msgView];
        
    }
    else {
        _msgView.top = -(60*3+10);
        [self.tableView addSubview:_msgView];
        
    }
}

// 聊天
- (void)onSelectedRecent:(NIMRecentSession *)recent
             atIndexPath:(NSIndexPath *)indexPath
{
    NTESSessionViewController *vc = [[NTESSessionViewController alloc] initWithSession:recent.session];
    vc.title = @"聊天";
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 *  删除某一条最近会话时触发的事件回调
 *
 *  @param recent    最近会话
 *  @param indexPath 最近会话cell所在的位置
 *  @discussion      默认将删除会话，并检查是否需要删除服务器的会话（防止漫游）
 */
- (void)onDeleteRecentAtIndexPath:(NIMRecentSession *)recent
                      atIndexPath:(NSIndexPath *)indexPath
{
    [super onDeleteRecentAtIndexPath:recent atIndexPath:indexPath];
    [self refresh];

//    if (self.recentSessions.count == 0) {
//
//        _msgView.hidden = NO;
//
//    }
//    else {
//        [_msgView removeFromSuperview];
//
//    }
    if (self.recentSessions.count == 0) {
        
        _msgView.top = 0;
        [self.view addSubview:_msgView];
        
    }
    else {
        _msgView.top = -(60*3+10);
        [self.tableView addSubview:_msgView];
        
    }
}



@end
