//
//  LoginVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/6.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "LoginVC.h"
#import "RegisterVC.h"
#import "AppDelegate.h"
#import "RegexTool.h"


@interface LoginVC ()

@property(nonatomic,strong) UITextField *phone;
@property(nonatomic,strong) UITextField *password;


@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGFloat screenHeight = 0;
    CGFloat statusBar = 0;

    if (Device_Is_iPhoneX) {
        screenHeight  = kScreen_Height+24;
        statusBar  = 44;
    }
    else {
        screenHeight  = kScreen_Height;
        statusBar  = 20;

    }
    
    UIImageView *imgView = [UIImageView imgViewWithframe:CGRectMake(0, 0, kScreen_Width, screenHeight) icon:@"110"];
    [self.view addSubview:imgView];
    
    UIButton *backBtn = [UIButton buttonWithframe:CGRectMake(20, statusBar+(44-30)/2, 30, 20) text:nil font:nil textColor:nil backgroundColor:nil normal:@"11" selected:nil];
    [self.view addSubview:backBtn];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];

    
    UILabel *label = [UILabel labelWithframe:CGRectMake((kScreen_Width-200)/2, backBtn.bottom-15, 200, 18) text:@"登录" font:[UIFont boldSystemFontOfSize:17] textAlignment:NSTextAlignmentCenter textColor:@"#000000"];
    [self.view addSubview:label];
    

    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45+10, 45)];
    UIView *leftView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
    leftView1.backgroundColor = [UIColor colorWithHexString:@"#FDA326"];

    UIImageView *imgView1 = [UIImageView imgViewWithframe:CGRectMake(0, 0, 45, 17) icon:@"13"];
    imgView1.contentMode = UIViewContentModeScaleAspectFit;
    imgView1.center = leftView1.center;

    [leftView1 addSubview:imgView1];
    [leftView addSubview:leftView1];
    
    _phone = [UITextField textFieldWithframe:CGRectMake(25, label.bottom+41, kScreen_Width-50, 45) placeholder:@"请输入手机号" font:nil leftView:leftView backgroundColor:@"#FFFFFF"];
    _phone.keyboardType = UIKeyboardTypeNumberPad;
    _phone.layer.cornerRadius = 7;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    _phone.layer.masksToBounds = YES;
    [self.view addSubview:_phone];
    
    _phone.text = [InfoCache unarchiveObjectWithFile:@"userid"];

    
    leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45+10, 45)];
    leftView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
    leftView1.backgroundColor = [UIColor colorWithHexString:@"#FDA326"];
    
    UIImageView *imgView2 = [UIImageView imgViewWithframe:CGRectMake(0, 0, 45, 17) icon:@"12"];
    imgView2.contentMode = UIViewContentModeScaleAspectFit;
    imgView2.center = leftView1.center;

    [leftView1 addSubview:imgView2];
    [leftView addSubview:leftView1];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12+13, _phone.height)];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = rightView.bounds;
//    rightBtn.center = rightView.center;
    [rightBtn setImage:[UIImage imageNamed:@"9"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"14"] forState:UIControlStateSelected];
    [rightView addSubview:rightBtn];
    [rightBtn addTarget:self action:@selector(viewAction:) forControlEvents:UIControlEventTouchUpInside];

    
    _password = [UITextField textFieldWithframe:CGRectMake(_phone.left, _phone.bottom+10, _phone.width, _phone.height) placeholder:@"请输入密码" font:nil leftView:leftView backgroundColor:@"#FFFFFF"];
    _password.layer.cornerRadius = 7;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    _password.layer.masksToBounds = YES;
    [self.view addSubview:_password];
    _password.rightViewMode = UITextFieldViewModeAlways;
    _password.rightView = rightView;
    _password.secureTextEntry = YES;
    
    UIButton *loginBtn = [UIButton buttonWithframe:CGRectMake(_password.left, _password.bottom+23, _phone.width, _phone.height) text:@"登录" font:[UIFont systemFontOfSize:16] textColor:@"FFFFFF" backgroundColor:@"#FDA326" normal:nil selected:nil];
    loginBtn.layer.cornerRadius = 7;
    loginBtn.layer.masksToBounds = YES;
    [self.view addSubview:loginBtn];
    [loginBtn addTarget:self action:@selector(loginAction1) forControlEvents:UIControlEventTouchUpInside];

    
    UIButton *registerBtn = [UIButton buttonWithframe:CGRectMake(loginBtn.left+5, loginBtn.bottom+16, 50, 14) text:@"立即注册" font:[UIFont systemFontOfSize:12] textColor:@"FFFFFF" backgroundColor:nil normal:nil selected:nil];
    [self.view addSubview:registerBtn];
    [registerBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];

    UIButton *forgetBtn = [UIButton buttonWithframe:CGRectMake(loginBtn.right-registerBtn.width-5, registerBtn.top, registerBtn.width, registerBtn.height) text:@"忘记密码" font:[UIFont systemFontOfSize:12] textColor:@"FFFFFF" backgroundColor:nil normal:nil selected:nil];
    [self.view addSubview:forgetBtn];
    [forgetBtn addTarget:self action:@selector(forgetAction) forControlEvents:UIControlEventTouchUpInside];
    
    // 登录通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifLoginAction:) name:@"kLoginNotification" object:nil];

}

