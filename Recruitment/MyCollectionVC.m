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

@end

@implementation MyCollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView = (JobTableView *)[JobTableView tableViewWithframe:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64)];
    [self.view addSubview:_tableView];
    _tableView.cellType = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
