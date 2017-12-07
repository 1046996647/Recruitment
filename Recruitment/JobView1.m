//
//  JobView.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/8.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "JobView1.h"
#import "JobView1cell.h"

@implementation JobView1

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame ];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
//        self.dataArr = @[@"不限",@"保险",@"年终奖"];

        _tableView = [UITableView tableViewWithframe:CGRectMake(kScreen_Width, 0, self.width, self.height-44)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self addSubview:_tableView];
        
        [UIView animateWithDuration:.35 animations:^{
            _tableView.left = 0;
        }];
        
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-44, kScreen_Width, 44)];
        [self addSubview:bottomView];
        bottomView.hidden = YES;
        self.bottomView = bottomView;
        
        UIButton *okBtn = [UIButton buttonWithframe:CGRectMake((bottomView.width-120)/2, 5, 120, 34) text:@"确定" font:[UIFont systemFontOfSize:16] textColor:@"#FFFFFF" backgroundColor:@"#FF9123" normal:nil selected:nil];
        okBtn.layer.cornerRadius = 10;
        okBtn.layer.masksToBounds = YES;
        [okBtn addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:okBtn];

        
        // 选择项数据
        NSArray *selectArr = [InfoCache unarchiveObjectWithFile:SelectItem];;
        self.selectArr = selectArr;
        
    }
    return self;
}

- (void)okAction
{
    JobViewModel *model = self.dataArr[0];
    NSString *content = nil;

    if (model.isSelected) {
        content = @"不限";

    }
    else {
        NSMutableArray *arrM = [NSMutableArray array];
        for (int i=1; i<self.dataArr.count; i++) {
            
            JobViewModel *model = self.dataArr[i];
            if (model.isSelected == YES) {
                [arrM addObject:model.content];
            }
            
        }
        content = [arrM componentsJoinedByString:@","];
        
        if (arrM.count == 0) {
            [self makeToast:@"请选择公司性质"];
            return;
        }

    }
    
    [UIView animateWithDuration:.35 animations:^{
        _tableView.left = kScreen_Width;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
    if (self.block) {
        if (self.block) {
            self.block(content, 0);
        }
        
    }
    NSLog(@"content:%@",content);
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    JobViewModel *model = self.dataArr[indexPath.row];

    if (_aTag == 5) {
        
        model.isSelected = !model.isSelected;
        if (indexPath.row == 0) {
            if (model.isSelected) {
                for (JobViewModel *model1 in self.dataArr) {
                    model1.isSelected = YES;
                }
            }
            else {
                for (JobViewModel *model1 in self.dataArr) {
                    model1.isSelected = NO;
                }
            }
        }
        else {
            
            BOOL allSelected = YES;
            for (int i=1; i<self.dataArr.count; i++) {
                
                JobViewModel *model = self.dataArr[i];
                if (model.isSelected == NO) {
                    allSelected = NO;
                    break;
                }
 
            }
            JobViewModel *model1 = self.dataArr[0];
            model1.isSelected = allSelected;
        }
        
        [_tableView reloadData];
        
    }
    else {
        [UIView animateWithDuration:.35 animations:^{
            _tableView.left = kScreen_Width;
            
        } completion:^(BOOL finished) {
            
            [self removeFromSuperview];
        }];
        
        if (self.block) {
            self.block(model.content, indexPath.row);
        }
    }


    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JobView1cell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        
        cell = [[JobView1cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    
//    cell.row = indexPath.row;
    cell.tag = _aTag;
    cell.model = self.dataArr[indexPath.row];
    
    return cell;
}

- (void)setATag:(NSInteger)tag
{
    _aTag = tag;
    
    NSMutableArray *arrM = [NSMutableArray array];
    
    [arrM addObject:@"不限"];

    _tableView.tableFooterView = [[UIView alloc] init];

    if (tag == 0) {
        
        [arrM addObjectsFromArray:@[@"今天",@"最近三天",@"最近一周",@"最近一个月"]];
        
    }
    
    if (tag == 1) {
        
        for (NSDictionary *dic in self.selectArr) {
            if ([dic[@"name"] isEqualToString:@"comp_years"]) {
                
                NSString *str = dic[@"data"];
                NSArray *arr = [str componentsSeparatedByString:@","];
                
                for (NSString *s in arr) {
                    NSString *s1 = [NSString stringWithFormat:@"%@年",s];
                    [arrM addObject:s1];
                }
                break;
            }
        }
    }
    
    if (tag == 2) {
        for (NSDictionary *dic in self.selectArr) {
            
            if ([dic[@"name"] isEqualToString:@"comp_edu"]) {
                NSString *str = dic[@"data"];
                NSArray *arr = [str componentsSeparatedByString:@","];
                [arrM addObjectsFromArray:arr];
                
                break;

            }

        }
    }
    
    if (tag == 3) {

        for (NSDictionary *dic in self.selectArr) {
            
            if ([dic[@"name"] isEqualToString:@"comp_pay"]) {
                NSString *str = dic[@"data"];
                NSArray *arr = [str componentsSeparatedByString:@","];
                [arrM addObjectsFromArray:arr];
                
                break;
                
            }
            
        }
    }
    if (tag == 4) {
        
        for (NSDictionary *dic in self.selectArr) {
            
            if ([dic[@"name"] isEqualToString:@"comp_jobs"]) {
                NSString *str = dic[@"data"];
                NSArray *arr = [str componentsSeparatedByString:@","];
                [arrM addObjectsFromArray:arr];
                
                break;
                
            }
            
        }
    }
    
    if (tag == 5) {

        self.bottomView.hidden = NO;
        for (NSDictionary *dic in self.selectArr) {
            
            if ([dic[@"name"] isEqualToString:@"user_company"]) {
                NSString *str = dic[@"data"];
                NSArray *arr = [str componentsSeparatedByString:@","];
                [arrM addObjectsFromArray:arr];

                break;
                
            }
            
        }
    }
    
    NSMutableArray *arrM1 = [NSMutableArray array];

    for (NSString *title in arrM) {
        JobViewModel *model = [[JobViewModel alloc] init];
        model.content = title;
        [arrM1 addObject:model];
    }
    self.dataArr = arrM1;
    
    if (tag == 5) {
        
        if ([self.content isEqualToString:@"不限"]) {
            for (JobViewModel *model in arrM1) {
                model.isSelected = YES;
            }
        }
        else {
            NSArray *contentArr = [self.content componentsSeparatedByString:@","];
            for (NSString *text in contentArr) {
                
                for (JobViewModel *model in arrM1) {
                    
                    if ([text isEqualToString:model.content]) {
                        model.isSelected = YES;

                    }
                }

            }
        }
    }

    [_tableView reloadData];
    
}

@end
