//
//  EditEducationMsgVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/9.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "EditEducationMsgVC.h"
#import "EditJobMsgCell.h"

@interface EditEducationMsgVC ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>

@property (nonatomic,strong) NSArray *dataArr;
@property(nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *selectArr;
@property (nonatomic,strong) NSArray *selectJobArr;
@property(nonatomic,strong) UILabel *remindLab1;
@property(nonatomic,strong) UITextView *textView;


@end

@implementation EditEducationMsgVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 尾视图
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0)];
    footerView.backgroundColor = [UIColor whiteColor];
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 8)];
    view.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
    [footerView addSubview:view];
    
    UILabel *remindLab = [UILabel labelWithframe:CGRectMake(13, view.bottom+12, 200, 16) text:@"" font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [footerView addSubview:remindLab];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(remindLab.left, remindLab.bottom+12, kScreen_Width-remindLab.left*2, 95)];
    view.layer.cornerRadius = 8;
    view.layer.masksToBounds = YES;
    view.layer.borderColor = [UIColor colorWithHexString:@"#EFEFEF"].CGColor;
    view.layer.borderWidth = 1;
    [footerView addSubview:view];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(8, 0, view.width-8, 72)];
    textView.font = [UIFont systemFontOfSize:12];
    [view addSubview:textView];
    textView.delegate = self;
    self.textView = textView;
    
    UILabel *remindLab1 = [UILabel labelWithframe:CGRectMake(textView.left+4, textView.top+5, view.width-(textView.left+4), 16) text:@"" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
    [view addSubview:remindLab1];
    self.remindLab1 = remindLab1;
    
//    UILabel *countLab = [UILabel labelWithframe:CGRectMake(view.width-100-10, view.height-12-6, 100, 12) text:@"0/500" font:[UIFont systemFontOfSize:10] textAlignment:NSTextAlignmentRight textColor:@"#333333"];
//    [view addSubview:countLab];
    
    footerView.height = view.bottom+17;
    
    if ([self.title isEqualToString:@"求职意向"]) {
        
        if (_model) {
            self.dataArr = @[@[@{@"image":@"68",@"title":@"求职类型",@"text":_model.requestjobtype,@"key":@"requestjobtype"},
                               @{@"image":@"68",@"title":@"岗位类别",@"text":@"",@"key":@"no"}],
                             @[@{@"image":@"67",@"title":@"期望地区",@"text":_model.hopelocation,@"key":@"hopelocation"},
                               @{@"image":@"67",@"title":@"期望职位",@"text":_model.hopepostion,@"key":@"hopepostion"},
                               @{@"image":@"67",@"title":@"待遇要求",@"text":_model.requestsalary,@"key":@"requestsalary"}],
                             @[@{@"image":@"67",@"title":@"住房要求",@"text":_model.requeststay,@"key":@"requeststay"},
                               @{@"image":@"67",@"title":@"到岗状况",@"text":_model.jobstatus,@"key":@"jobstatus"}]
                             ];
        }
        else {
            self.dataArr = @[@[@{@"image":@"68",@"title":@"求职类型",@"text":@"",@"key":@"requestjobtype"},
                               @{@"image":@"68",@"title":@"岗位类别",@"text":@"",@"key":@"no"}],
                             @[@{@"image":@"67",@"title":@"期望地区",@"text":@"",@"key":@"hopelocation"},
                               @{@"image":@"67",@"title":@"期望职位",@"text":@"",@"key":@"hopepostion"},
                               @{@"image":@"67",@"title":@"待遇要求",@"text":@"",@"key":@"requestsalary"}],
                             @[@{@"image":@"67",@"title":@"住房要求",@"text":@"",@"key":@"requeststay"},
                               @{@"image":@"67",@"title":@"到岗状况",@"text":@"",@"key":@"jobstatus"}]
                             ];
        }

        footerView  = [UIView new];
        self.textView = nil;
    }
    else if ([self.title isEqualToString:@"教育经历"]) {
        
        if (_model) {
            self.dataArr = @[@[@{@"image":@"68",@"title":@"学校名称",@"text":_model.graduatedfrom,@"key":@"graduatedfrom"},
                               @{@"image":@"67",@"title":@"专业名称",@"text":_model.speciality,@"key":@"speciality"}],
                             @[@{@"image":@"67",@"title":@"入学时间",@"text":@"",@"key":@"no"},
                               @{@"image":@"67",@"title":@"毕业时间",@"text":_model.graduatetime,@"key":@"graduatetime"}],
                             @[@{@"image":@"67",@"title":@"学历",@"text":_model.education,@"key":@"education"}]
                             ];
            self.textView.text = _model.educationhistory;

        }
        else {
            self.dataArr = @[@[@{@"image":@"68",@"title":@"学校名称",@"text":@"",@"key":@"graduatedfrom"},
                               @{@"image":@"67",@"title":@"专业名称",@"text":@"",@"key":@"speciality"}],
                             @[@{@"image":@"67",@"title":@"入学时间",@"text":@"",@"key":@"no"},
                               @{@"image":@"67",@"title":@"毕业时间",@"text":@"",@"key":@"graduatetime"}],
                             @[@{@"image":@"67",@"title":@"学历",@"text":@"",@"key":@"education"}]
                             ];
            self.textView.text = @"";
        }

        remindLab.text = @"教育培训经历";
        remindLab1.text = @"格式：年 月 至 年 月 学校/培训机构名称 专业/科目名称 获得和中证书";
        

    }else if ([self.title isEqualToString:@"技能特长"]) {
        
        if (_model) {
            self.dataArr = @[@[@{@"image":@"67",@"title":@"第一外语",@"text":_model.foreignlanguage,@"key":@"foreignlanguage"},
                               @{@"image":@"67",@"title":@"外语水平",@"text":_model.foreignlanguagelevel,@"key":@"foreignlanguagelevel"},
                               @{@"image":@"67",@"title":@"计算机水平",@"text":_model.computerlevel,@"key":@"computerlevel"},
                               @{@"image":@"68",@"title":@"相关证书(选填)",@"text":_model.certificate,@"key":@"certificate"},
                               @{@"image":@"68",@"title":@"其他能力(选填)",@"text":_model.otherability,@"key":@"otherability"}]
                             ];

        }
        else {
            self.dataArr = @[@[@{@"image":@"67",@"title":@"第一外语",@"text":@"",@"key":@"foreignlanguage"},
                               @{@"image":@"67",@"title":@"外语水平",@"text":@"",@"key":@"foreignlanguagelevel"},
                               @{@"image":@"67",@"title":@"计算机水平",@"text":@"",@"key":@"computerlevel"},
                               @{@"image":@"68",@"title":@"相关证书(选填)",@"text":@"",@"key":@"certificate"},
                               @{@"image":@"68",@"title":@"其他能力(选填)",@"text":@"",@"key":@"otherability"}]
                             ];
        }

        remindLab.text = @"自我评价";
        remindLab1.text = @"请输入自我评价";
        self.textView.text = _model.selfevaluation;

    }else if ([self.title isEqualToString:@"联系方式"]) {
        
        self.dataArr = @[@[@{@"image":@"68",@"title":@"手机",@"text":_model.phone,@"key":@"phone"},
                           @{@"image":@"67",@"title":@"电话(选填)",@"text":_model.tele,@"key":@"tele"}],
                         @[@{@"image":@"67",@"title":@"QQ号码(选填)",@"text":_model.qq,@"key":@"qq"},
                           @{@"image":@"67",@"title":@"邮箱(选填)",@"text":_model.email,@"key":@"email"}],
                         @[@{@"image":@"67",@"title":@"联系地址",@"text":_model.address,@"key":@"address"}]
                         ];

        footerView  = [UIView new];
        self.textView = nil;

        
    }else if ([self.title isEqualToString:@"编辑工作经历"]) {
        
        if (_model) {
            self.dataArr = @[@[@{@"image":@"68",@"title":@"公司名称",@"text":_model.company_name,@"key":@"company_name"},
                               @{@"image":@"67",@"title":@"职位",@"text":_model.position,@"key":@"position"}],
                             @[@{@"image":@"67",@"title":@"入职时间",@"text":_model.begin_time,@"key":@"begin_time"},
                               @{@"image":@"67",@"title":@"离职时间",@"text":_model.end_time,@"key":@"end_time"}],
                             @[@{@"image":@"67",@"title":@"工作经验",@"text":@"",@"key":@"no"},
                               @{@"image":@"67",@"title":@"公司性质",@"text":_model.company_nature,@"key":@"company_nature"}]
                             ];
            self.textView.text = _model.skill;
        }
        else {
            self.dataArr = @[@[@{@"image":@"68",@"title":@"公司名称",@"text":@"",@"key":@"company_name"},
                               @{@"image":@"67",@"title":@"职位",@"text":@"",@"key":@"position"}],
                             @[@{@"image":@"67",@"title":@"入职时间",@"text":@"",@"key":@"begin_time"},
                               @{@"image":@"67",@"title":@"离职时间",@"text":@"",@"key":@"end_time"}],
                             @[@{@"image":@"67",@"title":@"工作经验",@"text":@"",@"key":@"no"},
                               @{@"image":@"67",@"title":@"公司性质",@"text":@"",@"key":@"company_nature"}]
                             ];
            self.textView.text = @"";
        }

        remindLab.text = @"工作描述";
        remindLab1.text = @"你的工作职责，具体负责的事情";
        


    } else if ([self.title isEqualToString:@"增加订阅"]) {
        
        if (_model) {
            
            self.dataArr = @[@[@{@"image":@"68",@"title":@"关键词",@"text":_model.key,@"key":@"key"}],
                             @[@{@"image":@"67",@"title":@"期望地区",@"text":_model.area,@"key":@"area"},
                               @{@"image":@"67",@"title":@"工作经验",@"text":[NSString stringWithFormat:@"%@年",_model.years],@"key":@"years"},
                               @{@"image":@"67",@"title":@"学历",@"text":_model.edu,@"key":@"edu"}]
                             ];
            
        }
        else {
            self.dataArr = @[@[@{@"image":@"68",@"title":@"关键词",@"text":@"",@"key":@"key"}],
                             @[@{@"image":@"67",@"title":@"期望地区",@"text":@"",@"key":@"area"},
                               @{@"image":@"67",@"title":@"工作经验",@"text":@"",@"key":@"years"},
                               @{@"image":@"67",@"title":@"学历",@"text":@"",@"key":@"edu"}]
                             ];
        }
        
        footerView  = [UIView new];
        self.textView = nil;
        
    }
    
    if (self.textView.text.length > 0) {
        remindLab1.hidden = YES;
    }

    
    NSMutableArray *arrM = [NSMutableArray array];
    for (NSArray *arr in self.dataArr) {
        
        NSMutableArray *arrM1 = [NSMutableArray array];
        
        for (NSDictionary *dic in arr) {
            
            PersonModel *model = [PersonModel yy_modelWithJSON:dic];
            [arrM1 addObject:model];
        }
        
        [arrM addObject:arrM1];
        
    }
    
    self.dataArr = arrM;

    
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = footerView;
    
    UIButton *saveBtn = [UIButton buttonWithframe:CGRectMake(0, 0, 30, 17) text:@"保存" font:[UIFont systemFontOfSize:14] textColor:@"#333333" backgroundColor:nil normal:nil selected:nil];
    [saveBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    //    self.cancelBtn = saveBtn;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    
    // 选择项数据
    NSArray *selectArr = [InfoCache unarchiveObjectWithFile:SelectItem];;
    self.selectArr = selectArr;
    
    NSArray *selectJobArr = [InfoCache unarchiveObjectWithFile:SelectItemJob];;
    self.selectJobArr = selectJobArr;
    
}

- (void)saveAction
{
    [self.view endEditing:YES];
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    
    NSString *urlStr = nil;
    
    if ([self.title isEqualToString:@"求职意向"]) {
        urlStr = Update_hope_info;

    }
    else if ([self.title isEqualToString:@"教育经历"]) {
        
        urlStr = Update_educate_info;


    }else if ([self.title isEqualToString:@"技能特长"]) {
        urlStr = Update_skill_info;

    }else if ([self.title isEqualToString:@"联系方式"]) {
        urlStr = Update_contact_info;

        
    }else if ([self.title isEqualToString:@"编辑工作经历"]) {
        
        if (_model) {
            urlStr = Update_jobhistory_info;
            [paramDic  setValue:@(_index+1) forKey:@"orderNum"];

        }
        else {
            urlStr = Add_jobhistory_info;

        }

    } else if ([self.title isEqualToString:@"增加订阅"]) {
        
        if (_model) {
            urlStr = Udpate_ordered_jobs;
            [paramDic setValue:_model.ID forKey:@"id"];
            [paramDic setValue:@"update" forKey:@"act"];
            
        }
        else {
            urlStr = Add_ordered_jobs;
            
        }
    }
    
    for (NSArray *arr in self.dataArr) {
        
        for (PersonModel *model in arr) {

            if (!([model.title isEqualToString:@"电话(选填)"]||
                  [model.title isEqualToString:@"QQ号码(选填)"]||
                  [model.title isEqualToString:@"邮箱(选填)"]||
                  [model.title isEqualToString:@"相关证书(选填)"]||
                  [model.title isEqualToString:@"其他能力(选填)"])) {
                
                if (model.text.length == 0 || (self.textView && self.textView.text.length == 0)) {
                    [self.view makeToast:@"您还有必填项未填写"];
                    return;
                }
            }
            
            if (model.text.length > 0) {
                [paramDic  setValue:model.text forKey:model.key];
                
            }
            
        }
        
    }
    
    NSLog(@"%@",paramDic);
    
    // 个人评价
    [paramDic  setValue:self.textView.text forKey:@"selfevaluation"];
    
    // 教育经历
    [paramDic  setValue:self.textView.text forKey:@"educationhistory"];
    
    // 工作内容
    [paramDic  setValue:self.textView.text forKey:@"skill"];

    
    [AFNetworking_RequestData requestMethodPOSTUrl:urlStr dic:paramDic showHUD:YES Succed:^(id responseObject) {
        

        NSNumber *code = [responseObject objectForKey:@"status"];
        if (1 == [code integerValue]) {
            
            if (self.block) {
                self.block();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        
    } failure:^(NSError *error) {
        
    }];
}


//// 返回用户表该用户相关信息
//- (void)get_user_info
//{
//    
//    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
//    
//    [AFNetworking_RequestData requestMethodPOSTUrl:Get_user_info dic:paramDic showHUD:YES Succed:^(id responseObject) {
//        
//        PersonModel *model = [PersonModel yy_modelWithJSON:responseObject[@"data"]];
//        [InfoCache archiveObject:model toFile:Person];
//        
//        
//    } failure:^(NSError *error) {
//        
//    }];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataArr count];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArr[section] count];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 10;
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 10)];
    view.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
    return view;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EditJobMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[EditJobMsgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    PersonModel *model = self.dataArr[indexPath.section][indexPath.row];
    cell.model = model;
    cell.selectArr = _selectArr;
    cell.selectJobArr = _selectJobArr;
    return cell;
}

/**
 内容将要发生改变编辑 限制输入文本长度 监听TextView 点击了ReturnKey 按钮

 @param textView textView
 @param range    范围
 @param text     text

 @return BOOL
 */
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.location < 500)
    {
        return  YES;

    } else  if ([textView.text isEqualToString:@"\n"]) {

        //这里写按了ReturnKey 按钮后的代码
        return NO;
    }

    if (textView.text.length == 500) {

        return NO;
    }

    return YES;

}


/**
 内容发生改变编辑 自定义文本框placeholder
 有时候我们要控件自适应输入的文本的内容的高度，只要在textViewDidChange的代理方法中加入调整控件大小的代理即可
 @param textView textView
 */
- (void)textViewDidChange:(UITextView *)textView
{

    if (textView.text.length < 1) {
        self.remindLab1.hidden = NO;
    }
    else {
        self.remindLab1.hidden = YES;

    }
//    count.text = [NSString stringWithFormat:@"%lu/100", textView.text.length  ];
}

@end
