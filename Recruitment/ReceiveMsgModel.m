//
//  ReceiveMsgModel.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/11/14.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ReceiveMsgModel.h"

@implementation ReceiveMsgModel

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    

    NSString *timeStr1 = [[dic[@"addTime"] componentsSeparatedByString:@" "] lastObject];
    _addTime = timeStr1;
    NSString *timeStr2 = [[dic[@"addTime"] componentsSeparatedByString:@" "] firstObject];
    _addTime1 = timeStr2;
    
    return YES;
}

@end
