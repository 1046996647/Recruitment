//
//  MyMailboxVC.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/18.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "MyMailboxVC.h"
#import "MJCSegmentInterface.h"
#import "ReceiveMsgVC.h"
#import "SendMsgVC.h"

@interface MyMailboxVC ()

@property(nonatomic,strong) UIButton *selectBtn;
@property(nonatomic,strong) MJCSegmentInterface *lala;
@property(nonatomic,strong) UIView *bottomLine;
@property(nonatomic,strong) UIButton *delBtn;


@end

@implementation MyMailboxVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    ReceiveMsgVC *vc1 = [[ReceiveMsgVC alloc] init];
    SendMsgVC *vc2 = [[SendMsgVC alloc] init];

    NSArray *vcarrr = @[vc1,vc2];
    NSArray *titlesArr = @[@"收到的信息",@"发出的信息"];
    for (int i = 0 ; i < vcarrr.count; i++) {//赋值标题
        UIViewController *vc = vcarrr[i];
        vc.title = titlesArr[i];
    }
    
    //以下是我的控件中的代码
    MJCSegmentInterface *lala = [[MJCSegmentInterface alloc]init];
    lala.titleBarStyles = MJCTitlesClassicStyle;
    lala.frame = CGRectMake(0, 0, kScreen_Width, kScreen_Height-64);
    lala.titlesViewFrame = CGRectMake(0, 0, 0, 37);
    lala.itemBackColor =  [UIColor clearColor];
    lala.itemTextNormalColor = colorWithHexStr(@"#EFCBD0");;
    lala.itemTextSelectedColor = colorWithHexStr(@"#D0021B");;
    lala.selectedSegmentIndex = 0;
    lala.indicatorColor = colorWithHexStr(@"#D0021B");
    lala.isIndicatorsAnimals = YES;
    lala.itemTextFontSize = 12;
    lala.isChildScollEnabled = NO;
    lala.indicatorStyles = MJCIndicatorItemTextStyle;
    [lala intoTitlesArray:titlesArr hostController:self];
    [self.view addSubview:lala];
    [lala intoChildControllerArray:vcarrr];
    self.lala = lala;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 37)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake((kScreen_Width-(60*2+37))/2, 0, 60*2+37, view.height)];
    baseView.backgroundColor = [UIColor whiteColor];
    [view addSubview:baseView];
    
    UIButton *selectBtn = [UIButton buttonWithframe:CGRectMake(0, 0, 62, view.height) text:@"收到的信息" font:SystemFont(12) textColor:@"#333333" backgroundColor:nil normal:@"" selected:nil];
    [selectBtn addTarget:self action:@selector(changeIndex:) forControlEvents:UIControlEventTouchUpInside];
    [baseView addSubview:selectBtn];
    selectBtn.tag = 0;
    self.selectBtn = selectBtn;

    
    CGFloat aWidth = selectBtn.width;
    UIButton *delBtn = [UIButton buttonWithframe:CGRectMake(selectBtn.right+37, 0, aWidth, selectBtn.height) text:@"发出的信息" font:SystemFont(12) textColor:@"#999999" backgroundColor:nil normal:@"" selected:nil];
    [delBtn addTarget:self action:@selector(changeIndex:) forControlEvents:UIControlEventTouchUpInside];
    [baseView addSubview:delBtn];
    delBtn.tag = 1;
    self.delBtn = delBtn;
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, selectBtn.height-2, selectBtn.width, 2)];
    bottomLine.backgroundColor = colorWithHexStr(@"#F5A623");
    [selectBtn addSubview:bottomLine];
    self.bottomLine = bottomLine;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changeIndex:(UIButton *)btn
{
    if (btn.tag == 0) {
        self.lala.selectedSegmentIndex = 0;
        [self.selectBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        [self.delBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        [UIView animateWithDuration:.35 animations:^{
            self.bottomLine.left = 0;
        }];

    }
    else {
        [self.selectBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        [self.delBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        self.lala.selectedSegmentIndex = 1;
        [UIView animateWithDuration:.35 animations:^{
            self.bottomLine.left = self.selectBtn.right+37;
        }];
    }
}

@end
