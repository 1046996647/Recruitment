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
        
        
        _textLab = [UILabel labelWithframe:CGRectMake(77, 11, 250, 17) text:nil font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#333333"];
        [self.contentView addSubview:_textLab];
        
        _detailLab = [UILabel labelWithframe:CGRectMake(77, _textLab.bottom+6, 250, 13) text:nil font:[UIFont systemFontOfSize:11] textAlignment:NSTextAlignmentLeft textColor:@"#999999"];
        [self.contentView addSubview:_detailLab];
        
        
    }
    return self;
}

@end
