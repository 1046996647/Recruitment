//
//  MessageVC.h
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/6.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageTableView.h"

@interface SessionListViewController : NIMSessionListViewController


@property(nonatomic,strong) MessageTableView *msgView;
@property(nonatomic,strong) UITableView *tableView1;


@end
