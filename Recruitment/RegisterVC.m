//
//  LoginVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/6.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "RegisterVC.h"
#import "PersonalMessageVC.h"
#import "RegexTool.h"
#import "CountDownServer.h"

#define kCountDownForVerifyCode @"CountDownForVerifyCode"


@interface RegisterVC ()

@property(nonatomic,strong) UITextField *phone;
@property(nonatomic,strong) UITextField *password;
@property(nonatomic,strong) UITextField *validate;
@property (nonatomic, strong) UIButton *countDownButton;


@end

@implementation RegisterVC

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
    
    
    UILabel *label = [UILabel labelWithframe:CGRectMake((kScreen_Width-200)/2, backBtn.bottom-15, 200, 18) text:self.title font:[UIFont boldSystemFontOfSize:17] textAlignment:NSTextAlignmentCenter textColor:@"#000000"];
    [self.view addSubview:label];
    
    
    // 手机
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

    
    // 密码
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

    
    _password = [UITextField textFieldWithframe:CGRectMake(_phone.left, _phone.bottom+10, _phone.width, _phone.height) placeholder:@"请输入6-16位密码" font:nil leftView:leftView backgroundColor:@"#FFFFFF"];
    _password.layer.cornerRadius = 7;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    _password.layer.masksToBounds = YES;
    [self.view addSubview:_password];
    _password.rightViewMode = UITextFieldViewModeAlways;
    _password.rightView = rightView;
    _password.secureTextEntry = YES;
    
    // 验证码
    leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45+10, 45)];
    leftView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
    leftView1.backgroundColor = [UIColor colorWithHexString:@"#FDA326"];
    
    UIImageView *imgView3 = [UIImageView imgViewWithframe:CGRectMake(0, 0, 45, 17) icon:@"8"];
    imgView3.contentMode = UIViewContentModeScaleAspectFit;
    imgView3.center = leftView1.center;
    
    [leftView1 addSubview:imgView3];
    [leftView addSubview:leftView1];
    
    rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70+13, _phone.height)];
    
    self.countDownButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.countDownButton.frame = CGRectMake(0, 0, 70, 16);
    self.countDownButton.center = rightView.center;
    self.countDownButton.layer.cornerRadius = self.countDownButton.height/2;
    self.countDownButton.layer.masksToBounds = YES;
    self.countDownButton.layer.borderColor = [UIColor colorWithHexString:@"#FDA326"].CGColor;
    self.countDownButton.layer.borderWidth = .5;
    [self.countDownButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.countDownButton setTitleColor:[UIColor colorWithHexString:@"#FDA326"] forState:UIControlStateNormal];
    self.countDownButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [rightView addSubview:self.countDownButton];
    [self.countDownButton addTarget:self action:@selector(getCodeAction) forControlEvents:UIControlEventTouchUpInside];
    
    _validate = [UITextField textFieldWithframe:CGRectMake(_phone.left, _password.bottom+10, _phone.width, _phone.height) placeholder:@"验证码" font:nil leftView:leftView backgroundColor:@"#FFFFFF"];
    _validate.layer.cornerRadius = 7;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    _validate.layer.masksToBounds = YES;
    [self.view addSubview:_validate];
    _validate.rightViewMode = UITextFieldViewModeAlways;
    _validate.rightView = rightView;

//    _validate.secureTextEntry = YES;
    
    UIButton *loginBtn = [UIButton buttonWithframe:CGRectMake(_password.left, _validate.bottom+23, _phone.width, _phone.height) text:@"下一步" font:[UIFont systemFontOfSize:16] textColor:@"FFFFFF" backgroundColor:@"#FDA326" normal:nil selected:nil];
    loginBtn.layer.cornerRadius = 7;
    loginBtn.layer.masksToBounds = YES;
    [self.view addSubview:loginBtn];
    [loginBtn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];

    
    if ([self.title isEqualToString:@"注册"]) {
        UILabel *agreeLabel = [UILabel labelWithframe:CGRectMake(_password.left, loginBtn.bottom+16, 90, 14) text:@"注册即表示同意" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#FFFFFF"];
        [self.view addSubview:agreeLabel];
        
        UIButton *registerBtn = [UIButton buttonWithframe:CGRectMake(agreeLabel.right, agreeLabel.top, 74, agreeLabel.height) text:@"《用户协议》" font:[UIFont systemFontOfSize:12] textColor:@"#F5AC57" backgroundColor:nil normal:nil selected:nil];
        [self.view addSubview:registerBtn];
    }
    else {
        [loginBtn setTitle:@"确定" forState:UIControlStateNormal];
        _password.placeholder = @"请输入6-16位新密码";
    }
    
    //倒计时通知事件
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(countDownUpdate:) name:@"CountDownUpdate" object:nil];

}

