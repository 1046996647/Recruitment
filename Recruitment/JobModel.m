//
//  JobModel.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/8.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "JobModel.h"

@implementation JobModel

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"ID" : @"id"};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    NSString *timeStr = [[dic[@"update_time"] componentsSeparatedByString:@" "] firstObject];
    timeStr = [timeStr substringFromIndex:5];
    _update_time = timeStr;
    
    NSString *timeStr1 = [[dic[@"addTime"] componentsSeparatedByString:@" "] firstObject];
    timeStr1 = [timeStr1 substringFromIndex:5];
    _addTime = timeStr1;

    return YES;
}

@end
