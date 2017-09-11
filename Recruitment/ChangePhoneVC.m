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
    
    UIButton *loginBtn = [UIButton buttonWithframe:CGRectMake(13, baseView.bottom+18, kScreen_Width-26, 35) text:@"确认" font:[UIFont systemFontOfSize:14] textColor:@"FFFFFF" backgroundColor:@"#FDA326" normal:nil selected:nil];
    loginBtn.layer.cornerRadius = 7;
    loginBtn.layer.masksToBounds = YES;
    [self.view addSubview:loginBtn];
//    [loginBtn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    
    if ([self.title isEqualToString:@"修改密码"]) {
        
        _phone.placeholder = @"原密码";
        _validate.placeholder = @"新密码，6-16位";
        
        rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12+13, _phone.height)];
        rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(0, 0, 12, 20);
        rightBtn.center = rightView.center;
        [rightBtn setImage:[UIImage imageNamed:@"9"] forState:UIControlStateNormal];
        [rightBtn setImage:[UIImage imageNamed:@"14"] forState:UIControlStateSelected];
        [rightView addSubview:rightBtn];
        _validate.rightView = rightView;

    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
