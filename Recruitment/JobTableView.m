//
//  JobTableView.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/7.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "JobTableView.h"
#import "JobDetailVC.h"

@implementation JobTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.delegate  = self;
        self.dataSource = self;
    }
    return self;
}

- (void)cellctionAction:(JobModel *)model

{
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    [paraDic setValue:model.ID forKey:@"id"];
    [paraDic setValue:@"1" forKey:@"del"];// 取消收藏

    
    [AFNetworking_RequestData requestMethodPOSTUrl:Favs_job dic:paraDic showHUD:YES Succed:^(id responseObject) {

        
    } failure:^(NSError *error) {
        
        
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
//    return 10;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JobModel *model = self.dataArr[indexPath.row];
    if (model.cellHeight > 0) {
        return model.cellHeight;
    }
    else {
        return 90;
        
    }}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    JobModel *model = self.dataArr[indexPath.row];
    
    JobDetailVC *vc = [[JobDetailVC alloc] init];
    vc.title = @"职位详情";
    vc.model = model;
    [self.viewController.navigationController pushViewController:vc animated:YES];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JobCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[JobCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    
//    if (_cellType == 1) {
//        cell.timeLab.hidden = YES;
//    }
    if (self.dataArr.count > 0) {
        cell.model = self.dataArr[indexPath.row];

    }
    
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_cellType == 0) {
        return UITableViewCellEditingStyleNone;

    }
    return UITableViewCellEditingStyleDelete;
}

//修改左滑的按钮的字
-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexpath {
    
    return @"删除";
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self cellctionAction:self.dataArr[indexPath.row]];
    [self.dataArr removeObjectAtIndex:indexPath.row];
    [self reloadData];
}

- (void)setCellType:(NSInteger)cellType
{
    _cellType = cellType;
    
    [self reloadData];
}

@end
