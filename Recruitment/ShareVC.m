//
//  ShareVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/21.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ShareVC.h"

@interface ShareVC ()

@property(nonatomic,strong) UIView *baseView;


@end

@implementation ShareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _baseView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreen_Height, kScreen_Width, 80)];
    _baseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_baseView];
    
    NSArray *imgArr = @[@"17",@"16"];
    NSArray *titleArr1 = @[@"微信好友",@"朋友圈"];
    for (int i=0; i<titleArr1.count; i++) {
        
        UIButton *forgetBtn = [UIButton buttonWithframe:CGRectMake(i*93, 0, 93, _baseView.height) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:nil selected:nil];
        [_baseView addSubview:forgetBtn];
//        self.forgetBtn1 = forgetBtn;
        [forgetBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        forgetBtn.tag = i;
        
        UIImageView *imgView = [UIImageView imgViewWithframe:CGRectMake((forgetBtn.width-37)/2, 17, 37, 30) icon:imgArr[i]];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        [forgetBtn addSubview:imgView];
        
        UILabel *label1 = [UILabel labelWithframe:CGRectMake(0, imgView.bottom+5, forgetBtn.width, 12) text:titleArr1[i] font:[UIFont systemFontOfSize:10] textAlignment:NSTextAlignmentCenter textColor:@"#333333"];
        [forgetBtn addSubview:label1];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(forgetBtn.width-1, 0, 1, _baseView.height)];
        line.backgroundColor = [UIColor colorWithHexString:@"#EDEDED"];
        [forgetBtn addSubview:line];
    }
    
    //延迟1秒执行这个方法
//    [self performSelector:@selector(delayAction) withObject:nil afterDelay:.1];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self delayAction];
    });
    
}

- (void)delayAction
{
    [UIView animateWithDuration:.5 animations:^{
        _baseView.top = kScreen_Height-_baseView.height;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnAction:(UIButton *)btn
{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        if (_clickBlock) {
            _clickBlock(btn.tag);
        }
        
    }];
}

//点击蒙版 蒙版退下
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if ([touches anyObject].view == self.view) {
        
        [UIView animateWithDuration:.35 animations:^{
            _baseView.top = kScreen_Height;
        } completion:^(BOOL finished) {
            
            [self dismissViewControllerAnimated:NO completion:nil];
        }];
    }
    
}

@end
