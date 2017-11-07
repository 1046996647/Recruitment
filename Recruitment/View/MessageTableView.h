//
//  MessageTableView.h
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/10/9.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *dataArr;
@property (nonatomic,assign) BOOL isNew;


@end
