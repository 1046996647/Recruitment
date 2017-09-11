//
//  LoginVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/6.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "LoginVC.h"
#import "RegisterVC.h"

@interface LoginVC ()

@property(nonatomic,strong) UITextField *phone;
@property(nonatomic,strong) UITextField *password;


@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *imgView = [UIImageView imgViewWithframe:CGRectMake(0, 0, kScreen_Width, kScreen_Height) icon:@"110"];
    [self.view addSubview:imgView];
    
    UIButton *backBtn = [UIButton buttonWithframe:CGRectMake(20, 20+(44-30)/2, 30, 20) text:nil font:nil textColor:nil backgroundColor:nil normal:@"11" selected:nil];
    [self.view addSubview:backBtn];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];

    
    UILabel *label = [UILabel labelWithframe:CGRectMake((kScreen_Width-200)/2, backBtn.bottom-15, 200, 18) text:@"登录" font:[UIFont boldSystemFontOfSize:17] textAlignment:NSTextAlignmentCenter textColor:@"#000000"];
    [self.view addSubview:label];
    

    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45+10, 35)];
    UIView *leftView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45, 35)];
    leftView1.backgroundColor = [UIColor colorWithHexString:@"#FDA326"];

    UIImageView *imgView1 = [UIImageView imgViewWithframe:CGRectMake(0, 0, 45, 17) icon:@"13"];
    imgView1.contentMode = UIViewContentModeScaleAspectFit;
    imgView1.center = leftView1.center;

    [leftView1 addSubview:imgView1];
    [leftView addSubview:leftView1];
    
    _phone = [UITextField textFieldWithframe:CGRectMake(25, 91, kScreen_Width-50, 35) placeholder:@"请输入手机号" font:nil leftView:leftView backgroundColor:@"#FFFFFF"];
    _phone.keyboardType = UIKeyboardTypeNumberPad;
    _phone.layer.cornerRadius = 7;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    _phone.layer.masksToBounds = YES;
    [self.view addSubview:_phone];
    _phone.leftViewMode = UITextFieldViewModeAlways;
    _phone.leftView = leftView;
    
    leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45+10, 35)];
    leftView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45, 35)];
    leftView1.backgroundColor = [UIColor colorWithHexString:@"#FDA326"];
    
    UIImageView *imgView2 = [UIImageView imgViewWithframe:CGRectMake(0, 0, 45, 17) icon:@"12"];
    imgView2.contentMode = UIViewContentModeScaleAspectFit;
    imgView2.center = leftView1.center;

    [leftView1 addSubview:imgView2];
    [leftView addSubview:leftView1];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12+13, _phone.height)];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 12, 20);
    rightBtn.center = rightView.center;
    [rightBtn setImage:[UIImage imageNamed:@"9"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"14"] forState:UIControlStateSelected];
    [rightView addSubview:rightBtn];
    
    _password = [UITextField textFieldWithframe:CGRectMake(_phone.left, _phone.bottom+10, _phone.width, _phone.height) placeholder:@"请输入密码" font:nil leftView:leftView backgroundColor:@"#FFFFFF"];
    _password.layer.cornerRadius = 7;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    _password.layer.masksToBounds = YES;
    [self.view addSubview:_password];
    _password.rightViewMode = UITextFieldViewModeAlways;
    _password.rightView = rightView;
    _password.leftViewMode = UITextFieldViewModeAlways;
    _password.leftView = leftView;
    _password.secureTextEntry = YES;
    
    UIButton *loginBtn = [UIButton buttonWithframe:CGRectMake(_password.left, _password.bottom+23, _phone.width, _phone.height) text:@"登录" font:[UIFont systemFontOfSize:13] textColor:@"FFFFFF" backgroundColor:@"#FDA326" normal:nil selected:nil];
    loginBtn.layer.cornerRadius = 7;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    loginBtn.layer.masksToBounds = YES;
    [self.view addSubview:loginBtn];
    
    UIButton *registerBtn = [UIButton buttonWithframe:CGRectMake(loginBtn.left+5, loginBtn.bottom+16, 50, 14) text:@"立即注册" font:[UIFont systemFontOfSize:12] textColor:@"FFFFFF" backgroundColor:nil normal:nil selected:nil];
    [self.view addSubview:registerBtn];
    [registerBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];

    UIButton *forgetBtn = [UIButton buttonWithframe:CGRectMake(loginBtn.right-registerBtn.width-5, registerBtn.top, registerBtn.width, registerBtn.height) text:@"忘记密码" font:[UIFont systemFontOfSize:12] textColor:@"FFFFFF" backgroundColor:nil normal:nil selected:nil];
    [self.view addSubview:forgetBtn];
    [forgetBtn addTarget:self action:@selector(forgetAction) forControlEvents:UIControlEventTouchUpInside];

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
