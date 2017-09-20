//
//  SubscriptionManageCell.h
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/11.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubscriptionManageModel.h"

typedef void(^ResumeDeleteBlock)(NSInteger tag);


@interface SubscriptionManageCell : UITableViewCell

@property(nonatomic,strong) UIButton *selectBtn;
@property(nonatomic,strong) UIButton *jobBtn;
@property(nonatomic,strong) UIButton *jobBtn1;
@property(nonatomic,strong) UIButton *addressBtn;
@property(nonatomic,strong) UIView *baseView;
@property(nonatomic,strong) UIView *view;

//@property(nonatomic,strong) UILabel *moneyLab;
//@property(nonatomic,strong) UILabel *timeLab;
//@property(nonatomic,strong) UIImageView *imgView;

@property(nonatomic,strong) SubscriptionManageModel *model;
@property(nonatomic,assign) NSInteger type;
@property(nonatomic,copy) ResumeDeleteBlock block;


@end
