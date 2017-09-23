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
#import "JobModel.h"
#import "NSStringExt.h"
#import "ShareVC.h"
#import "LoginVC.h"


@interface JobDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) HXTagsView *tagsView;
@property(nonatomic,strong) UIButton *okBtn;
@property(nonatomic,strong) NSMutableArray *modelArr;
@property(nonatomic,strong) UIButton *cellctionBtn;
@property(nonatomic,strong) UIButton *applyBtn;


@end

@implementation JobDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 2.2	职位详情
    [self get_jobs_detail];

}

- (void)get_jobs_detail
{

    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    
    [paraDic setValue:self.model.ID forKey:@"id"];
    [paraDic setValue:self.model.job_name forKey:@"key"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Get_jobs_detail dic:paraDic showHUD:YES Succed:^(id responseObject) {
        
        JobModel *model = [JobModel yy_modelWithJSON:responseObject[@"data"]];
        self.model = model;
        
        NSArray *arr = model.related_work;
        if ([arr isKindOfClass:[NSArray class]]) {
            
            NSMutableArray *arrM = [NSMutableArray array];
            for (NSDictionary *dic in arr) {
                JobModel *model = [JobModel yy_modelWithJSON:dic];
                [arrM addObject:model];
            }
            
            self.modelArr = arrM;
            [self.tableView reloadData];
            
        }
        
        if (model) {
            [self initViews];

        }
        
    } failure:^(NSError *error) {
        
        
    }];
}

