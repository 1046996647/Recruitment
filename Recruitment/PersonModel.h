//
//  PersonalModel.h
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/9.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonModel : NSObject<NSCoding>

// 自加
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *key;
@property(nonatomic,strong) NSString *text;
@property(nonatomic,strong) NSString *image;


@property(nonatomic,strong) NSString *userid;
@property(nonatomic,strong) NSString *passwd;
@property(nonatomic,strong) NSString *phone;
@property(nonatomic,strong) NSString *name;


@end
