//
//  PersonalCenterVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/6.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "PersonalCenterVC.h"
#import "PersonalCell.h"
#import "LoginVC.h"
#import "MyCollectionVC.h"
#import "OpinionVC.h"
#import "SettingVC.h"
#import "SubscriptionManageVC.h"
#import "UIImage+UIImageExt.h"
#import "MyAttentionVC.h"
#import "MyMailboxVC.h"


@interface PersonalCenterVC ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataArr;
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UIButton *userBtn;
@property (nonatomic,assign) BOOL isNew;
@property (nonatomic,assign) NSInteger number;


@end

@implementation PersonalCenterVC

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UIButton *btn = [UIButton buttonWithframe:CGRectMake(0, 0, kScreen_Width, 90) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:nil selected:nil];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];

    UIButton *userBtn = [UIButton buttonWithframe:CGRectMake(9, 9, 72, 72) text:nil font:nil textColor:nil backgroundColor:nil normal:@"96" selected:nil];
    [userBtn addTarget:self action:@selector(headImgAction) forControlEvents:UIControlEventTouchUpInside];
    userBtn.layer.cornerRadius = userBtn.height/2;
    userBtn.layer.masksToBounds = YES;
    self.userBtn = userBtn;


    
    UILabel *label = [UILabel labelWithframe:CGRectMake(userBtn.right+12, (btn.height-18)/2, 100, 18) text:@"登录/注册" font:[UIFont systemFontOfSize:17] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    self.label = label;
    
    [btn addSubview:userBtn];
    [btn addSubview:label];
    
    self.dataArr = @[@[@{@"image":@"23",@"title":@"我的收藏"}
                       ,@{@"image":@"109",@"title":@"我的关注"}
                       ],
                     @[@{@"image":@"108",@"title":@"订阅管理"}
//                       ,@{@"image":@"107",@"title":@"薪资测评"}
                       ],
                     @[@{@"image":@"106",@"title":@"联系客服"},
                       @{@"image":@"105",@"title":@"意见反馈"},
                       @{@"image":@"信封",@"title":@"我的信箱"}
                       ],
                     @[@{@"image":@"104",@"title":@"设置"}
                       ]
                     ];
    
    
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64-49)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.tableHeaderView = btn;
    
    self.isNew = YES;

    // 我的信箱通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(is_new) name:@"KInterviewNotification" object:nil];
}


- (void)is_new
{
    
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Is_new dic:paraDic showHUD:NO Succed:^(id responseObject) {
        
        //        {
        //            countInvite = 12;
        //            countMess = 7;
        //            message = "";
        //            status = 1;
        //        }
        NSNumber *countInvite = [responseObject objectForKey:@"countInvite"];
        NSNumber *countMess = [responseObject objectForKey:@"countMess"];
        
        self.number = countMess.integerValue;
        [_tableView reloadData];
        
        
    } failure:^(NSError *error) {
        
        
    }];
}


