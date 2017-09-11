//
//  EditEducationMsgVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/9.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "EditEducationMsgVC.h"
#import "EditJobMsgCell.h"

@interface EditEducationMsgVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *dataArr;
@property(nonatomic,strong) UITableView *tableView;


@end

@implementation EditEducationMsgVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    if ([self.title isEqualToString:@"求职意向"]) {
        self.dataArr = @[@[@{@"image":@"68",@"title":@"意向岗位"},
                           @{@"image":@"68",@"title":@"工作类型"}],
                         @[@{@"image":@"67",@"title":@"意向城市"},
                           @{@"image":@"67",@"title":@"期望月薪"}],
                         @[@{@"image":@"67",@"title":@"到岗时间"}]
                         ];
    }
    else if ([self.title isEqualToString:@"增加订阅"]) {
        self.dataArr = @[@[@{@"image":@"68",@"title":@"关键字"}],
                         @[@{@"image":@"67",@"title":@"工作地点"},
                           @{@"image":@"67",@"title":@"工作经验"},
                           @{@"image":@"67",@"title":@"学历要求"}]
                         ];
    }
    else {
        self.dataArr = @[@[@{@"image":@"68",@"title":@"学校名称"},
                           @{@"image":@"68",@"title":@"专业名称"}],
                         @[@{@"image":@"67",@"title":@"入学时间"},
                           @{@"image":@"67",@"title":@"毕业时间"}],
                         @[@{@"image":@"67",@"title":@"文凭"}]
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
@end