- (void)initViews
{
    // 头视图
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0)];
    headView.backgroundColor = [UIColor whiteColor];
    
    // 职位 配货包装工
    UILabel *jobLab = [UILabel labelWithframe:CGRectMake(14, 9, 120, 17) text:self.model.job_name font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [headView addSubview:jobLab];
    
    // 6-7k
    UILabel *moneyLab = [UILabel labelWithframe:CGRectMake(kScreen_Width-47-12, 9, 47, 18) text:[NSString stringWithFormat:@"%@k",self.model.pay] font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentRight textColor:@"#CE4A12"];
    [headView addSubview:moneyLab];
    
    if (![self.model.years isEqualToString:@"不限"]) {
        self.model.years = [NSString stringWithFormat:@"%@年",self.model.years];
    }
    NSArray *imgArr = @[@"30",@"29",@"27",@"26"];
    NSArray *titleArr1 = @[self.model.area,self.model.years,self.model.edu,self.model.jobs];
    for (int i=0; i<titleArr1.count; i++) {
        
        UIButton *okBtn = [UIButton buttonWithframe:CGRectMake(jobLab.left+(23+35)*i, jobLab.bottom+9, 45, 13) text:titleArr1[i] font:[UIFont systemFontOfSize:11] textColor:@"#333333" backgroundColor:nil normal:imgArr[i] selected:nil];
//        okBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
        [headView addSubview:okBtn];
        self.okBtn = okBtn;

        
    }
    
    /*
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
     */
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.okBtn.bottom+6, kScreen_Width, 8)];
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
    [logoView sd_setImageWithURL:[NSURL URLWithString:self.model.logo] placeholderImage:[UIImage imageNamed:@"102"]];
    
    // @"浙江金狮工贸有限公司永康分公司"
    UILabel *companyLab = [UILabel labelWithframe:CGRectMake(logoView.right+7, logoView.top, kScreen_Width-12-(logoView.right+7), 17) text:self.model.company_name font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [headView addSubview:companyLab];
    
    // @"五金机电 150-500人"
    UILabel *decLab = [UILabel labelWithframe:CGRectMake(companyLab.left, companyLab.bottom+5, kScreen_Width-26-(logoView.right+7), 14) text:[NSString stringWithFormat:@"%@ %@",self.model.cate_name, _model.persons] font:[UIFont systemFontOfSize:10] textAlignment:NSTextAlignmentLeft textColor:@"#999999"];
    [headView addSubview:decLab];
    
    UIImageView *jiantouView = [UIImageView imgViewWithframe:CGRectMake(kScreen_Width-14-8, decLab.center.y-7, 8, 17) icon:@"24"];
    [headView addSubview:jiantouView];
    
    
    UILabel *kmLab = [UILabel labelWithframe:CGRectMake(kScreen_Width-32-14, decLab.bottom+5, 32, 14) text:@"5.2km" font:[UIFont systemFontOfSize:10] textAlignment:NSTextAlignmentRight textColor:@"#999999"];
    [headView addSubview:kmLab];
    
    // @"永嘉国贸大厦612室"
    UILabel *addressLab = [UILabel labelWithframe:CGRectMake(companyLab.left, decLab.bottom+5, kmLab.left-(logoView.right+7)-10, 14) text:_model.address font:[UIFont systemFontOfSize:10] textAlignment:NSTextAlignmentLeft textColor:@"#999999"];
    [headView addSubview:addressLab];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(0, logoView.bottom+7, kScreen_Width, 8)];
    view.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
    [headView addSubview:view];
    
    // 职位描述
    UIButton *decBtn = [UIButton buttonWithframe:CGRectMake(logoView.left, view.bottom+9, 82, 17) text:@"职位描述" font:[UIFont systemFontOfSize:14] textColor:@"#333333" backgroundColor:nil normal:@"22" selected:nil];
    decBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [headView addSubview:decBtn];
    
    // @"工艺品包装，需要一年工作经验，永嘉本地人最好，大专以上即可。"
    UILabel *jobDecLab = [UILabel labelWithframe:CGRectMake(decBtn.left, decBtn.bottom+9, kScreen_Width-24, 16) text:self.model.info font:[UIFont systemFontOfSize:10] textAlignment:NSTextAlignmentLeft textColor:@"#999999"];
    [headView addSubview:jobDecLab];
    jobDecLab.numberOfLines = 0;
    
    CGSize size = [NSString textHeight:self.model.info font:jobDecLab.font width:jobDecLab.width];
    jobDecLab.height = size.height;
    
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
    [shareBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];

    
    UIButton *cellctionBtn = [UIButton buttonWithframe:CGRectMake(shareBtn.right, shareBtn.top, 20, 20) text:nil font:nil textColor:nil backgroundColor:nil normal:@"23" selected:@"18"];
    [rightView addSubview:cellctionBtn];
    [cellctionBtn addTarget:self action:@selector(cellctionAction) forControlEvents:UIControlEventTouchUpInside];
    self.cellctionBtn = cellctionBtn;
    
    if (_model.favs.integerValue == 0) {
        cellctionBtn.selected = NO;
    }
    else {
        cellctionBtn.selected = YES;

    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    
    // 底部视图
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreen_Height-64-40, kScreen_Width, 40)];
    [self.view addSubview:bottomView];
    
    UIButton *phoneBtn = [UIButton buttonWithframe:CGRectMake(0, 0, kScreen_Width/2, bottomView.height) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:@"19" selected:nil];
    [bottomView addSubview:phoneBtn];
    [phoneBtn addTarget:self action:@selector(callAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *applyBtn = [UIButton buttonWithframe:CGRectMake(phoneBtn.width, phoneBtn.top, phoneBtn.width, bottomView.height) text:@"申请职位" font:[UIFont systemFontOfSize:14] textColor:@"#FFFFFF" backgroundColor:@"#FF9123" normal:nil selected:nil];
    [bottomView addSubview:applyBtn];
    [applyBtn addTarget:self action:@selector(applyAction) forControlEvents:UIControlEventTouchUpInside];
    applyBtn.userInteractionEnabled = YES;
    self.applyBtn = applyBtn;
    
    if (self.model.resume.integerValue == 1) {
        applyBtn.userInteractionEnabled = NO;
        applyBtn.backgroundColor = [UIColor colorWithHexString:@"EFEFEF"];

    }
}

- (void)shareAction
{
    ShareVC *vc  = [[ShareVC alloc] init];
    vc.modalPresentationStyle=UIModalPresentationOverCurrentContext;
    //淡出淡入
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //  self.definesPresentationContext = YES; //不盖住整个屏幕
    vc.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
    [self presentViewController:vc animated:YES completion:nil];
    vc.clickBlock = ^(NSInteger indexRow) {
        
    };
}

- (void)cellctionAction

{
    PersonModel *model = [InfoCache unarchiveObjectWithFile:Person];
    if (!model) {
        LoginVC *vc = [[LoginVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
        return;
    }
    
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    [paraDic setValue:self.model.ID forKey:@"id"];
    
    if (_model.favs.integerValue == 0) {
//        [paraDic setValue:@"0" forKey:@"del"];
    }
    else {
        [paraDic setValue:@(1) forKey:@"del"];// 取消收藏

    }
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Favs_job dic:paraDic showHUD:YES Succed:^(id responseObject) {
        
        if ([responseObject[@"message"] isEqualToString:@"收藏成功"]) {
            self.cellctionBtn.selected = YES;
            _model.favs = @"1";
        }
        else {
            self.cellctionBtn.selected = NO;
            _model.favs = @"0";

        }
        
        [self.view makeToast:responseObject[@"message"]];

        
    } failure:^(NSError *error) {
        
        
    }];

}

- (void)callAction
{
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",_model.tele];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
    
}

- (void)applyAction
{
    PersonModel *model = [InfoCache unarchiveObjectWithFile:Person];
    if (!model) {
        LoginVC *vc = [[LoginVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
        return;
    }
    
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    [paraDic setValue:@"0" forKey:@"cid"];
    [paraDic setValue:_model.ID forKey:@"id"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Send_resume dic:paraDic showHUD:YES Succed:^(id responseObject) {
        
        self.applyBtn.userInteractionEnabled = NO;
        self.applyBtn.backgroundColor = [UIColor colorWithHexString:@"EFEFEF"];
        
    } failure:^(NSError *error) {
        
        
    }];
}

- (void)inAction
{
    CompanyDetailVC *vc = [[CompanyDetailVC alloc] init];
    vc.title = @"公司详情";
    vc.model = self.model;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArr.count;
//    return 10;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 83;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    JobModel *model = self.modelArr[indexPath.row];
    
    JobDetailVC *vc = [[JobDetailVC alloc] init];
    vc.title = @"职位详情";
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JobDetailCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        
        cell = [[JobDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    cell.model = self.modelArr[indexPath.row];
    return cell;
}


@end
