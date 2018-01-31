//
//  MessageCell.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/7.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        _textLab = [UILabel labelWithframe:CGRectMake(77, 11, 250, 17) text:nil font:[UIFont systemFontOfSize:16] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self.contentView addSubview:_textLab];
        
        _detailLab = [UILabel labelWithframe:CGRectMake(77, _textLab.bottom+8, 250, 13) text:nil font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:@"#999999"];
        [self.contentView addSubview:_detailLab];
        
        _redDot = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 18, 18)];
        _redDot.layer.cornerRadius = _redDot.height/2;
        _redDot.layer.masksToBounds = YES;
        _redDot.font = [UIFont systemFontOfSize:12];
        _redDot.textAlignment = NSTextAlignmentCenter;
        _redDot.textColor = [UIColor whiteColor];
        _redDot.backgroundColor = [UIColor redColor];
        [self.imageView addSubview:_redDot];
        _redDot.hidden = YES;
    }
    return self;
}

@end
