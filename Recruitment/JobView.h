//
//  JobView.h
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/8.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobView1.h"

typedef void(^JobSendBlock)(id obj, NSInteger tag);

@interface JobView : UIView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataArr;
@property (nonatomic,strong) NSArray *lastArr;
@property (nonatomic,strong) UIView *bottomView;
@property(nonatomic,assign) NSInteger aTag;
@property(nonatomic,strong) JobView1 *jobview1;
@property (nonatomic,strong) NSArray *selectJobArr;

@property (nonatomic,strong) JobSendBlock block;



@end
