//
//  LoginVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/6.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "RegisterVC.h"

@interface RegisterVC ()

@property(nonatomic,strong) UITextField *phone;
@property(nonatomic,strong) UITextField *password;
@property(nonatomic,strong) UITextField *validate;


@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *imgView = [UIImageView imgViewWithframe:CGRectMake(0, 0, kScreen_Width, kScreen_Height) icon:@"110"];
    [self.view addSubview:imgView];
    
    UIButton *backBtn = [UIButton buttonWithframe:CGRectMake(20, 20+(44-30)/2, 30, 20) text:nil font:nil textColor:nil backgroundColor:nil normal:@"11" selected:nil];
    [self.view addSubview:backBtn];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *label = [UILabel labelWithframe:CGRectMake((kScreen_Width-200)/2, backBtn.bottom-15, 200, 18) text:self.title font:[UIFont boldSystemFontOfSize:17] textAlignment:NSTextAlignmentCenter textColor:@"#000000"];
    [self.view addSubview:label];
    
    
    // 手机
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
    
    // 密码
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
    rightBtn.frame = CGRectMake(0, 0, 12, 5);
    rightBtn.center = rightView.center;
    [rightBtn setImage:[UIImage imageNamed:@"9"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"14"] forState:UIControlStateSelected];
    [rightView addSubview:rightBtn];
    
    _password = [UITextField textFieldWithframe:CGRectMake(_phone.left, _phone.bottom+10, _phone.width, _phone.height) placeholder:@"请输入6-16位密码" font:nil leftView:leftView backgroundColor:@"#FFFFFF"];
    _password.layer.cornerRadius = 7;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    _password.layer.masksToBounds = YES;
    [self.view addSubview:_password];
    _password.rightViewMode = UITextFieldViewModeAlways;
    _password.rightView = rightView;
    _password.leftViewMode = UITextFieldViewModeAlways;
    _password.leftView = leftView;
    _password.secureTextEntry = YES;
    
    // 验证码
    leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45+10, 35)];
    leftView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45, 35)];
    leftView1.backgroundColor = [UIColor colorWithHexString:@"#FDA326"];
    
    UIImageView *imgView3 = [UIImageView imgViewWithframe:CGRectMake(0, 0, 45, 17) icon:@"8"];
    imgView3.contentMode = UIViewContentModeScaleAspectFit;
    imgView3.center = leftView1.center;
    
    [leftView1 addSubview:imgView3];
    [leftView addSubview:leftView1];
    
    rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 68+13, _phone.height)];
    rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 68, 16);
    rightBtn.center = rightView.center;
    rightBtn.layer.cornerRadius = rightBtn.height/2;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    rightBtn.layer.masksToBounds = YES;
    rightBtn.layer.borderColor = [UIColor colorWithHexString:@"#8B8484"].CGColor;
    rightBtn.layer.borderWidth = .5;
    [rightBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [rightView addSubview:rightBtn];
    
    _validate = [UITextField textFieldWithframe:CGRectMake(_phone.left, _password.bottom+10, _phone.width, _phone.height) placeholder:@"验证码" font:nil leftView:leftView backgroundColor:@"#FFFFFF"];
    _validate.layer.cornerRadius = 7;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    _validate.layer.masksToBounds = YES;
    [self.view addSubview:_validate];
    _validate.rightViewMode = UITextFieldViewModeAlways;
    _validate.rightView = rightView;
    _validate.leftViewMode = UITextFieldViewModeAlways;
    _validate.leftView = leftView;
    _validate.secureTextEntry = YES;
    
    UIButton *loginBtn = [UIButton buttonWithframe:CGRectMake(_password.left, _validate.bottom+23, _phone.width, _phone.height) text:@"下一步" font:[UIFont systemFontOfSize:13] textColor:@"FFFFFF" backgroundColor:@"#FDA326" normal:nil selected:nil];
    loginBtn.layer.cornerRadius = 7;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    loginBtn.layer.masksToBounds = YES;
    [self.view addSubview:loginBtn];
    
    if ([self.title isEqualToString:@"注册"]) {
        UILabel *agreeLabel = [UILabel labelWithframe:CGRectMake(_password.left, loginBtn.bottom+16, 90, 14) text:@"注册即表示同意" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#FFFFFF"];
        [self.view addSubview:agreeLabel];
        
        UIButton *registerBtn = [UIButton buttonWithframe:CGRectMake(agreeLabel.right, agreeLabel.top, 74, agreeLabel.height) text:@"《用户协议》" font:[UIFont systemFontOfSize:12] textColor:@"#F5AC57" backgroundColor:nil normal:nil selected:nil];
        [self.view addSubview:registerBtn];
    }
    else {
        [loginBtn setTitle:@"确定" forState:UIControlStateNormal];

    }

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
