//
//  ResumeVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/6.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ResumeVC.h"
#import "EditResumeVC.h"
#import "SendHistoryVC.h"
#import "CheckedVC.h"

@interface ResumeVC ()

@property(nonatomic,strong) UIButton *forgetBtn;
@property(nonatomic,strong) UIButton *forgetBtn1;



@end

@implementation ResumeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *imgView = [UIImageView imgViewWithframe:CGRectMake(0, 0, kScreen_Width, 203) icon:@"111"];
    [self.view addSubview:imgView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake((kScreen_Width-90)/2, 56, 90, 90)];
    view.layer.cornerRadius = view.height/2;
    view.layer.masksToBounds = YES;
    view.layer.borderColor = [UIColor colorWithHexString:@"#FF9938"].CGColor;
    view.layer.borderWidth = 1;
    [self.view addSubview:view];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    view1.layer.cornerRadius = view1.height/2;
    view1.layer.masksToBounds = YES;
    view1.backgroundColor = [UIColor colorWithHexString:@"#FF9634"];
    view1.center = view.center;
    [self.view addSubview:view1];
    
    UILabel *perLabel = [UILabel labelWithframe:CGRectMake(0, 0, view1.width, 25) text:@"0%" font:[UIFont systemFontOfSize:18] textAlignment:NSTextAlignmentCenter textColor:@"#FFFFFF"];
    perLabel.center = view1.center;
    [self.view addSubview:perLabel];
    
    UILabel *remindLabel = [UILabel labelWithframe:CGRectMake((kScreen_Width-111)/2, view.bottom+11, 111, 15) text:@"登入后可编辑简历" font:[UIFont systemFontOfSize:10] textAlignment:NSTextAlignmentCenter textColor:@"#FFFFFF"];
    remindLabel.backgroundColor = [UIColor colorWithHexString:@"#FF9634"];
    remindLabel.layer.cornerRadius = remindLabel.height/2;
    remindLabel.layer.masksToBounds = YES;
    [self.view addSubview:remindLabel];
    
    NSArray *titleArr = @[@"HR查看",@"投递简历"];
    for (int i=0; i<titleArr.count; i++) {
        
        UIButton *forgetBtn = [UIButton buttonWithframe:CGRectMake(i*kScreen_Width/2, imgView.bottom, kScreen_Width/2, 52) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:nil selected:nil];
        [self.view addSubview:forgetBtn];
        self.forgetBtn = forgetBtn;
        forgetBtn.tag = i;
        [forgetBtn addTarget:self action:@selector(btnAction1:) forControlEvents:UIControlEventTouchUpInside];

        
        UILabel *label1 = [UILabel labelWithframe:CGRectMake(0, 4, forgetBtn.width, 25) text:@"0" font:[UIFont systemFontOfSize:18] textAlignment:NSTextAlignmentCenter textColor:@"#333333"];
        [forgetBtn addSubview:label1];

        UILabel *label2 = [UILabel labelWithframe:CGRectMake(0, label1.bottom, forgetBtn.width, 20) text:titleArr[i] font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentCenter textColor:@"#666666"];
        [forgetBtn addSubview:label2];
        
        if (i == 0) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(forgetBtn.width-1, 11, 1, 30)];
            line.backgroundColor = [UIColor colorWithHexString:@"#D3D3D3"];
            [forgetBtn addSubview:line];
        }


    }
    
    NSArray *imgArr = @[@"101",@"100",@"99"];
    NSArray *titleArr1 = @[@"编辑简历",@"预览简历",@"刷新简历"];
    for (int i=0; i<titleArr1.count; i++) {
        
        UIButton *forgetBtn = [UIButton buttonWithframe:CGRectMake(i*kScreen_Width/3, self.forgetBtn.bottom+14, kScreen_Width/3, 64) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:nil selected:nil];
        [self.view addSubview:forgetBtn];
        self.forgetBtn1 = forgetBtn;
        [forgetBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        forgetBtn.tag = i;

        UIImageView *imgView = [UIImageView imgViewWithframe:CGRectMake((forgetBtn.width-20)/2, 11, 20, 20) icon:imgArr[i]];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        [forgetBtn addSubview:imgView];
        
        UILabel *label1 = [UILabel labelWithframe:CGRectMake(0, imgView.bottom+6, forgetBtn.width, 18) text:titleArr1[i] font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentCenter textColor:@"#333333"];
        [forgetBtn addSubview:label1];
        
    }
    
    NSArray *titleArr2 = @[@"    委托投递",@"    简历状态"];
    for (int i=0; i<titleArr2.count; i++) {
        
        UIButton *forgetBtn = [UIButton buttonWithframe:CGRectMake(0, self.forgetBtn1.bottom+14+i*38, kScreen_Width, 38) text:titleArr2[i] font:[UIFont systemFontOfSize:13] textColor:@"#333333" backgroundColor:@"#FFFFFF" normal:nil selected:nil];
        forgetBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.view addSubview:forgetBtn];
        
        UIImageView *imgView = [UIImageView imgViewWithframe:CGRectMake(forgetBtn.width-5.4-14.6, 11, 5.4, 12.6) icon:@"98"];
        [forgetBtn addSubview:imgView];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(14, forgetBtn.height-.5, kScreen_Width-14, .5)];
        line.backgroundColor = [UIColor colorWithHexString:@"#D3D3D3"];
        [forgetBtn addSubview:line];
        
    }
}

- (void)btnAction1:(UIButton *)btn
{
    if (btn.tag == 0) {
        CheckedVC *vc = [[CheckedVC alloc] init];
        vc.title = @"简历被查看";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else {
        SendHistoryVC *vc = [[SendHistoryVC alloc] init];
        vc.title = @"投递历史";
        [self.navigationController pushViewController:vc animated:YES];
    }

}

- (void)btnAction:(UIButton *)btn
{
    if (btn.tag == 0) {
        EditResumeVC *vc = [[EditResumeVC alloc] init];
        vc.title = @"简历";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (btn.tag == 1) {
        
        EditResumeVC *vc = [[EditResumeVC alloc] init];
        vc.title = @"预览";
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    if (btn.tag == 2) {
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    //带动画结果在切换tabBar的时候viewController会有闪动的效果不建议这样写
    //    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
}
@end
