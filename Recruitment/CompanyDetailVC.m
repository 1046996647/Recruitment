//
//  CompanyDetailVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/8.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "CompanyDetailVC.h"
#import "JobDetailCell.h"
#import "JobDetailVC.h"
#import "ShareVC.h"
#import "NTESSessionViewController.h"
#import "LoginVC.h"


@interface CompanyDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *modelArr;
@property(nonatomic,strong) UIButton *cellctionBtn;
@property(nonatomic,strong) NSString *companyId;


@end

@implementation CompanyDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self get_company_detail];
    
    self.companyId = self.model.companyId;
}

// 3.1	公司详情
- (void)get_company_detail
{
    
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    
    [paraDic setValue:self.model.companyId forKey:@"companyId"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Get_company_detail dic:paraDic showHUD:YES Succed:^(id responseObject) {
        
        JobModel *model = [JobModel yy_modelWithJSON:responseObject[@"data"]];
        self.model = model;
        
        NSArray *arr = responseObject[@"jobs"];
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
    
    // 公司
    UIButton *inBtn = [UIButton buttonWithframe:CGRectMake(0, 0, kScreen_Width, 70) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:nil selected:nil];
    [headView addSubview:inBtn];
    //    [inBtn addTarget:self action:@selector(inAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *logoView = [UIImageView imgViewWithframe:CGRectMake(14, 7, 55, 55) icon:@"102"];
    [headView addSubview:logoView];
    logoView.layer.cornerRadius = 9;
    logoView.layer.masksToBounds = YES;
    [logoView sd_setImageWithURL:[NSURL URLWithString:self.model.logo] placeholderImage:[UIImage imageNamed:@"102"]];

    
    // @"浙江金狮工贸有限公司永康分公司"
    UILabel *companyLab = [UILabel labelWithframe:CGRectMake(logoView.right+7, logoView.top, kScreen_Width-12-(logoView.right+7), 17) text:self.model.company_name font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [headView addSubview:companyLab];
    
    // @"五金机电"
    UILabel *decLab = [UILabel labelWithframe:CGRectMake(companyLab.left, companyLab.bottom+5, kScreen_Width-26-(logoView.right+7), 14) text:self.model.cate_name font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#999999"];
    [headView addSubview:decLab];
    
    // @"150人"
    UILabel *addressLab = [UILabel labelWithframe:CGRectMake(companyLab.left, decLab.bottom+5, 100, 14) text:_model.persons font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#999999"];
    [headView addSubview:addressLab];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, logoView.bottom+7, kScreen_Width, 8)];
    view.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
    [headView addSubview:view];
    
    // 性质和网址
    UILabel *typeLab = [UILabel labelWithframe:CGRectMake(logoView.left, view.bottom+6, 100, 14) text:@"公司性质" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [headView addSubview:typeLab];
    
    // @"民营"
    UILabel *typeLab1 = [UILabel labelWithframe:CGRectMake(typeLab.left, typeLab.bottom+6, 100, 17) text:_model.type font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [headView addSubview:typeLab1];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(kScreen_Width/2-1, view.bottom+9, 1, 30)];
    line.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
    [headView addSubview:line];
    
    UILabel *webLab = [UILabel labelWithframe:CGRectMake(line.right+14, typeLab.top, 100, 14) text:@"公司网址" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [headView addSubview:webLab];
    
    // 网址
    UILabel *webLab1 = [UILabel labelWithframe:CGRectMake(webLab.left, typeLab1.top, 100, 17) text:_model.web font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#FF9123"];
    [headView addSubview:webLab1];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(0, webLab1.bottom+5, kScreen_Width, 8)];
    view.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
    [headView addSubview:view];
    
    // 公司地址
    UIButton *decBtn = [UIButton buttonWithframe:CGRectMake(logoView.left, view.bottom+9, 82, 17) text:@"公司地址" font:[UIFont systemFontOfSize:14] textColor:@"#333333" backgroundColor:nil normal:@"Shape" selected:nil];
    decBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [headView addSubview:decBtn];
    
    // @"浙江省永嘉市网生路2号"
    UILabel *jobDecLab = [UILabel labelWithframe:CGRectMake(decBtn.left, decBtn.bottom+9, kScreen_Width-24, 16) text:_model.address font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#999999"];
    [headView addSubview:jobDecLab];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(0, jobDecLab.bottom+7, kScreen_Width, 8)];
    view.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
    [headView addSubview:view];
    
    // 联系电话
    UIButton *phoneBtn = [UIButton buttonWithframe:CGRectMake(logoView.left, view.bottom+9, 82, 17) text:@"联系人    " font:[UIFont systemFontOfSize:14] textColor:@"#333333" backgroundColor:nil normal:@"19" selected:nil];
    phoneBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [headView addSubview:phoneBtn];
    
    UIButton *phoneBtn1 = [UIButton buttonWithframe:CGRectMake(0, phoneBtn.top, kScreen_Width, 60) text:nil font:nil textColor:nil backgroundColor:@"" normal:nil selected:nil];
    [headView addSubview:phoneBtn1];
    [phoneBtn1 addTarget:self action:@selector(callAction) forControlEvents:UIControlEventTouchUpInside];
    
//    self.model.tele = @"17736273234";
    if (!self.model.tele) {
        self.model.tele = @"";
    }
    if (!self.model.contactName) {
        self.model.contactName = @"";
    }
    UILabel *phoneLab = [UILabel labelWithframe:CGRectMake(decBtn.left, phoneBtn.bottom+9, kScreen_Width-24, 16) text:[NSString stringWithFormat:@"%@ %@",self.model.contactName, self.model.tele] font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#999999"];
    [headView addSubview:phoneLab];
    
    
    UIImageView *jiantouView = [UIImageView imgViewWithframe:CGRectMake(kScreen_Width-14-8, phoneBtn.top+15, 8, 17) icon:@"24"];
    [headView addSubview:jiantouView];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(0, phoneLab.bottom+7, kScreen_Width, 8)];
    view.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
    [headView addSubview:view];
    
    // 公司介绍
    UIButton *sameBtn = [UIButton buttonWithframe:CGRectMake(jobDecLab.left, view.bottom+9, 82, 17) text:@"公司介绍" font:[UIFont systemFontOfSize:14] textColor:@"#333333" backgroundColor:nil normal:@"21" selected:nil];
    sameBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [headView addSubview:sameBtn];
    
    // @"提供长期稳定的就业环境，不断提高员工的薪资水平。"
//    UILabel *companyDecLab = [UILabel labelWithframe:CGRectMake(sameBtn.left, sameBtn.bottom+9, kScreen_Width-24, 16) text:_model.info font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#999999"];
//    [headView addSubview:companyDecLab];
//    companyDecLab.numberOfLines = 0;
//
//    // 计算高度
//    CGSize size = [NSString textHeight:_model.info font:companyDecLab.font width:companyDecLab.width];
//
//    companyDecLab.height = size.height;
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(sameBtn.left, sameBtn.bottom+9, kScreen_Width-24, 200)];
    textView.font = [UIFont systemFontOfSize:14];
    textView.textColor = colorWithHexStr(@"#999999");
    [headView addSubview:textView];
//    self.textView = textView;
    textView.editable = NO;
    textView.text = _model.info;
    
    view = [[UIView alloc] initWithFrame:CGRectMake(0, textView.bottom+9, kScreen_Width, 8)];
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
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.tableHeaderView = headView;
    
    // 右上角按钮
    UIButton *cellctionBtn = [UIButton buttonWithframe:CGRectMake(0, 0, 20, 20) text:nil font:nil textColor:nil backgroundColor:nil normal:@"23" selected:@"18"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cellctionBtn];
    self.cellctionBtn = cellctionBtn;
    [cellctionBtn addTarget:self action:@selector(cellctionAction) forControlEvents:UIControlEventTouchUpInside];

    
    if (_model.favs.integerValue == 0) {
        cellctionBtn.selected = NO;
    }
    else {
        cellctionBtn.selected = YES;
        
    }
    
    // 底部视图
//    UIButton *sahreBtn = [UIButton buttonWithframe:CGRectMake(0, kScreen_Height-64-40, kScreen_Width, 40) text:@"分享" font:[UIFont systemFontOfSize:14] textColor:@"#FFFFFF" backgroundColor:@"#FF9123" normal:@"Group 7" selected:nil];
//    sahreBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
//    [self.view addSubview:sahreBtn];
//    [sahreBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.compChatId) {
        
        _tableView.height = kScreen_Height-64-40;
        
        UIButton *chatBtn = [UIButton buttonWithframe:CGRectMake(0, kScreen_Height-64-40, kScreen_Width, 40) text:@"和他聊天" font:[UIFont systemFontOfSize:14] textColor:@"#ffffff" backgroundColor:@"#FF9123" normal:@"chat" selected:nil];
        chatBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        chatBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
        [self.view addSubview:chatBtn];
        [chatBtn addTarget:self action:@selector(chatAction) forControlEvents:UIControlEventTouchUpInside];
    }


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
    [paraDic setValue:self.companyId forKey:@"companyId"];
    
    if (_model.favs.integerValue == 0) {
        //        [paraDic setValue:@"0" forKey:@"del"];
    }
    else {
        [paraDic setValue:@(1) forKey:@"del"];// 取消收藏
        
    }
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Company_concern dic:paraDic showHUD:YES Succed:^(id responseObject) {
        
        if ([responseObject[@"message"] isEqualToString:@"关注成功"]) {
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
    if (self.model.tele) {
        //    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",_model.tele];
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.model.tele];
        UIWebView *callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
    }

    
}

- (void)chatAction
{
    PersonModel *person = [InfoCache unarchiveObjectWithFile:Person];
    if (!person) {
        LoginVC *vc = [[LoginVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
        return;
    }
    
    //构造会话
    NIMSession *session = [NIMSession session:self.compChatId type:NIMSessionTypeP2P];
    NTESSessionViewController *sessionVC = [[NTESSessionViewController alloc] initWithSession:session];
    [self.navigationController pushViewController:sessionVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
