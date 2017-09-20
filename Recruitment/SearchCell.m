//
//  SearchCell.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/19.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "SearchCell.h"

@implementation SearchCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIButton *delBtn = [UIButton buttonWithframe:CGRectMake(kScreen_Width-44, 0, 44, 44) text:@"" font:[UIFont systemFontOfSize:12] textColor:@"" backgroundColor:@"#FFFFFF" normal:@"35" selected:nil];
        [self.contentView addSubview:delBtn];
        self.delBtn = delBtn;
    }
    
 
    return self;
}



@end
