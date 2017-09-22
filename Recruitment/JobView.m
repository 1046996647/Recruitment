//
//  JobView.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/8.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "JobView.h"
#import "JobViewModel.h"

@implementation JobView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame ];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:108/255.0 green:108/255.0 blue:108/255.0 alpha:.4];
        
        _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, kScreen_Width, 0)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self addSubview:_tableView];
        
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-44, kScreen_Width, 44)];
        [self addSubview:bottomView];
        bottomView.hidden = YES;
        self.bottomView = bottomView;
        
        UIButton *okBtn = [UIButton buttonWithframe:CGRectMake((bottomView.width-120)/2, 5, 120, 34) text:@"确定" font:[UIFont systemFontOfSize:16] textColor:@"#FFFFFF" backgroundColor:@"#FF9123" normal:nil selected:nil];
        okBtn.layer.cornerRadius = 10;
        okBtn.layer.masksToBounds = YES;
        [bottomView addSubview:okBtn];
        [okBtn addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
        
        NSArray *selectJobArr = [InfoCache unarchiveObjectWithFile:SelectItemJob];;
        self.selectJobArr = selectJobArr;

    }
    return self;
}

//- (JobView1 *)jobview1
//{
//    if (!_jobview1) {
//        _jobview1 = [[JobView1 alloc] initWithFrame:self.bounds];
//    }
//    return _jobview1;
//}

- (void)okAction
{
    [self removeFromSuperview];
    
    NSMutableDictionary *dicM = [NSMutableDictionary dictionary];
    for (JobViewModel *model in self.lastArr) {
        
        [dicM setValue:model.content forKey:model.key];
    }
    if (self.block) {
        self.block(dicM, _aTag);
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_aTag == 2) {
        return self.lastArr.count;

    }
    else {
        return self.dataArr.count;

    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_aTag == 2) {
        
        __block JobViewModel *model = self.lastArr[indexPath.row];
        __weak typeof(self) weakSelf = self;
        
        _jobview1 = [[JobView1 alloc] initWithFrame:self.bounds];
        [self addSubview:_jobview1];
        _jobview1.aTag = indexPath.row;
        _jobview1.block = ^(NSString *text, NSInteger index) {
            
            model.subTitle = text;

            if ([model.title isEqualToString:@"公司性质"]) {
                model.content = text;
            }
            else {
                model.content = [NSString stringWithFormat:@"%ld",index];

            }
            
            [weakSelf.tableView reloadData];
            
            
        };
    }
    else {
        
        [self removeFromSuperview];
        
        if (_aTag == 0) {
            
            NSDictionary *dic = self.selectJobArr[indexPath.row];
            if (self.block) {
                
                self.block(dic[@"id"], _aTag);
            }
        }
        else {
            
            NSArray *arr = @[@"add_time",@"pay"];
            if (self.block) {
                
                self.block(arr[indexPath.row], _aTag);
            }
        }
        

    }
    

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = nil;

    if (_aTag == 2) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell1"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
        cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        
        JobViewModel *model = self.lastArr[indexPath.row];
        cell.textLabel.text = model.title;
        cell.detailTextLabel.text = model.subTitle;

    }
    else {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            
        }
        cell.textLabel.text = self.dataArr[indexPath.row];

    }
    cell.textLabel.font = [UIFont systemFontOfSize:10];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];


    
    return cell;
}



- (void)setATag:(NSInteger)tag
{
    _aTag = tag;
    
    if (tag == 0) {
        
        NSMutableArray *arrM = [NSMutableArray array];
        
        for (NSDictionary *dic in self.selectJobArr) {
            
            [arrM addObject:dic[@"name"]];
            
        }
        self.dataArr = arrM;

    }
    if (tag == 1) {
        self.dataArr = @[@"默认排序",@"薪资最高"];

    }
    if (tag == 2) {
        
        if (!self.lastArr) {
            
            self.lastArr = @[@{@"title":@"发布时间",@"subTitle":@"不限",@"content":@"0",@"key":@"order"},
                             @{@"title":@"经验要求",@"subTitle":@"不限",@"content":@"0",@"key":@"years"},
                             @{@"title":@"学历要求",@"subTitle":@"不限",@"content":@"0",@"key":@"eduid"},
                             @{@"title":@"薪资范围",@"subTitle":@"不限",@"content":@"0",@"key":@"pay"},
                             @{@"title":@"职位类型",@"subTitle":@"不限",@"content":@"0",@"key":@"jobs"},
                             @{@"title":@"公司性质",@"subTitle":@"不限",@"content":@"",@"key":@"type"}];
            
            NSMutableArray *arrM = [NSMutableArray array];
            for (NSDictionary *dic in self.lastArr) {
                
                JobViewModel *model = [JobViewModel yy_modelWithJSON:dic];
                [arrM addObject:model];
            }
            self.lastArr = arrM;
            
        }


    }
    
    if (tag < 2) {
        
        self.bottomView.hidden = YES;

        
        if (self.dataArr.count*40 > self.height) {
            _tableView.height = self.height;

        }
        else {
            _tableView.height = self.dataArr.count*40;

        }
        self.backgroundColor = [UIColor colorWithRed:108/255.0 green:108/255.0 blue:108/255.0 alpha:.4];

    }
    else {
        self.bottomView.hidden = NO;

        _tableView.height = self.height-44;
        self.backgroundColor = [UIColor whiteColor];
    }
    
    [_tableView reloadData];
    
}


@end
