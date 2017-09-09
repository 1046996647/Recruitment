//
//  JobDetailVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/8.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "JobDetailVC.h"
#import "HXTagsView.h"
#import "JobDetailCell.h"
#import "CompanyDetailVC.h"


@interface JobDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) HXTagsView *tagsView;
@property(nonatomic,strong) UIButton *okBtn;


@end

@implementation JobDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 头视图
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0)];
    headView.backgroundColor = [UIColor whiteColor];
    
    // 职位
    UILabel *jobLab = [UILabel labelWithframe:CGRectMake(14, 9, 120, 17) text:@"配货包装工" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [headView addSubview:jobLab];
    
    UILabel *moneyLab = [UILabel labelWithframe:CGRectMake(kScreen_Width-47-12, 9, 47, 18) text:@"6-7k" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentRight textColor:@"#CE4A12"];
    [headView addSubview:moneyLab];
    
    NSArray *imgArr = @[@"30",@"29",@"27",@"26"];
    NSArray *titleArr1 = @[@"永康",@"一年",@"大专",@"全职"];
    for (int i=0; i<titleArr1.count; i++) {
        
        UIButton *okBtn = [UIButton buttonWithframe:CGRectMake(jobLab.left+(23+35)*i, jobLab.bottom+9, 45, 13) text:titleArr1[i] font:[UIFont systemFontOfSize:11] textColor:@"#333333" backgroundColor:nil normal:imgArr[i] selected:nil];
        okBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
        [headView addSubview:okBtn];
        self.okBtn = okBtn;
        
    }

    
    UILabel *lightLab = [UILabel labelWithframe:CGRectMake(jobLab.left, self.okBtn.bottom+6, 52, 14) text:@"职位亮点：" font:[UIFont systemFontOfSize:10] textAlignment:NSTextAlignmentLeft textColor:@"#999999"];
    [headView addSubview:lightLab];
    
    //单行滚动  ===============
    NSArray *tagAry = @[@"薪假",@"公游",@"保险"];
    //    单行不需要设置高度,内部根据初始化参数自动计算高度
    _tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(lightLab.right+5, lightLab.top-10, kScreen_Width-(lightLab.right+5)-12, 0)];
    _tagsView.type = 1;
    _tagsView.tagHorizontalSpace = 5.0;
    _tagsView.showsHorizontalScrollIndicator = NO;
    _tagsView.tagHeight = 15.0;
    _tagsView.titleSize = 10.0;
    _tagsView.tagOriginX = 0.0;
    _tagsView.titleColor = [UIColor colorWithHexString:@"#666666"];
    _tagsView.cornerRadius = _tagsView.tagHeight/2;
    _tagsView.userInteractionEnabled = NO;
    _tagsView.backgroundColor = [UIColor clearColor];
    _tagsView.borderColor = [UIColor colorWithHexString:@"#FFDDB0"];
    [_tagsView setTagAry:tagAry delegate:nil];
    [headView addSubview:_tagsView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, lightLab.bottom+6, kScreen_Width, 8)];
    view.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
    [headView addSubview:view];
    
    // 公司
    UIButton *inBtn = [UIButton buttonWithframe:CGRectMake(0, view.bottom, kScreen_Width, 70) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:nil selected:nil];
    [headView addSubview:inBtn];
    [inBtn addTarget:self action:@selector(inAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *logoView = [UIImageView imgViewWithframe:CGRectMake(14, view.bottom+8, 55, 55) icon:@"102"];
    [headView addSubview:logoView];
    logoView.layer.cornerRadius = 9;
    logoView.layer.masksToBounds = YES;
    
    UILabel *companyLab = [UILabel labelWithframe:CGRectMake(logoView.right+7, logoView.top, kScreen_Width-12-(logoView.right+7), 17) text:@"浙江金狮工贸有限公司永康分公司" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [headView addSubview:companyLab];
    
    UILabel *decLab = [UILabel labelWithframe:CGRectMake(companyLab.left, companyLab.bottom+5, kScreen_Width-26-(logoView.right+7), 14) text:@"五金机电 150-500人" font:[UIFont systemFontOfSize:10] textAlignment:NSTextAlignmentLeft textColor:@"#999999"];
    [headView addSubview:decLab];
    
    UIImageView *jiantouView = [UIImageView imgViewWithframe:CGRectMake(kScreen_Width-14-8, decLab.center.y-7, 8, 17) icon:@"24"];
    [headView addSubview:jiantouView];

    
    UILabel *addressLab = [UILabel labelWithframe:CGRectMake(companyLab.left, decLab.bottom+5, 100, 14) text:@"永嘉国贸大厦612室" font:[UIFont systemFontOfSize:10] textAlignment:NSTextAlignmentLeft textColor:@"#999999"];
    [headView addSubview:addressLab];
    
    UILabel *kmLab = [UILabel labelWithframe:CGRectMake(kScreen_Width-32-14, addressLab.top, 32, 14) text:@"5.2km" font:[UIFont systemFontOfSize:10] textAlignment:NSTextAlignmentRight textColor:@"#999999"];
    [headView addSubview:kmLab];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(0, logoView.bottom+7, kScreen_Width, 8)];
    view.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
    [headView addSubview:view];
    
    // 职位描述
    UIButton *decBtn = [UIButton buttonWithframe:CGRectMake(logoView.left, view.bottom+9, 82, 17) text:@"职位描述" font:[UIFont systemFontOfSize:14] textColor:@"#333333" backgroundColor:nil normal:@"22" selected:nil];
    decBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [headView addSubview:decBtn];
    
    UILabel *jobDecLab = [UILabel labelWithframe:CGRectMake(decBtn.left, decBtn.bottom+9, kScreen_Width-24, 16) text:@"工艺品包装，需要一年工作经验，永嘉本地人最好，大专以上即可。" font:[UIFont systemFontOfSize:10] textAlignment:NSTextAlignmentLeft textColor:@"#999999"];
    [headView addSubview:jobDecLab];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(0, jobDecLab.bottom+7, kScreen_Width, 8)];
    view.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
    [headView addSubview:view];
    
    UIButton *sameBtn = [UIButton buttonWithframe:CGRectMake(jobDecLab.left, view.bottom+9, 82, 17) text:@"相似职位" font:[UIFont systemFontOfSize:14] textColor:@"#333333" backgroundColor:nil normal:@"21" selected:nil];
    sameBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [headView addSubview:sameBtn];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(0, sameBtn.bottom+9, kScreen_Width, 1)];
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
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.view addSubview:rightView];
    
    UIButton *shareBtn = [UIButton buttonWithframe:CGRectMake(0, 10, 20, 20) text:nil font:nil textColor:nil backgroundColor:nil normal:@"25" selected:nil];
    [rightView addSubview:shareBtn];
    
    UIButton *cellctionBtn = [UIButton buttonWithframe:CGRectMake(shareBtn.right, shareBtn.top, 20, 20) text:nil font:nil textColor:nil backgroundColor:nil normal:@"23" selected:nil];
    [rightView addSubview:cellctionBtn];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    
    // 底部视图
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreen_Height-64-40, kScreen_Width, 40)];
    [self.view addSubview:bottomView];
    
    UIButton *phoneBtn = [UIButton buttonWithframe:CGRectMake(0, 0, kScreen_Width/2, bottomView.height) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:@"19" selected:nil];
    [bottomView addSubview:phoneBtn];
    
    UIButton *applyBtn = [UIButton buttonWithframe:CGRectMake(phoneBtn.width, phoneBtn.top, phoneBtn.width, bottomView.height) text:@"申请职位" font:[UIFont systemFontOfSize:14] textColor:@"#FFFFFF" backgroundColor:@"#FF9123" normal:nil selected:nil];
    [bottomView addSubview:applyBtn];

}

- (void)inAction
{
    CompanyDetailVC *vc = [[CompanyDetailVC alloc] init];
    vc.title = @"公司详情";
    [self.navigationController pushViewController:vc animated:YES];
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
