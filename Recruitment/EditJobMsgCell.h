//
//  EditJobMsgCell.h
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/9.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditJobMsgModel.h"
#import "BRPickerView.h"

@interface EditJobMsgCell : UITableViewCell

@property(nonatomic,strong) UITextField *tf;
@property(nonatomic,strong) EditJobMsgModel *model;
@property(nonatomic,strong) NSArray *dataSource;

@end
