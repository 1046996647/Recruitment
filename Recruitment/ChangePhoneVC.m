//
//  ChangePhoneVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/11.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ChangePhoneVC.h"

@interface ChangePhoneVC ()

@property(nonatomic,strong) UITextField *phone;
@property(nonatomic,strong) UITextField *validate;


@end

@implementation ChangePhoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(11, 20, kScreen_Width-22, 90)];
    baseView.backgroundColor = [UIColor whiteColor];
    baseView.layer.cornerRadius = 10;
    baseView.layer.masksToBounds = YES;
    [self.view addSubview:baseView];
    
    _phone = [UITextField textFieldWithframe:CGRectMake(11, 0, baseView.width-22, 45) placeholder:@"请输入手机号" font:nil leftView:nil backgroundColor:@"#FFFFFF"];
    _phone.keyboardType = UIKeyboardTypeNumberPad;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    [baseView addSubview:_phone];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(_phone.left, _phone.bottom-1, _phone.width, 1)];
    view.backgroundColor = [UIColor colorWithHexString:@"#CACACA"];
    [baseView addSubview:view];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 68+13, _phone.height)];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 68, 16);
    rightBtn.center = rightView.center;
    rightBtn.layer.cornerRadius = rightBtn.height/2;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    rightBtn.layer.masksToBounds = YES;
    rightBtn.layer.borderColor = [UIColor colorWithHexString:@"#FDA326"].CGColor;
    rightBtn.layer.borderWidth = .5;
    [rightBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor colorWithHexString:@"#FDA326"] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [rightView addSubview:rightBtn];
    
    _validate = [UITextField textFieldWithframe:CGRectMake(_phone.left, _phone.bottom, baseView.width-22, 45) placeholder:@"验证码" font:nil leftView:nil backgroundColor:@"#FFFFFF"];
    _validate.keyboardType = UIKeyboardTypeNumberPad;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    [baseView addSubview:_validate];
    _validate.rightViewMode = UITextFieldViewModeAlways;
    _validate.rightView = rightView;
    _validate.leftViewMode = UITextFieldViewModeAlways;
    
    UIButton *loginBtn = [UIButton buttonWithframe:CGRectMake(13, baseView.bottom+18, kScreen_Width-26, 35) text:@"确认" font:[UIFont systemFontOfSize:14] textColor:@"#FFFFFF" backgroundColor:@"#FDA326" normal:nil selected:nil];
    loginBtn.layer.cornerRadius = 7;
    loginBtn.layer.masksToBounds = YES;
    [self.view addSubview:loginBtn];
    [loginBtn addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
    
    if ([self.title isEqualToString:@"修改密码"]) {
        
        _phone.placeholder = @"原密码";
        _validate.placeholder = @"新密码，6-16位";
        _phone.secureTextEntry = YES;
        _validate.secureTextEntry = YES;

        rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12+13, _phone.height)];
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = rightView.bounds;
        //    rightBtn.center = rightView.center;
        [rightBtn setImage:[UIImage imageNamed:@"9"] forState:UIControlStateNormal];
        [rightBtn setImage:[UIImage imageNamed:@"14"] forState:UIControlStateSelected];
        [rightView addSubview:rightBtn];
        [rightBtn addTarget:self action:@selector(viewAction:) forControlEvents:UIControlEventTouchUpInside];
        _validate.rightView = rightView;

    }

}

- (void)viewAction:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected) {
        _validate.secureTextEntry = NO;
    }
    else {
        _validate.secureTextEntry = YES;
        
    }
}

- (void)okAction
{
    [self.view endEditing:YES];
    
    if (self.phone.text.length == 0 || self.validate.text == 0) {
        [self.view makeToast:@"您还有内容未填写完整"];
        return;
    }
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    [paramDic  setValue:self.phone.text forKey:@"passwd"];
    [paramDic  setValue:self.validate.text forKey:@"passwd_new"];
    
    NSString *registStr = nil;
    
    if ([self.title isEqualToString:@"修改密码"]) {

        registStr = Alter_passwd;

    }
    else {
        
    }
    
    [AFNetworking_RequestData requestMethodPOSTUrl:registStr dic:paramDic showHUD:YES Succed:^(id responseObject) {
        
        NSNumber *code = [responseObject objectForKey:@"status"];
        if (1 == [code integerValue]) {
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
