//
//  JobRecommandVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/12.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "JobRecommandVC.h"
#import "JobRecommandCell.h"

@interface JobRecommandVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *dataArr;
@property(nonatomic,strong) UITableView *tableView;


@end

@implementation JobRecommandVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return self.dataArr.count;
    return 10;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return (8+135);
    return (8+95);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    EditEducationMsgVC *vc = [[EditEducationMsgVC alloc] init];
//    vc.title = @"增加订阅";
//    [self.navigationController pushViewController:vc animated:YES];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JobRecommandCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[JobRecommandCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    return cell;
}

@end
