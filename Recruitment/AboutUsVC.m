//
//  AboutUsVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/11.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "AboutUsVC.h"

@interface AboutUsVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataArr;
@property (nonatomic,strong) NSArray *dataArr1;


@end

@implementation AboutUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 35)];
    baseView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imgView = [UIImageView imgViewWithframe:CGRectMake((kScreen_Width-51)/2, 28, 51, 45) icon:@"102"];
    [baseView addSubview:imgView];

    UILabel *label = [UILabel labelWithframe:CGRectMake(0, imgView.bottom+9, kScreen_Width, 20) text:@"众信人才" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentCenter textColor:@"#333333"];
    [baseView addSubview:label];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, label.bottom+9, kScreen_Width, 1)];
    view.backgroundColor = [UIColor colorWithHexString:@"#CACACA"];
    [baseView addSubview:view];
    
    baseView.height = view.bottom;
    
    self.dataArr = @[@"官方网站",@"官方微信",@"当前版本"];
    self.dataArr1 = @[@"www.52ykjob.com",@"众信人才",@"1.0.0"];
    
    
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64-49)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.tableHeaderView = baseView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArr count];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    }
    cell.textLabel.text = self.dataArr[indexPath.row];
    cell.detailTextLabel.text = self.dataArr1[indexPath.row];
    
    return cell;
}

@end
