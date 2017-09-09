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
        
        self.backgroundColor = [UIColor clearColor];
        
        self.dataArr = @[@"不限",@"保险",@"年终奖"];

        _tableView = [UITableView tableViewWithframe:CGRectMake(kScreen_Width, 0, self.width, self.height)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self addSubview:_tableView];
        
        [UIView animateWithDuration:.35 animations:^{
            _tableView.left = 0;
        }];
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
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    cell.textLabel.font = [UIFont systemFontOfSize:10];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    cell.textLabel.text = self.dataArr[indexPath.row];
    
    return cell;
}


@end
