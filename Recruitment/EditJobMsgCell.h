//
//  EditJobMsgCell.h
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/9.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "EditJobMsgModel.h"
#import "PersonModel.h"
#import "BRPickerView.h"

@interface EditJobMsgCell : UITableViewCell<UITextFieldDelegate>

@property(nonatomic,strong) UITextField *tf;
@property(nonatomic,strong) UIButton *saveBtn;

@property(nonatomic,strong) PersonModel *model;
@property(nonatomic,strong) NSArray *dataSource;

@property (nonatomic,strong) NSArray *selectArr;


@end
