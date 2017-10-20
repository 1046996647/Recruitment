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

        
    }
    return self;
}

@end