- (void)btnAction:(UIButton *)btn
{
    PersonModel *model = [InfoCache unarchiveObjectWithFile:Person];
    if (!model) {
        LoginVC *vc = [[LoginVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }

}

- (void)headImgAction
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"相册选择" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        // 创建相册控制器
        UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
        
        // 设置代理对象
        pickerController.delegate = self;
        // 设置选择后的图片可以被编辑
        //            pickerController.allowsEditing=YES;
        // 设置类型
        pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 设置为静态图像类型
        pickerController.mediaTypes = @[@"public.image"];
        // 跳转到相册页面
        [self presentViewController:pickerController animated:YES completion:nil];
        
    }];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"手机拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        // 创建相册控制器
        UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
        
        // 设置代理对象
        pickerController.delegate = self;
        // 设置选择后的图片可以被编辑
        //            pickerController.allowsEditing=YES;
    
        // 判断当前设备是否有摄像头
        if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear] || [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
            
            // 设置类型
            pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            
        }
        
        // 跳转页面，该行代码必须放最后
        [self presentViewController:pickerController animated:YES completion:nil];
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:albumAction];
    [alertController addAction:cameraAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    PersonModel *person = [InfoCache unarchiveObjectWithFile:Person];

    if (person) {
        
        self.label.text = person.name;
        if (person.name.length == 0) {
            self.label.text = @"姓名";
        }
        
        [self.userBtn sd_setImageWithURL:[NSURL URLWithString:person.img] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"96"]];
        self.userBtn.userInteractionEnabled = YES;
    }
    else {
        self.userBtn.userInteractionEnabled = NO;
        [self.userBtn setImage:[UIImage imageNamed:@"96"] forState:UIControlStateNormal];
        self.label.text = @"登录/注册";
    }
    
    [self is_new];

}

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
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PersonModel *model = [InfoCache unarchiveObjectWithFile:Person];
    if (!model) {
        LoginVC *vc = [[LoginVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
        return;
    }
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            MyCollectionVC *vc = [[MyCollectionVC alloc] init];
            vc.title = @"我的收藏";
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        if (indexPath.row == 1) {
            
            MyAttentionVC *vc = [[MyAttentionVC alloc] init];
            vc.title = @"我的关注";
            [self.navigationController pushViewController:vc animated:YES];
            
        }
    }
    if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            SubscriptionManageVC *vc = [[SubscriptionManageVC alloc] init];
            vc.title = @"订阅管理";
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        if (indexPath.row == 1) {
            
        }
    }
    if (indexPath.section == 2) {
        
        if (indexPath.row == 0) {
            
            [self callAction];
            
        }
        if (indexPath.row == 1) {
            
            OpinionVC *vc = [[OpinionVC alloc] init];
            vc.title = @"意见反馈";
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        if (indexPath.row == 2) {
            
            MyMailboxVC *vc = [[MyMailboxVC alloc] init];
            vc.title = @"我的信箱";
            [self.navigationController pushViewController:vc animated:YES];
            
        }
    }
    if (indexPath.section == 3) {
        
        if (indexPath.row == 0) {
            
            SettingVC *vc = [[SettingVC alloc] init];
            vc.title = @"设置";
            [self.navigationController pushViewController:vc animated:YES];
            
        }
  
    }
    
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
    
    PersonalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[PersonalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary *dic = self.dataArr[indexPath.section][indexPath.row];
    cell.imgView.image = [UIImage imageNamed:dic[@"image"]];
    cell.label.text = dic[@"title"];
    
    if (indexPath.section == 2 && indexPath.row == 2) {
        if (self.number > 0) {
            cell.redDot.hidden = NO;
            cell.redDot.text = [NSString stringWithFormat:@"%ld",self.number];
        }
        else {
            cell.redDot.hidden = YES;
            
        }
    }
    else {
        cell.redDot.hidden = YES;
        
    }
    
    return cell;
}

#pragma mark - UIImagePickerControllerDelegate

//选取后调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"info:%@",info[UIImagePickerControllerOriginalImage]);
    UIImage *img = info[UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //通过判断picker的sourceType，如果是拍照则保存到相册去
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    NSData *data = [UIImage imageOrientation:img];
    
    [AFNetworking_RequestData uploadImageUrl:Upload_user_img dic:paramDic data:data Succed:^(id responseObject) {
        
        [self.userBtn sd_setImageWithURL:[NSURL URLWithString:responseObject[@"img"]] forState:UIControlStateNormal];
        
        [self get_ui_info];
        
    } failure:^(NSError *error) {
        
    }];
    
    
}

//取消后调用
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//此方法就在UIImageWriteToSavedPhotosAlbum的上方
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSLog(@"已保存");
}

// 获取部分用户信息
- (void)get_ui_info
{
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Get_ui_info dic:paramDic showHUD:YES Succed:^(id responseObject) {
        
        PersonModel *model = [PersonModel yy_modelWithJSON:responseObject[@"data"]];
        [InfoCache archiveObject:model toFile:Person];

    } failure:^(NSError *error) {
        
    }];
}

- (void)callAction
{
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"0579-83830000"];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
    
}


@end
