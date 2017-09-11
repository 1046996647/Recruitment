//
//  EditJobMsgCell.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/9.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "EditJobMsgCell.h"

@implementation EditJobMsgCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _tf = [UITextField textFieldWithframe:CGRectMake(48, 0, kScreen_Width-43-12, 40) placeholder:nil font:nil leftView:nil backgroundColor:@"#FFFFFF"];
        _tf.font = [UIFont systemFontOfSize:13];
        [_tf setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];// 设置这里时searchTF.font也要设置不然会偏上
        [_tf setValue:[UIColor colorWithHexString:@"#999999"] forKeyPath:@"_placeholderLabel.textColor"];
        [self.contentView addSubview:_tf];
        [_tf addTarget:self action:@selector(beginAction:) forControlEvents:UIControlEventEditingDidBegin];
        [_tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
        //        [_tf addTarget:self action:@selector(endAction:) forControlEvents:UIControlEventEditingDidEnd];
        
    }
    return self;
}

- (void)setModel:(EditJobMsgModel *)model
{
    _model = model;
    
    self.imageView.image = [UIImage imageNamed:model.image];
    _tf.placeholder = model.title;
}

- (void)beginAction:(UITextField *)tf
{
    if ([_model.title isEqualToString:@"公司名称"] || [_model.title isEqualToString:@"职位名称"]) {
        return;
    }
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        [tf resignFirstResponder];
//        
//    });
//
//    
//    [BRStringPickerView showStringPickerWithTitle:nil dataSource:self.dataSource defaultSelValue:self.dataSource[0] isAutoSelect:YES resultBlock:^(id selectValue) {
//        //        weakSelf.genderTF.text = selectValue;
//    }];
    
    
}

//- (void)endAction:(UITextField *)tf
//{
//    [tf resignFirstResponder];
//
//}

- (void)changeAction:(UITextField *)tf
{
    
}

@end
