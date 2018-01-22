//
//  HeaderView.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/9.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame ];
    if (self) {
        
        UIButton *btn = [UIButton buttonWithframe:CGRectMake(8, 0, 190, 35) text:@"" font:[UIFont systemFontOfSize:16] textColor:@"#333333" backgroundColor:nil normal:@"" selected:nil];
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        [self addSubview:btn];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.btn = btn;
        
//        UILabel *hopeLabel = [UILabel labelWithframe:CGRectMake(btn.right+14, btn.center.y-7, 27, 14) text:@"选填" font:[UIFont systemFontOfSize:10] textAlignment:NSTextAlignmentCenter textColor:@"#FF9123"];
//        hopeLabel.layer.cornerRadius = hopeLabel.height/2;
//        hopeLabel.layer.masksToBounds = YES;
//        hopeLabel.layer.borderColor = [UIColor colorWithHexString:@"#FF9123"].CGColor;
//        hopeLabel.layer.borderWidth = 1;
//        [self addSubview:hopeLabel];
//        self.hopeLabel = hopeLabel;
    }
    
    
    return  self;
}

@end
