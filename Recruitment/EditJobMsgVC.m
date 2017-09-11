//
//  EditJobMsgVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/9.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "EditJobMsgVC.h"
#import "EditJobMsgCell.h"

@interface EditJobMsgVC ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>

@property (nonatomic,strong) NSArray *dataArr;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UILabel *remindLab1;


@end

@implementation EditJobMsgVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // 尾视图
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0)];
    footerView.backgroundColor = [UIColor whiteColor];
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 8)];
    view.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
    [footerView addSubview:view];
    
    UILabel *remindLab = [UILabel labelWithframe:CGRectMake(13, view.bottom+12, 200, 16) text:@"工作内容（至少十字以上）" font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
    [footerView addSubview:remindLab];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(remindLab.left, remindLab.bottom+12, kScreen_Width-remindLab.left*2, 95)];
    view.layer.cornerRadius = 8;
    view.layer.masksToBounds = YES;
    view.layer.borderColor = [UIColor colorWithHexString:@"#EFEFEF"].CGColor;
    view.layer.borderWidth = 1;
    [footerView addSubview:view];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(8, 0, view.width-8, 72)];
    textView.font = [UIFont systemFontOfSize:12];
    [view addSubview:textView];
    textView.delegate = self;

    UILabel *remindLab1 = [UILabel labelWithframe:CGRectMake(textView.left+4, textView.top+5, view.width-(textView.left+4), 16) text:@"你的工作职责，具体负责的事情" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
    [view addSubview:remindLab1];
    self.remindLab1 = remindLab1;
    
    UILabel *countLab = [UILabel labelWithframe:CGRectMake(view.width-100-10, view.height-12-6, 100, 12) text:@"0/500" font:[UIFont systemFontOfSize:10] textAlignment:NSTextAlignmentRight textColor:@"#333333"];
    [view addSubview:countLab];
    
    footerView.height = view.bottom+17;
    
    if ([self.title isEqualToString:@"基本信息"]) {
        remindLab.text = @"自我描述（至少十字以上）";
        remindLab1.text = @"一句话介绍自己,告诉HR为什么选择你而不是别人。";
        self.dataArr = @[@[@{@"image":@"68",@"title":@"姓名"},
                           @{@"image":@"67",@"title":@"性别"},
                           @{@"image":@"67",@"title":@"出生日期"}],
                         @[@{@"image":@"67",@"title":@"最高学历"},
                           @{@"image":@"67",@"title":@"工作年龄"}],
                         @[@{@"image":@"67",@"title":@"手机"},
                           @{@"image":@"67",@"title":@"所在城市"}]
                         ];
    }
    else {
        
        remindLab.text = @"工作内容（至少十字以上）";
        remindLab1.text = @"你的工作职责，具体负责的事情";
        
        self.dataArr = @[@[@{@"image":@"68",@"title":@"公司名称"},
                           @{@"image":@"68",@"title":@"职位名称"}],
                         @[@{@"image":@"67",@"title":@"入职时间"},
                           @{@"image":@"67",@"title":@"离职时间"}]
                         ];
    }

    
    NSMutableArray *arrM = [NSMutableArray array];
    for (NSArray *arr in self.dataArr) {
        
        NSMutableArray *arrM1 = [NSMutableArray array];
        
        for (NSDictionary *dic in arr) {
            
            EditJobMsgModel *model = [EditJobMsgModel yy_modelWithJSON:dic];
            [arrM1 addObject:model];
        }
        
        [arrM addObject:arrM1];
        
    }
    
    self.dataArr = arrM;
    
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = footerView;
    
    UIButton *saveBtn = [UIButton buttonWithframe:CGRectMake(0, 0, 30, 17) text:@"保存" font:[UIFont systemFontOfSize:14] textColor:@"#333333" backgroundColor:nil normal:nil selected:nil];
//    [saveBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
//    self.cancelBtn = saveBtn;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataArr count];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArr[section] count];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EditJobMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[EditJobMsgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    EditJobMsgModel *model = self.dataArr[indexPath.section][indexPath.row];
    cell.model = model;
    
    return cell;
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
    if (range.location < 500)
    {
        return  YES;
        
    } else  if ([textView.text isEqualToString:@"\n"]) {
        
        //这里写按了ReturnKey 按钮后的代码
        return NO;
    }
    
    if (textView.text.length == 500) {
        
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
