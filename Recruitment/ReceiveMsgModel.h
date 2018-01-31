//
//  ReceiveMsgModel.h
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/11/14.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReceiveMsgModel : NSObject

@property(nonatomic,strong) NSString *type;//
@property(nonatomic,strong) NSString *addTime;
@property(nonatomic,strong) NSString *info;//
@property(nonatomic,strong) NSString *messId;//
@property(nonatomic,strong) NSString *title;//
@property(nonatomic,strong) NSString *addTime1;//
@property(nonatomic,strong) NSString *fromid;//

@property (nonatomic,assign) BOOL isSelected;


@end