- (void)getCodeAction
{
    [self.view endEditing:YES];
    
    if (![RegexTool checkPhone:self.phone.text]) {
        [self.view makeToast:@"无效的手机号"];
        return;
    }
    
    // 开始计时
    [CountDownServer startCountDown:60 identifier:kCountDownForVerifyCode];
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    [paramDic  setValue:self.phone.text forKey:@"phone"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:VerifyCode dic:paramDic showHUD:YES Succed:^(id responseObject) {

        NSNumber *code = [responseObject objectForKey:@"status"];
        if (1 == [code integerValue]) {

            NSString *message = [responseObject objectForKey:@"message"];
            [self.view makeToast:message];

        }


    } failure:^(NSError *error) {

    }];
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

- (void)nextAction
{
    [self.view endEditing:YES];
    
    if (self.phone.text.length == 0 || self.password.text == 0 || self.validate.text.length == 0) {
        [self.view makeToast:@"您还有内容未填写完整"];
        return;
    }
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    [paramDic  setValue:self.phone.text forKey:@"phone"];
    [paramDic  setValue:self.validate.text forKey:@"verify"];

    
    NSString *registStr = nil;
    
    if ([self.title isEqualToString:@"注册"]) {
        
        registStr = Regist;
        [paramDic  setValue:self.password.text forKey:@"passwd"];

        
    } else if ([self.title isEqualToString:@"忘记密码"])
    {
        registStr = Forget_passwd;
        [paramDic  setValue:self.password.text forKey:@"passwd_new"];

    }
    
    [AFNetworking_RequestData requestMethodPOSTUrl:registStr dic:paramDic showHUD:YES Succed:^(id responseObject) {
        
        NSNumber *code = [responseObject objectForKey:@"status"];
        if (1 == [code integerValue]) {
            
            [InfoCache archiveObject:self.password.text toFile:@"password"];
            
            if ([self.title isEqualToString:@"注册"]) {
                
                [InfoCache archiveObject:self.phone.text toFile:@"userid"];
                [InfoCache archiveObject:responseObject[@"token"] toFile:@"token"];
                
                // 登录通知
                [[NSNotificationCenter defaultCenter] postNotificationName:@"kLoginNotification" object:self.title];
                
                PersonalMessageVC *vc = [[PersonalMessageVC alloc] init];
                vc.title = @"个人信息";
                [self.navigationController pushViewController:vc animated:YES];
                
            } else if ([self.title isEqualToString:@"忘记密码"])
            {
                
                [InfoCache archiveObject:[responseObject objectForKey:@"userid"] toFile:@"userid"];
                
                // 登录通知
                [[NSNotificationCenter defaultCenter] postNotificationName:@"kLoginNotification" object:self.title];
                
            }
            
        }
        
    } failure:^(NSError *error) {
        
    }];
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

#pragma mark-验证码通知方法
- (void)countDownUpdate:(NSNotification *)noti
{
    NSString *identifier = [noti.userInfo objectForKey:@"CountDownIdentifier"];
    if ([identifier isEqualToString:kCountDownForVerifyCode]) {
        NSNumber *n = [noti.userInfo objectForKey:@"SecondsCountDown"];
        
        [self performSelectorOnMainThread:@selector(updateVerifyCodeCountDown:) withObject:n waitUntilDone:YES];
    }
}

- (void)updateVerifyCodeCountDown:(NSNumber *)num {
    
    if ([num integerValue] == 0){
        
        [self.countDownButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.countDownButton.userInteractionEnabled = YES;
        self.countDownButton.layer.borderColor = [UIColor colorWithHexString:@"#FDA326"].CGColor;
        self.countDownButton.layer.borderWidth = .5;
        [self.countDownButton setTitleColor:[UIColor colorWithHexString:@"#FDA326"] forState:UIControlStateNormal];
         
     } else {
        [self.countDownButton setTitle:[NSString stringWithFormat:@"%@后重新获取",num] forState:UIControlStateNormal];
        self.countDownButton.userInteractionEnabled = NO;
        self.countDownButton.layer.borderColor = [UIColor colorWithHexString:@"#848484"].CGColor;
        self.countDownButton.layer.borderWidth = .5;
         [self.countDownButton setTitleColor:[UIColor colorWithHexString:@"#848484"] forState:UIControlStateNormal];
    }
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
