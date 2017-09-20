//
//  JobView1.h
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/8.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JobSendBlock1)(NSString *text, NSInteger index);


@interface JobView1 : UIView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataArr;

@property (nonatomic,strong) JobSendBlock1 block;
@property(nonatomic,assign) NSInteger aTag;
@property (nonatomic,strong) NSArray *selectArr;


@end
