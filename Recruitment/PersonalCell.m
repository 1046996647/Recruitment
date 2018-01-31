//
//  PersonalCell.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/6.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "PersonalCell.h"

@implementation PersonalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _imgView = [UIImageView imgViewWithframe:CGRectMake(20, (self.contentView.height-20)/2.0, 20, 20) icon:nil];
        [self.contentView addSubview:_imgView];
        
        _label = [UILabel labelWithframe:CGRectMake(_imgView.right+10, (self.contentView.height-20)/2.0, 200, 20) text:nil font:[UIFont systemFontOfSize:16] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self.contentView addSubview:_label];

        _redDot = [[UILabel alloc] initWithFrame:CGRectMake(113, 5, 18, 18)];
        _redDot.layer.cornerRadius = _redDot.height/2;
        _redDot.layer.masksToBounds = YES;
        _redDot.font = [UIFont systemFontOfSize:12];
        _redDot.textAlignment = NSTextAlignmentCenter;
        _redDot.textColor = [UIColor whiteColor];
        _redDot.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_redDot];
        _redDot.hidden = YES;
    }
    return self;
}

@end