- (void)viewAction:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected) {
        _password.secureTextEntry = NO;
    }
    else {
        _password.secureTextEntry = YES;
        
    }
}

// 通知动作
- (void)notifLoginAction:(NSNotification *)notification
{
    self.phone.text = [InfoCache unarchiveObjectWithFile:@"userid"];
    self.password.text = [InfoCache unarchiveObjectWithFile:@"password"];
    
    [self loginAction:notification];
}

- (void)loginAction1
{
    [self loginAction:nil];

}

- (void)loginAction:(NSNotification *)notification
{
    
    [self.view endEditing:YES];
    
//    if (![RegexTool checkPhone:self.phone.text]) {
//        [self.view makeToast:@"无效的手机号"];
//        return;
//    }
    
    if (self.phone.text.length == 0 || self.password.text == 0) {
        [self.view makeToast:@"您还有内容未填写完整"];
        return;
    }
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    [paramDic  setValue:self.phone.text forKey:@"userid"];// userid和手机一样
    [paramDic  setValue:self.password.text forKey:@"passwd"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Login dic:paramDic showHUD:YES Succed:^(id responseObject) {
        
        NSNumber *code = [responseObject objectForKey:@"status"];
        if (1 == [code integerValue]) {
            
            [InfoCache archiveObject:self.phone.text toFile:@"userid"];
            [InfoCache archiveObject:responseObject[@"token"] toFile:@"token"];
            
            [self get_ui_info:notification];
            
            // 云信
            [InfoCache archiveObject:responseObject[@"data"][@"accToken"] toFile:@"accToken"];
            [InfoCache archiveObject:responseObject[@"data"][@"accid"] toFile:@"accid"];
            [[NIMSDK sharedSDK].loginManager login:responseObject[@"data"][@"accid"] token:responseObject[@"data"][@"accToken"] completion:^(NSError *error) {
                if (!error) {
                    NSLog(@"登录成功");
                    
                }else{
                    NSLog(@"登录失败");
                }
            }];

        }
        

        
    } failure:^(NSError *error) {
        
    }];
}

// 返回用户表该用户相关信息
- (void)get_ui_info:(NSNotification *)notification
{

    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Get_ui_info dic:paramDic showHUD:YES Succed:^(id responseObject) {
        
        PersonModel *model = [PersonModel yy_modelWithJSON:responseObject[@"data"]];
        [InfoCache archiveObject:model toFile:Person];
        
        [[NIMSDK sharedSDK].userManager updateMyUserInfo:@{@(NIMUserInfoUpdateTagNick) : model.name} completion:^(NSError *error) {
            
        }];
        
        [[NIMSDK sharedSDK].userManager updateMyUserInfo:@{@(NIMUserInfoUpdateTagAvatar) : model.img} completion:^(NSError *error) {
            
        }];
        
        if (![notification.object isEqualToString:@"注册"]) {
            
            NSNumber *code = [responseObject objectForKey:@"status"];
            if (1 == [code integerValue]) {
                
                if ([notification.object isEqualToString:@"忘记密码"] || [notification.object isEqualToString:@"个人信息"]) {
                    [self.navigationController popToRootViewControllerAnimated:YES];

                }
                else {
                    [self.navigationController popViewControllerAnimated:YES];

                }

            }
        }
        
    } failure:^(NSError *error) {
        
    }];
}


- (void)forgetAction
{
    RegisterVC *vc = [[RegisterVC alloc] init];
    vc.title = @"忘记密码";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)registerAction
{
    RegisterVC *vc = [[RegisterVC alloc] init];
    vc.title = @"注册";
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    //带动画结果在切换tabBar的时候viewController会有闪动的效果不建议这样写
    //    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
