//
//  SendHistoryVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/11.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "SendHistoryVC.h"
#import "JobTableView.h"

@interface SendHistoryVC ()
@property(nonatomic,strong) JobTableView *tableView;
@property(nonatomic,assign) NSInteger pageNO;
@property(nonatomic,strong) NSMutableArray *modelArr;
@property (nonatomic,assign) BOOL isRefresh;

@end

@implementation SendHistoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView = (JobTableView *)[JobTableView tableViewWithframe:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64)];
    [self.view addSubview:_tableView];
    
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        if (self.modelArr.count > 0) {
            
            [self get_resume];
        }
        
    }];
    
    self.pageNO = 1;
    self.modelArr = [NSMutableArray array];
    
    [self get_resume];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)get_resume
{
    if (!self.isRefresh) {
        [SVProgressHUD show];
        
    }
    
    // p/当前页码/size/每页显示条数
    NSString *urlStr = [NSString stringWithFormat:@"%@/p/%ld",Get_resume,self.pageNO];
    
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:urlStr dic:paraDic showHUD:YES Succed:^(id responseObject) {
        
        self.isRefresh = YES;
        [SVProgressHUD dismiss];
        [self.tableView.mj_footer endRefreshing];
        
        NSArray *arr = responseObject[@"data"];
        if ([arr isKindOfClass:[NSArray class]]) {
            
            NSMutableArray *arrM = [NSMutableArray array];
            for (NSDictionary *dic in arr) {
                JobModel *model = [JobModel yy_modelWithJSON:dic];
                [arrM addObject:model];
            }
            
            [self.modelArr addObjectsFromArray:arrM];
            _tableView.dataArr = self.modelArr;

            [self.tableView reloadData];
            
            self.pageNO++;
            
            
        }
        else {
            
            // 拿到当前的上拉刷新控件，变为没有更多数据的状态
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD dismiss];
        [self.tableView.mj_footer endRefreshing];
    }];
}

@end
