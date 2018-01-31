//
//  SendMsgVC.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/18.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "SendMsgVC.h"
#import "ReceiveMsgCell.h"
#import "ZFTableViewCell.h"
#import "MsgDetailVC.h"


@interface SendMsgVC ()<UITableViewDelegate,UITableViewDataSource,ZFTableViewCellDelegate>
//@property (nonatomic,strong) NSArray *dataArr;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,assign) NSInteger pageNO;
@property(nonatomic,strong) NSMutableArray *modelArr;
@property (nonatomic,assign) BOOL isRefresh;
@property(nonatomic,strong) NSMutableArray *selectedArr;// 选择数组

@property (nonatomic,strong) NSArray *jobArr;
@property (nonatomic,assign) BOOL isShow;

@end

@implementation SendMsgVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64-40-37) style:UITableViewStyleGrouped];
    //    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64-40-37)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    //    _tableView.backgroundColor = [UIColor redColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    // 底部按钮
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, _tableView.bottom, kScreen_Width, 40)];
    baseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baseView];
    
    UIButton *selectBtn = [UIButton buttonWithframe:CGRectMake(0, 0, 100, 40) text:@"全选" font:SystemFont(14) textColor:@"#333333" backgroundColor:nil normal:@"" selected:nil];
    [baseView addSubview:selectBtn];
    [selectBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //    CGFloat aWidth = (kScreen_Width-selectBtn.width)/2;
    UIButton *delBtn = [UIButton buttonWithframe:CGRectMake(selectBtn.right, 0, kScreen_Width-selectBtn.right, selectBtn.height) text:@"删除选中" font:SystemFont(14) textColor:@"#FFFFFF" backgroundColor:@"#999999" normal:@"" selected:nil];
    [baseView addSubview:delBtn];
    [delBtn addTarget:self action:@selector(delAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    //    UIButton *inviteBtn = [UIButton buttonWithframe:CGRectMake(selectBtn.right, 0, kScreen_Width-selectBtn.right, selectBtn.height) text:@"批量邀请面试" font:SystemFont(14) textColor:@"#FFFFFF" backgroundColor:@"#D0021B" normal:@"" selected:nil];
    //    [baseView addSubview:inviteBtn];
    //    [inviteBtn addTarget:self action:@selector(inviteAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    // 下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self headerRefresh];
    }];
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;
    
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        if (self.modelArr.count > 0) {
            // 搜索职位
            [self get_message_fromme];
        }
        
    }];
    
    self.pageNO = 1;
    self.modelArr = [NSMutableArray array];
    self.selectedArr = [NSMutableArray array];
    
    [self get_message_fromme];
    
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_tableView reloadData];
}

- (void)headerRefresh
{
    self.pageNO = 1;
    if (self.modelArr.count > 0) {
        [self.modelArr removeAllObjects];
        
    }
    [self get_message_fromme];
}

