//
//  MsgDetailVC.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/11/14.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "MsgDetailVC.h"
#import "NSStringExt.h"
#import "WordsVC.h"

@interface MsgDetailVC ()

@end

@implementation MsgDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F5A623"];
    
    UIImageView *imgView = [UIImageView imgViewWithframe:CGRectMake((kScreen_Width-341*scaleWidth)/2, 20, 341*scaleWidth, 560*scaleWidth) icon:@"Combined Shape"];
    [self.view addSubview:imgView];
    imgView.userInteractionEnabled = YES;
    
    UIButton *postBtn = [UIButton buttonWithframe:CGRectMake(30, 24, imgView.width-30-12, 17) text:@"发件人：众信人才网" font:SystemFont(12) textColor:@"#333333" backgroundColor:@"#FFFFFF" normal:@"19-1" selected:nil];
    [imgView addSubview:postBtn];
    postBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    postBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 12, 0, 0);
    
    UIButton *receiveBtn = [UIButton buttonWithframe:CGRectMake(postBtn.left, postBtn.bottom+21, postBtn.width, postBtn.height) text:@"收件人：陈先生" font:SystemFont(12) textColor:@"#333333" backgroundColor:@"#FFFFFF" normal:@"18-1" selected:nil];
    [imgView addSubview:receiveBtn];
    receiveBtn.contentHorizontalAlignment = postBtn.contentHorizontalAlignment;
    receiveBtn.titleEdgeInsets = postBtn.titleEdgeInsets;
    
    NSString *userid = [InfoCache unarchiveObjectWithFile:@"userid"];

    if (_mark == 1) {
        [postBtn setTitle:[NSString stringWithFormat:@"发件人：%@",_model.title] forState:UIControlStateNormal];
        [receiveBtn setTitle:[NSString stringWithFormat:@"收件人：%@",userid] forState:UIControlStateNormal];
    }
    else {
        [postBtn setTitle:[NSString stringWithFormat:@"发件人：%@",userid] forState:UIControlStateNormal];
        [receiveBtn setTitle:[NSString stringWithFormat:@"收件人：%@",_model.title] forState:UIControlStateNormal];
    }
    
//    UIButton *typeBtn = [UIButton buttonWithframe:CGRectMake(postBtn.left, receiveBtn.bottom+21, postBtn.width, postBtn.height) text:[NSString stringWithFormat:@"类型：%@",_model.type] font:SystemFont(12) textColor:@"#333333" backgroundColor:@"#FFFFFF" normal:@"2" selected:nil];
//    [imgView addSubview:typeBtn];
//    typeBtn.contentHorizontalAlignment = postBtn.contentHorizontalAlignment;
//    typeBtn.titleEdgeInsets = postBtn.titleEdgeInsets;
    
    UIButton *contentBtn = [UIButton buttonWithframe:CGRectMake(postBtn.left, receiveBtn.bottom+21, 16, postBtn.height) text:@"" font:SystemFont(12) textColor:@"#333333" backgroundColor:@"#FFFFFF" normal:@"15-1" selected:nil];
    [imgView addSubview:contentBtn];
    
    UILabel *contentLab = [UILabel labelWithframe:CGRectMake(contentBtn.right+12, contentBtn.top, imgView.width-(contentBtn.right+12)-12, postBtn.height) text:[NSString stringWithFormat:@"内容：%@",_model.info] font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    contentLab.numberOfLines = 0;
    [imgView addSubview:contentLab];
    
    CGSize size = [NSString textHeight:contentLab.text font:contentLab.font width:contentLab.width];
    contentLab.height = size.height;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(11, imgView.height-13-40, imgView.width-22, 40)];
    view.backgroundColor = [UIColor colorWithHexString:@"#F5A623"];
    [imgView addSubview:view];

    UIButton *delBtn = [UIButton buttonWithframe:CGRectMake(0, 0, view.width/2, view.height) text:@"删除" font:SystemFont(14) textColor:@"#FFFFFF" backgroundColor:@"" normal:@"" selected:nil];
    [view addSubview:delBtn];
    [delBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.mark == 1) {
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(delBtn.right-1, 11, 1, 19)];
        line.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        [view addSubview:line];
        
        UIButton *replyBtn = [UIButton buttonWithframe:CGRectMake(delBtn.right, 0, view.width/2, view.height) text:@"回复" font:SystemFont(14) textColor:@"#FFFFFF" backgroundColor:@"" normal:@"" selected:nil];
        [view addSubview:replyBtn];
        [replyBtn addTarget:self action:@selector(replyAction) forControlEvents:UIControlEventTouchUpInside];
    }
    else {
        delBtn.width = view.width;

    }

}

- (void)deleteAction
{
    if (self.block) {
        self.block();
    }
}

- (void)replyAction
{
    WordsVC *vc = [[WordsVC alloc] init];
    vc.title = @"回复";
    vc.name = self.model.title;
    vc.workerId = self.model.fromid;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"#F5A623"];

}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"#F2F2F2"];

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
