//
//  OpinionVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/11.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "OpinionVC.h"

@interface OpinionVC ()<UITextViewDelegate>

@property(nonatomic,strong) UILabel *remindLab1;


@end

@implementation OpinionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0)];
    footerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footerView];

    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(17, 12, kScreen_Width-17*2, 95)];
    view.layer.cornerRadius = 8;
    view.layer.masksToBounds = YES;
    view.layer.borderColor = [UIColor colorWithHexString:@"#EFEFEF"].CGColor;
    view.layer.borderWidth = 1;
    [footerView addSubview:view];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(8, 0, view.width-8, 72)];
    textView.font = [UIFont systemFontOfSize:12];
    [view addSubview:textView];
    textView.delegate = self;
    
    UILabel *remindLab1 = [UILabel labelWithframe:CGRectMake(textView.left+4, textView.top+5, view.width-(textView.left+4), 16) text:@"请输入您宝贵的意见" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
    [view addSubview:remindLab1];
    self.remindLab1 = remindLab1;
    
    UILabel *countLab = [UILabel labelWithframe:CGRectMake(view.width-100-10, view.height-12-6, 100, 12) text:@"0/160" font:[UIFont systemFontOfSize:10] textAlignment:NSTextAlignmentRight textColor:@"#333333"];
    [view addSubview:countLab];
    
    UIButton *imgBtn = [UIButton buttonWithframe:CGRectMake(27, view.bottom+21, 40, 40) text:nil font:nil textColor:nil backgroundColor:nil normal:@"103" selected:@""];
    [footerView addSubview:imgBtn];
    
    footerView.height = imgBtn.bottom+19;
    
    UIButton *saveBtn = [UIButton buttonWithframe:CGRectMake(0, 0, 30, 17) text:@"保存" font:[UIFont systemFontOfSize:14] textColor:@"#999999" backgroundColor:nil normal:nil selected:nil];
    //    [saveBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    //    self.cancelBtn = saveBtn;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    if (range.location < 160)
    {
        return  YES;
        
    } else  if ([textView.text isEqualToString:@"\n"]) {
        
        //这里写按了ReturnKey 按钮后的代码
        return NO;
    }
    
    if (textView.text.length == 160) {
        
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