- (void)get_message_fromme
{
    
    if (!self.isRefresh) {
        [SVProgressHUD show];
        
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/p/%ld",Get_message_fromme,self.pageNO];
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    
    
    [AFNetworking_RequestData requestMethodPOSTUrl:urlStr dic:paramDic showHUD:NO Succed:^(id responseObject) {
        
        self.isRefresh = YES;
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        NSArray *arr = responseObject[@"data"];
        if ([arr isKindOfClass:[NSArray class]] && [arr count]) {
            
            NSMutableArray *arrM = [NSMutableArray array];
            for (NSDictionary *dic in arr) {
                
                NSMutableArray *arrM1 = [NSMutableArray array];
                ReceiveMsgModel *model = [ReceiveMsgModel yy_modelWithJSON:dic];
                [arrM1 addObject:model];
                [arrM addObject:arrM1];
            }
            
            [self.modelArr addObjectsFromArray:arrM];
            
            self.pageNO++;
        }
        else {
            
            // 拿到当前的上拉刷新控件，变为没有更多数据的状态
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
        self.isRefresh = YES;
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}


- (void)delAction
{
    
    if (self.selectedArr.count == 0) {
        
        [self.view makeToast:@"请先选择信息"];
        return;
    }
    
    
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    
    NSMutableArray *idArr = [NSMutableArray array];
    for (ReceiveMsgModel *model in self.selectedArr) {
        [idArr addObject:model.messId];
        
    }
    NSString *string = [idArr componentsJoinedByString:@","]; //,为分隔符
    [paraDic setValue:string forKey:@"messId"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Delete_mess dic:paraDic showHUD:YES Succed:^(id responseObject) {
        self.isRefresh = NO;
        [self headerRefresh];


    } failure:^(NSError *error) {


    }];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)inviteAction
//{
//    if (self.selectedArr.count == 0) {
//        [self.view makeToast:@"请先选择简历"];
//
//        return;
//    }
//    InviteInterviewVC *vc = [[InviteInterviewVC alloc] init];
//    vc.title = @"邀请面试";
//    vc.selectedArr = self.selectedArr;
//    [self.navigationController pushViewController:vc animated:YES];
//    vc.block = ^{
//
//        //        [self.selectedArr removeAllObjects];
//        for (NSArray *arr in self.modelArr) {
//
//            for (ReceiveMsgModel *model in arr) {
//
//                model.jobstatus = @"3";
//
//            }
//
//        }
//
//
//        [_tableView reloadData];
//    };
//}

- (void)selectAction:(UIButton *)btn
{
    if ([btn.currentTitle isEqualToString:@"全选"]) {
        [btn setTitle:@"全不选" forState:UIControlStateNormal];
        
        for (NSArray *arr in self.modelArr) {
            
            for (ReceiveMsgModel *model in arr) {
                
                model.isSelected = YES;
                
                if (![self.selectedArr containsObject:model]) {
                    [self.selectedArr addObject:model];
                }
            }
            
        }
        
    }
    else {
        [btn setTitle:@"全选" forState:UIControlStateNormal];
        for (NSArray *arr in self.modelArr) {
            
            for (ReceiveMsgModel *model in arr) {
                model.isSelected = NO;
            }
            
        }
        [self.selectedArr removeAllObjects];
        
    }
    
    [_tableView reloadData];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.modelArr count];
    //    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.modelArr[section] count];
    //    return 1;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ReceiveMsgModel *model = self.modelArr[indexPath.section][indexPath.row];
    MsgDetailVC *vc = [[MsgDetailVC alloc] init];
    vc.title = @"短信内容";
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
    vc.block = ^{
        
        NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
        
        [paraDic setValue:model.messId forKey:@"messId"];
        
        [AFNetworking_RequestData requestMethodPOSTUrl:Delete_mess dic:paraDic showHUD:YES Succed:^(id responseObject) {
            
            [self.modelArr removeObjectAtIndex:indexPath.section];
            [self.tableView reloadData];
            [self.navigationController popViewControllerAnimated:YES];
            
        } failure:^(NSError *error) {
            
            
        }];
    };
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ReceiveMsgModel *model = self.modelArr[section][0];

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 30)];
    //    view.backgroundColor = [UIColor colorWithHexString:@"#FAE5E8"];
    UILabel *label = [UILabel labelWithframe:CGRectMake(19, 7, kScreen_Width-19, 17) text:model.addTime1 font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
    [view addSubview:label];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;// 为0无效
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0.0001)];
    //    view.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
    return view;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* identity = @"FDFeedCell";
    
    ReceiveMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (cell == nil) {
        
        cell = [[ReceiveMsgCell alloc]initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:identity
                                           delegate:self
                                        inTableView:tableView
                              withRightButtonTitles:@[@""]
                              withRightButtonColors:@[[UIColor clearColor]]
                                               type:ZFTableViewCellTypeThree
                                          rowHeight:100];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.block = ^(ReceiveMsgModel *model) {
            if (model.isSelected) {
                [self.selectedArr addObject:model];

            }
            else {
                [self.selectedArr removeObject:model];
            }

        };
        
    }
    if (self.modelArr.count > 0) {
        ReceiveMsgModel *model = self.modelArr[indexPath.section][indexPath.row];
        cell.model = model;
    }
    
    
    return cell;
}

#pragma mark - ZFTableViewCellDelegate
-(void)buttonTouchedOnCell:(ZFTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath atButtonIndex:(NSInteger)buttonIndex{
    NSLog(@"row:%ld,buttonIndex:%ld",(long)indexPath.row,(long)buttonIndex);
    
    ReceiveMsgModel *model = self.modelArr[indexPath.section][indexPath.row];
    
    // 删除简历
    if (buttonIndex == 0){
        NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
        
        [paraDic setValue:model.messId forKey:@"messId"];
        
        [AFNetworking_RequestData requestMethodPOSTUrl:Delete_mess dic:paraDic showHUD:YES Succed:^(id responseObject) {
            
            [self.modelArr removeObjectAtIndex:indexPath.section];
            [self.tableView reloadData];
            
        } failure:^(NSError *error) {
            
            
        }];
    }
    else if (buttonIndex == 1){
        
        MsgDetailVC *vc = [[MsgDetailVC alloc] init];
        vc.title = @"短信内容";
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
        vc.block = ^{
            
            NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
            
            [paraDic setValue:model.messId forKey:@"messId"];
            
            [AFNetworking_RequestData requestMethodPOSTUrl:Delete_mess dic:paraDic showHUD:YES Succed:^(id responseObject) {
                
                [self.modelArr removeObjectAtIndex:indexPath.section];
                [self.tableView reloadData];
                [self.navigationController popViewControllerAnimated:YES];
                
            } failure:^(NSError *error) {
                
                
            }];
        };
        
        //把cell复原
        [[NSNotificationCenter defaultCenter] postNotificationName:ZFTableViewCellNotificationChangeToUnexpanded object:nil];
    }
    
}

@end
