//
//  ReceiveMsgCell.h
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/18.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFTableViewCell.h"
#import "ReceiveMsgModel.h"

typedef void(^ReceiveMsgBlock)(ReceiveMsgModel *model);


@interface ReceiveMsgCell : ZFTableViewCell

@property(nonatomic,strong) UIButton *selectBtn;
@property(nonatomic,strong) UILabel *timeLab;
@property(nonatomic,strong) UILabel *nameLab;
@property(nonatomic,strong) UILabel *typeLab;
@property(nonatomic,strong) UILabel *contenLab;

@property(nonatomic,strong) ReceiveMsgModel *model;
@property(nonatomic,copy) ReceiveMsgBlock block;


@end
