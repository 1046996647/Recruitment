//
//  EditJobMsgVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/9.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "EditJobMsgVC.h"
#import "EditJobMsgCell.h"

@interface EditJobMsgVC ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>

@property (nonatomic,strong) NSArray *dataArr;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UILabel *remindLab1;
@property (nonatomic,strong) NSArray *selectArr;


@end

@implementation EditJobMsgVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 40)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *leftLab = [UILabel labelWithframe:CGRectMake(14, (headerView.height-16)/2, 100, 16) text:@"登录账号" font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [headerView addSubview:leftLab];
    
    UILabel *rightLab = [UILabel labelWithframe:CGRectMake(kScreen_Width-100-12, (headerView.height-16)/2, 100, 16) text:self.model.phone font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentRight textColor:@"#333333"];
    [headerView addSubview:rightLab];
    
    if ([self.title isEqualToString:@"基本信息"]) {
//        remindLab.text = @"自我描述（至少十字以上）";
//        remindLab1.text = @"一句话介绍自己,告诉HR为什么选择你而不是别人。";
        self.dataArr = @[@[@{@"image":@"68",@"title":@"E-mail",@"text":_model.email,@"key":@"email"},
                           @{@"image":@"68",@"title":@"姓名",@"text":_model.name,@"key":@"name"},
                           @{@"image":@"67",@"title":@"性别",@"text":_model.sex,@"key":@"sex"},
                           @{@"image":@"67",@"title":@"人才类型",@"text":_model.type,@"key":@"type"},
                           @{@"image":@"68",@"title":@"身高(选填)",@"text":_model.height,@"key":@"height"},
                           @{@"image":@"67",@"title":@"民族",@"text":_model.nation,@"key":@"nation"}],
                         @[@{@"image":@"67",@"title":@"生日",@"text":_model.birth,@"key":@"birth"},
                           @{@"image":@"68",@"title":@"籍贯",@"text":_model.jiguan,@"key":@"jiguan"},
                           @{@"image":@"67",@"title":@"婚姻状况",@"text":_model.marry,@"key":@"marry"}],
                         @[@{@"image":@"67",@"title":@"证件类型(选填)",@"text":@"",@"key":@"cred"},
                           @{@"image":@"68",@"title":@"证件号码(选填)",@"text":@"",@"key":@"credid"}],
                         @[@{@"image":@"67",@"title":@"政治面貌(选填)",@"text":_model.political,@"key":@"political"},
                           @{@"image":@"67",@"title":@"体重(选填)",@"text":_model.weight,@"key":@"weight"},
                           @{@"image":@"68",@"title":@"所在地",@"text":_model.home,@"key":@"home"}]
                         ];
    }
//    else {
//        
////        remindLab.text = @"工作内容（至少十字以上）";
////        remindLab1.text = @"你的工作职责，具体负责的事情";
//        
//        self.dataArr = @[@[@{@"image":@"68",@"title":@"公司名称"},
//                           @{@"image":@"68",@"title":@"职位名称"}],
//                         @[@{@"image":@"67",@"title":@"入职时间"},
//                           @{@"image":@"67",@"title":@"离职时间"}]
//                         ];
//    }

    
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
    
//    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64)];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64) style:UITableViewStyleGrouped];
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.tableHeaderView = headerView;
    
    UIButton *saveBtn = [UIButton buttonWithframe:CGRectMake(0, 0, 30, 17) text:@"保存" font:[UIFont systemFontOfSize:14] textColor:@"#333333" backgroundColor:nil normal:nil selected:nil];
    [saveBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
//    self.saveBtn = saveBtn;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    
    // 选择项数据
    NSArray *selectArr = [InfoCache unarchiveObjectWithFile:SelectItem];;
    self.selectArr = selectArr;
    
}

- (void)saveAction
{
    [self.view endEditing:YES];
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    
    for (NSArray *arr in self.dataArr) {
        
        for (PersonModel *model in arr) {
            
            if (!([model.title isEqualToString:@"身高(选填)"]||
                [model.title isEqualToString:@"证件类型(选填)"]||
                [model.title isEqualToString:@"证件号码(选填)"]||
                [model.title isEqualToString:@"政治面貌(选填)"]||
                [model.title isEqualToString:@"体重(选填)"])) {
                
                if (model.text.length == 0) {
                    [self.view makeToast:@"您还有必填项未填写"];
                    return;
                }
            }

//            model.text = @"1";
            
            if (model.text.length > 0) {
                [paramDic  setValue:model.text forKey:model.key];

            }
            
        }
        
    }
    
    NSLog(@"%@",paramDic);
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Update_basic_info dic:paramDic showHUD:YES Succed:^(id responseObject) {
        
//        [self get_user_info];
        [self.navigationController popViewControllerAnimated:YES];

        
    } failure:^(NSError *error) {
        
    }];
}
//
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
    if (section == 0) {
        return .5;// 为0无效

    }
    return 10;

}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00001;// 为0无效

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EditJobMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[EditJobMsgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    PersonModel *model = self.dataArr[indexPath.section][indexPath.row];
    cell.model = model;
    cell.selectArr = _selectArr;

    return cell;
}






@end
