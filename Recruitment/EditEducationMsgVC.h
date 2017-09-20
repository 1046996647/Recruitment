//
//  EditEducationMsgVC.h
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/9.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^ResumeReloadBlock)(void);


@interface EditEducationMsgVC : BaseViewController

@property(nonatomic,copy) ResumeReloadBlock block;
@property(nonatomic,strong) PersonModel *model;
@property(nonatomic,assign) NSInteger index;


@end
