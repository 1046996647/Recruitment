//
//  JobView.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/8.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "JobView.h"

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
    
    if (_aTag == 2) {
        
        _jobview1 = [[JobView1 alloc] initWithFrame:self.bounds];
        [self addSubview:_jobview1];
    }
    else {
        
        [self removeFromSuperview];
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
        cell.detailTextLabel.text = @"不限";
    }
    else {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            
        }

    }
    cell.textLabel.font = [UIFont systemFontOfSize:10];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    cell.textLabel.text = self.dataArr[indexPath.row];
    
    return cell;
}

- (void)setTag:(NSInteger)tag
{
    _aTag = tag;
    
    if (tag == 0) {
        self.dataArr = @[@"计算机/互联网/通信/电子",@"会计/金融/银行/保险",@"贸易/消费/制造/营运"];

    }
    if (tag == 1) {
        self.dataArr = @[@"默认排序",@"薪资最高",@"距离最近"];

    }
    if (tag == 2) {
        self.dataArr = @[@"福利",@"距离",@"发布时间"];

    }
    
    if (tag < 2) {
        
        self.bottomView.hidden = YES;

        
        if (self.dataArr.count*40 > self.height) {
            _tableView.height = self.height;

        }
        _tableView.height = self.dataArr.count*40;
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
