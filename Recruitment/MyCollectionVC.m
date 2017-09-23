//
//  MyCollectionVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/11.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "MyCollectionVC.h"
#import "JobTableView.h"

@interface MyCollectionVC ()
@property(nonatomic,strong) JobTableView *tableView;
@property(nonatomic,strong) NSMutableArray *modelArr;

@end

@implementation MyCollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView = (JobTableView *)[JobTableView tableViewWithframe:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64)];
    [self.view addSubview:_tableView];
    
    [self get_favs_job];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)get_favs_job
{
    
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Get_favs_job dic:paraDic showHUD:YES Succed:^(id responseObject) {
        
        NSArray *arr = responseObject[@"data"];
        if ([arr isKindOfClass:[NSArray class]]) {
            
            NSMutableArray *arrM = [NSMutableArray array];
            for (NSDictionary *dic in arr) {
                JobModel *model = [JobModel yy_modelWithJSON:dic];
                [arrM addObject:model];
            }
            
            _tableView.dataArr = arrM;
            _tableView.cellType = 1;

        }

        
    } failure:^(NSError *error) {
        
        
    }];
}


@end
