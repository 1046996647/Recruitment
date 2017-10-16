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
#import "LoginVC.h"
#import "NSStringExt.h"
#import "MWWaveProgressView.h"


@interface ResumeVC ()

@property(nonatomic,strong) UIButton *forgetBtn;
@property(nonatomic,strong) UIButton *forgetBtn1;
@property(nonatomic,strong) UILabel *perLabel;
@property(nonatomic,strong) UILabel *remindLabel;
@property(nonatomic,strong) MWWaveProgressView *waterWave;
@property(nonatomic,strong) NSMutableArray *labelArr;



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
    
    MWWaveProgressView *waterWave = [[MWWaveProgressView alloc] init];
    waterWave.frame = CGRectMake(0, 0, 80, 80);
    waterWave.center = view.center;
    waterWave.percent = 0.0;
    waterWave.firstWaveColor = [UIColor colorWithHexString:@"#FF4B0D"];
    waterWave.secondWaveColor = [UIColor colorWithHexString:@"#FF6D20"];
    waterWave.speed = 0.07;
    waterWave.peak = 3;
    waterWave.backgroundColor = [UIColor colorWithHexString:@"#FF9634"];
    [self.view addSubview:waterWave];
    self.waterWave = waterWave;
    [waterWave startWave];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [waterWave addGestureRecognizer:tap];
    
    UILabel *perLabel = [UILabel labelWithframe:CGRectMake(0, 0, view1.width, 25) text:@"0%" font:[UIFont systemFontOfSize:18] textAlignment:NSTextAlignmentCenter textColor:@"#FFFFFF"];
    perLabel.center = view1.center;
    [self.view addSubview:perLabel];
    self.perLabel = perLabel;
    
    UILabel *remindLabel = [UILabel labelWithframe:CGRectMake((kScreen_Width-111)/2, view.bottom+11, 111, 15) text:@"登入后可编辑简历" font:[UIFont systemFontOfSize:10] textAlignment:NSTextAlignmentCenter textColor:@"#FFFFFF"];
    remindLabel.backgroundColor = [UIColor colorWithHexString:@"#FF9634"];
    remindLabel.layer.cornerRadius = remindLabel.height/2;
    remindLabel.layer.masksToBounds = YES;
    [self.view addSubview:remindLabel];
    self.remindLabel = remindLabel;
    
    _labelArr = [NSMutableArray array];
    NSArray *titleArr = @[@"HR查看",@"投递简历"];
    for (int i=0; i<titleArr.count; i++) {
        
        UIButton *forgetBtn = [UIButton buttonWithframe:CGRectMake(i*kScreen_Width/2, imgView.bottom, kScreen_Width/2, 52) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:nil selected:nil];
        [self.view addSubview:forgetBtn];
        self.forgetBtn = forgetBtn;
        forgetBtn.tag = i;
        [forgetBtn addTarget:self action:@selector(btnAction1:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *label1 = [UILabel labelWithframe:CGRectMake(0, 4, forgetBtn.width, 25) text:@"0" font:[UIFont systemFontOfSize:18] textAlignment:NSTextAlignmentCenter textColor:@"#333333"];
        [forgetBtn addSubview:label1];
        [_labelArr addObject:label1];


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
        [forgetBtn addTarget:self action:@selector(btnAction2:) forControlEvents:UIControlEventTouchUpInside];
        forgetBtn.tag = i;
        
        UIImageView *imgView = [UIImageView imgViewWithframe:CGRectMake(forgetBtn.width-5.4-14.6, 11, 5.4, 12.6) icon:@"98"];
        [forgetBtn addSubview:imgView];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(14, forgetBtn.height-.5, kScreen_Width-14, .5)];
        line.backgroundColor = [UIColor colorWithHexString:@"#D3D3D3"];
        [forgetBtn addSubview:line];
        
    }
    
//    [self get_ui_info:NO];

}

