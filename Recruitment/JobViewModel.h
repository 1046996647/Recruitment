//
//  JobViewModel.h
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/20.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JobViewModel : NSObject

@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *subTitle;
@property(nonatomic,strong) NSString *content;
@property(nonatomic,strong) NSString *key;

@property(nonatomic,assign) BOOL isSelected;

@property(nonatomic,assign) NSInteger cellHeight;


@end
