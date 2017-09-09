//
//  CompanyDetailVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/8.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "CompanyDetailVC.h"
#import "JobDetailCell.h"


@interface CompanyDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;

@end

@implementation CompanyDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 头视图
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0)];
    headView.backgroundColor = [UIColor whiteColor];
    
    // 公司
    UIButton *inBtn = [UIButton buttonWithframe:CGRectMake(0, 0, kScreen_Width, 70) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:nil selected:nil];
    [headView addSubview:inBtn];
    //    [inBtn addTarget:self action:@selector(inAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *logoView = [UIImageView imgViewWithframe:CGRectMake(14, 7, 55, 55) icon:@"102"];
    [headView addSubview:logoView];
    logoView.layer.cornerRadius = 9;
    logoView.layer.masksToBounds = YES;
    
    UILabel *companyLab = [UILabel labelWithframe:CGRectMake(logoView.right+7, logoView.top, kScreen_Width-12-(logoView.right+7), 17) text:@"浙江金狮工贸有限公司永康分公司" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [headView addSubview:companyLab];
    
    UILabel *decLab = [UILabel labelWithframe:CGRectMake(companyLab.left, companyLab.bottom+5, kScreen_Width-26-(logoView.right+7), 14) text:@"五金机电 150-500人" font:[UIFont systemFontOfSize:10] textAlignment:NSTextAlignmentLeft textColor:@"#999999"];
    [headView addSubview:decLab];
    
    UILabel *addressLab = [UILabel labelWithframe:CGRectMake(companyLab.left, decLab.bottom+5, 100, 14) text:@"永嘉国贸大厦612室" font:[UIFont systemFontOfSize:10] textAlignment:NSTextAlignmentLeft textColor:@"#999999"];
    [headView addSubview:addressLab];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, logoView.bottom+7, kScreen_Width, 8)];
    view.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
    [headView addSubview:view];
    
    // 性质和网址
    UILabel *typeLab = [UILabel labelWithframe:CGRectMake(logoView.left, view.bottom+6, 100, 14) text:@"公司性质" font:[UIFont systemFontOfSize:10] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [headView addSubview:typeLab];
    
    UILabel *typeLab1 = [UILabel labelWithframe:CGRectMake(typeLab.left, typeLab.bottom+6, 100, 17) text:@"民营" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [headView addSubview:typeLab1];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(kScreen_Width/2-1, view.bottom+9, 1, 30)];
    line.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
    [headView addSubview:line];
    
    UILabel *webLab = [UILabel labelWithframe:CGRectMake(line.right+14, typeLab.top, 100, 14) text:@"公司网址" font:[UIFont systemFontOfSize:10] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [headView addSubview:webLab];
    
    UILabel *webLab1 = [UILabel labelWithframe:CGRectMake(webLab.left, typeLab1.top, 100, 17) text:@"民营" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#FF9123"];
    [headView addSubview:webLab1];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(0, webLab1.bottom+5, kScreen_Width, 8)];
    view.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
    [headView addSubview:view];
    
    // 公司地址
    UIButton *decBtn = [UIButton buttonWithframe:CGRectMake(logoView.left, view.bottom+9, 82, 17) text:@"公司地址" font:[UIFont systemFontOfSize:14] textColor:@"#333333" backgroundColor:nil normal:@"Shape" selected:nil];
    decBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [headView addSubview:decBtn];
    
    UILabel *jobDecLab = [UILabel labelWithframe:CGRectMake(decBtn.left, decBtn.bottom+9, kScreen_Width-24, 16) text:@"浙江省永嘉市网生路2号" font:[UIFont systemFontOfSize:10] textAlignment:NSTextAlignmentLeft textColor:@"#999999"];
    [headView addSubview:jobDecLab];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(0, jobDecLab.bottom+7, kScreen_Width, 8)];
    view.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
    [headView addSubview:view];
    
    
    // 公司介绍
    UIButton *sameBtn = [UIButton buttonWithframe:CGRectMake(jobDecLab.left, view.bottom+9, 82, 17) text:@"公司介绍" font:[UIFont systemFontOfSize:14] textColor:@"#333333" backgroundColor:nil normal:@"21" selected:nil];
    sameBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [headView addSubview:sameBtn];
    
    UILabel *companyDecLab = [UILabel labelWithframe:CGRectMake(sameBtn.left, sameBtn.bottom+9, kScreen_Width-24, 16) text:@"提供长期稳定的就业环境，不断提高员工的薪资水平。" font:[UIFont systemFontOfSize:10] textAlignment:NSTextAlignmentLeft textColor:@"#999999"];
    [headView addSubview:companyDecLab];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(0, companyDecLab.bottom+9, kScreen_Width, 8)];
    view.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
    [headView addSubview:view];
    
    // 正在招聘的职位
    UIButton *wantBtn = [UIButton buttonWithframe:CGRectMake(jobDecLab.left, view.bottom+9, 120, 17) text:@"正在招聘的职位" font:[UIFont systemFontOfSize:14] textColor:@"#333333" backgroundColor:nil normal:@"Group 10" selected:nil];
    wantBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [headView addSubview:wantBtn];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(0, wantBtn.bottom+9, kScreen_Width, 1)];
    view.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
    [headView addSubview:view];
    
    headView.height = view.bottom;

    
    // 表视图
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64-40)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.tableHeaderView = headView;
    
    // 右上角按钮
    UIButton *cellctionBtn = [UIButton buttonWithframe:CGRectMake(0, 0, 20, 20) text:nil font:nil textColor:nil backgroundColor:nil normal:@"23" selected:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cellctionBtn];
    
    // 底部视图
    UIButton *sahreBtn = [UIButton buttonWithframe:CGRectMake(0, kScreen_Height-64-40, kScreen_Width, 40) text:@"分享" font:[UIFont systemFontOfSize:14] textColor:@"#FFFFFF" backgroundColor:@"#FF9123" normal:@"Group 7" selected:nil];
    sahreBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [self.view addSubview:sahreBtn];

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
    return 83;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JobDetailCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        
        cell = [[JobDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    
    return cell;
}

@end
