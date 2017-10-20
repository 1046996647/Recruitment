//
//  JobView.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/8.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "JobView1.h"

@implementation JobView1

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame ];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
//        self.dataArr = @[@"不限",@"保险",@"年终奖"];

        _tableView = [UITableView tableViewWithframe:CGRectMake(kScreen_Width, 0, self.width, self.height)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self addSubview:_tableView];
        
        [UIView animateWithDuration:.35 animations:^{
            _tableView.left = 0;
        }];
        
        // 选择项数据
        NSArray *selectArr = [InfoCache unarchiveObjectWithFile:SelectItem];;
        self.selectArr = selectArr;
        
    }
    return self;
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
    

    [UIView animateWithDuration:.35 animations:^{
        _tableView.left = kScreen_Width;

    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
    
    if (self.block) {
        self.block(self.dataArr[indexPath.row], indexPath.row);
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    cell.textLabel.text = self.dataArr[indexPath.row];
    
    return cell;
}

- (void)setATag:(NSInteger)tag
{
    _aTag = tag;
    
    NSMutableArray *arrM = [NSMutableArray array];
    
    [arrM addObject:@"不限"];


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

        for (NSDictionary *dic in self.selectArr) {
            
            if ([dic[@"name"] isEqualToString:@"user_company"]) {
                NSString *str = dic[@"data"];
                NSArray *arr = [str componentsSeparatedByString:@","];
                [arrM addObjectsFromArray:arr];
                
                break;
                
            }
            
        }
    }
    
    self.dataArr = arrM;

    [_tableView reloadData];
    
}

@end
