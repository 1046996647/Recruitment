//
//  SubscriptionJobVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/11.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "SubscriptionJobVC.h"
#import "SubscriptionManageVC.h"
#import "JobTableView.h"

@interface SubscriptionJobVC ()

@property(nonatomic,strong) JobTableView *tableView;
@property(nonatomic,assign) NSInteger pageNO;
@property(nonatomic,strong) NSMutableArray *modelArr;
@property (nonatomic,assign) BOOL isRefresh;
@property(nonatomic,strong) UIView *baseView;


@end

@implementation SubscriptionJobVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    _tableView = (JobTableView *)[JobTableView tableViewWithframe:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64)];
    [self.view addSubview:_tableView];
    
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        if (self.modelArr.count > 0) {
            
            [self search_ordered_jobs];
        }
        
    }];
    
    
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, (kScreen_Height-64-90)/2, kScreen_Width, 90)];
    [self.view addSubview:baseView];
    self.baseView = baseView;
    
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
    [manageBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:manageBtn];
    
    self.pageNO = 1;
    self.modelArr = [NSMutableArray array];
    
    [self search_ordered_jobs];
}

- (void)search_ordered_jobs
{
    if (!self.isRefresh) {
        [SVProgressHUD show];
        
    }
    
    // p/当前页码/size/每页显示条数
    NSString *urlStr = [NSString stringWithFormat:@"%@/p/%ld",Search_ordered_jobs,self.pageNO];
    
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:urlStr dic:paraDic showHUD:YES Succed:^(id responseObject) {
        
        self.isRefresh = YES;
        [SVProgressHUD dismiss];
        [self.tableView.mj_footer endRefreshing];
        
        NSArray *arr = responseObject[@"data"];
        if ([arr isKindOfClass:[NSArray class]]) {
            
            if (arr.count > 0) {
                self.baseView.hidden = YES;
            }
            else {
                self.baseView.hidden = NO;
                
            }
            
            NSMutableArray *arrM = [NSMutableArray array];
            for (NSDictionary *dic in arr) {
                JobModel *model = [JobModel yy_modelWithJSON:dic];
                [arrM addObject:model];
            }
            
            [self.modelArr addObjectsFromArray:arrM];
            _tableView.dataArr = self.modelArr;
            
            
            self.pageNO++;

        }
        else {
            
            // 拿到当前的上拉刷新控件，变为没有更多数据的状态
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }

        [self.tableView reloadData];

        
    } failure:^(NSError *error) {
        
        [SVProgressHUD dismiss];
        [self.tableView.mj_footer endRefreshing];
    }];
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
    vc.block = ^{
        
        self.pageNO = 1;
        if (self.modelArr.count > 0) {
            [self.modelArr removeAllObjects];
            
        }
        [self search_ordered_jobs];
        
    };
}

@end