// 获取部分用户信息
- (void)get_ui_info:(BOOL)isShow
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Get_ui_info dic:dic showHUD:isShow Succed:^(id responseObject) {
        
        PersonModel *model = [PersonModel yy_modelWithJSON:responseObject[@"data"]];
        
        if (model) {
            
            [InfoCache archiveObject:model toFile:Person];
            
            self.perLabel.text = [NSString stringWithFormat:@"%@%%",model.form_percent];
            self.waterWave.percent = model.form_percent.integerValue / 100.0;
            
            if (model.form_percent.integerValue < 60) {
                
                self.remindLabel.text = [NSString stringWithFormat:@"亲，完善度需要60%%才可以投递"];
            }
            else {
                self.remindLabel.text = @"完善的简历会更加吸引公司的关注";
            }
            
            CGSize size = [NSString textLength:self.remindLabel.text font:self.remindLabel.font];
            
            self.remindLabel.width = size.width+20;
            self.remindLabel.left = (kScreen_Width-self.remindLabel.width)/2;
            
            NSArray *titleArr = @[@"0",model.resumeNum];
            int i=0;
            for (UILabel *label in _labelArr) {
                label.text = titleArr[i];
                i++;
            }
            
            if (isShow) {
                [self.view makeToast:@"简历刷新成功"];
            }
        }
        
        
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)tapAction
{
    PersonModel *person = [InfoCache unarchiveObjectWithFile:Person];
    if (!person) {
        LoginVC *vc = [[LoginVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
        return;
    }
    
    EditResumeVC *vc = [[EditResumeVC alloc] init];
    vc.title = @"简历";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)btnAction2:(UIButton *)btn
{
    PersonModel *person = [InfoCache unarchiveObjectWithFile:Person];
    if (!person) {
        LoginVC *vc = [[LoginVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
        return;
    }
    
    if (btn.tag == 0) {
        
        NSArray *arr = @[@"3天",@"7天",@"14天",@"取消"];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"设置委托投递后系统会根据你的求职意向自动投递，1小时候生效。" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        for (int i=0; i<arr.count; i++) {
            
            UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:arr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                if ([action.title isEqualToString:@"3天"]) {
                    
                    
                }
                
            }];
            
            if (i<arr.count-1) {
                [defaultAction setValue:[UIColor colorWithHexString:@"#333333"] forKey:@"_titleTextColor"];

            }
            else {
                [defaultAction setValue:[UIColor colorWithHexString:@"#0076FF"] forKey:@"_titleTextColor"];

            }
            
            [alertController addAction:defaultAction];
        }
        

//        [alertController addAction:[UIAlertAction actionWithTitle:@"3天" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            
//            
//        }]];


//        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
//            
//            NSLog(@"添加一个textField就会调用 这个block");
//            
//        }];
        // 由于它是一个控制器 直接modal出来就好了
        [self presentViewController:alertController animated:YES completion:nil];

    }
    else {

        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定简历保密吗" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"简历保密" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)btnAction1:(UIButton *)btn
{
    PersonModel *person = [InfoCache unarchiveObjectWithFile:Person];
    if (!person) {
        LoginVC *vc = [[LoginVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
        return;
    }
    
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
    PersonModel *person = [InfoCache unarchiveObjectWithFile:Person];
    if (!person) {
        LoginVC *vc = [[LoginVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
        return;
    }
    
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
        
        [self get_ui_info:YES];
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
    
    PersonModel *person = [InfoCache unarchiveObjectWithFile:Person];
    
    if (person) {
        [self get_ui_info:NO];

    }
    else {
        
        self.perLabel.text = [NSString stringWithFormat:@"0%%"];
        self.waterWave.percent = 0.0;
        self.remindLabel.text = [NSString stringWithFormat:@"登入后可编辑简历"];
        
        CGSize size = [NSString textLength:self.remindLabel.text font:self.remindLabel.font];
        self.remindLabel.width = size.width+20;
        self.remindLabel.left = (kScreen_Width-self.remindLabel.width)/2;
        
        NSArray *titleArr = @[@"0",@"0"];
        int i=0;
        for (UILabel *label in _labelArr) {
            label.text = titleArr[i];
            i++;
        }
    }

    
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
}
@end
