//
//  WordsVC.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/18.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "WordsVC.h"
#import "IQKeyboardManager.h"
#import "UIViewController+UIViewControllerExt.h"

@interface WordsVC ()

@property(nonatomic,strong) UITextView *words;
@property(nonatomic,strong) UIButton *lastBtn;
//@property(nonatomic,strong) UITextView *tv;


@end

@implementation WordsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    UIView *scroller = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreenHeight-kTabBarHeight-kTopHeight)];
//    [self.view addSubview:self.view];
    
    if (!self.name) {
        self.name = @"网站管理员";
    }

    UILabel *titleLab = [UILabel labelWithframe:CGRectMake(29, 15, 150, 19) text:[NSString stringWithFormat:@"收信人：%@",self.name] font:[UIFont systemFontOfSize:16] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [self.view addSubview:titleLab];
    
    CGFloat bottom = titleLab.bottom;
    if (![self.title isEqualToString:@"回复"]) {
        
        UILabel *typeLab = [UILabel labelWithframe:CGRectMake(titleLab.left, titleLab.bottom+21, 50, 19) text:@"类型：" font:[UIFont systemFontOfSize:16] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self.view addSubview:typeLab];
        bottom = typeLab.bottom;
        
        CGFloat interval = 12*scaleWidth;
        CGFloat aWidth = 52;
        //    NSArray *imgArr = @[@"62",@"61",@"60",@"59",@"58"];
        //    NSArray *selectedImgArr = @[@"62",@"61",@"60",@"59",@"58"];
        NSArray *titleArr2 = @[@"回复",@"咨询",@"建议",@"投诉",@"其他"];
        for (int i=0; i<titleArr2.count; i++) {
            
            UIButton *forgetBtn = [UIButton buttonWithframe:CGRectMake(typeLab.right +(i%4)*(aWidth+interval), typeLab.top+(i/4)*(20+interval), aWidth, 20) text:titleArr2[i] font:SystemFont(13) textColor:@"#333333" backgroundColor:nil normal:@"Group 2 Copy" selected:@"3"];
            [self.view addSubview:forgetBtn];
            [forgetBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            forgetBtn.tag = i;
            forgetBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
            
            if (i == 0) {
                forgetBtn.selected = YES;
                self.lastBtn = forgetBtn;
                
            }
        }
    }
    else {
//        self.lastBtn.currentTitle = @"回复";
    }
    
    
    
    _words = [[UITextView alloc] initWithFrame:CGRectMake(22, bottom+57, kScreen_Width-44, (329-70)*scaleWidth)];
    _words.backgroundColor = [UIColor whiteColor];
    _words.layer.cornerRadius = 7;
    _words.layer.masksToBounds = YES;
    [self.view addSubview:_words];
    
//    UIButton *releseBtn = [UIButton buttonWithframe:CGRectMake(_words.left, _words.bottom+37, kScreen_Width-_words.left*2, 40) text:@"发送" font:SystemFont(16) textColor:@"#FFFFFF" backgroundColor:@"#D0021B" normal:@"" selected:nil];
//    releseBtn.layer.cornerRadius = 7;
//    releseBtn.layer.masksToBounds = YES;
//    [self.view addSubview:releseBtn];
//    [releseBtn addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];

    UIButton *releseBtn = [UIButton buttonWithframe:CGRectMake(0, 0, 40, 40) text:@"提交" font:SystemFont(16) textColor:@"#F5A623" backgroundColor:nil normal:@"" selected:nil];
    [releseBtn addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:releseBtn];
//    self.view.contentSize = CGSizeMake(kScreen_Width, self.forgetBtn2.bottom);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnAction:(UIButton *)btn
{
    self.lastBtn.selected = NO;
    btn.selected = YES;

    self.lastBtn = btn;

}

- (void)sendAction
{
    if (_words.text.length == 0) {
        [self.view makeToast:@"请填写内容"];
        return;
    }
    
    NSMutableDictionary *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    
    if ([self.title isEqualToString:@"回复"]) {
//        [paramDic  setValue:@"回复" forKey:@"type"];

    }
    else {
        [paramDic  setValue:self.lastBtn.currentTitle forKey:@"type"];

    }
    [paramDic  setValue:_words.text forKey:@"info"];

    NSString *urlStr = nil;
    if (self.workerId) {
        [paramDic  setValue:self.workerId forKey:@"cid"];
        urlStr = Send_mess_comp;
    }
    else {
        urlStr = Send_mess_admin;

    }

    
    [AFNetworking_RequestData requestMethodPOSTUrl:urlStr dic:paramDic showHUD:YES Succed:^(id responseObject) {
        
//        [self.navigationController popViewControllerAnimated:YES];
        [self popViewController:@"MyMailboxVC"];
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - keyboardHight
-(void)viewWillAppear:(BOOL)animated
{
    [self registerForKeyboardNotifications];
    [IQKeyboardManager sharedManager].enable = NO;

}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [IQKeyboardManager sharedManager].enable = YES;

}
- (void)registerForKeyboardNotifications
{
    //使用NSNotificationCenter 鍵盤出現時
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    //使用NSNotificationCenter 鍵盤隐藏時
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

//实现当键盘出现的时候计算键盘的高度大小。用于输入框显示位置
- (void)keyboardWillShown:(NSNotification*)aNotification
{

    NSDictionary *info = [aNotification userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;

    _words.height = kScreen_Height-_words.top-keyboardSize.height-64;


}
//当键盘隐藏的时候
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    //do something
    _words.height = (329-70)*scaleWidth;


}

@end
