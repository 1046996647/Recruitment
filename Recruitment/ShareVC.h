//
//  ShareVC.h
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/21.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^ClickBlock)(NSInteger);


@interface ShareVC : BaseViewController

@property (nonatomic,copy) ClickBlock clickBlock;


@end
