//
//  PersonalMessageCell.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/9.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "PersonalMessageCell.h"

@implementation PersonalMessageCell

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

- (void)setModel:(PersonalModel *)model
{
    _model = model;
    
    self.imageView.image = [UIImage imageNamed:model.image];
    _tf.placeholder = model.title;
}

- (void)beginAction:(UITextField *)tf
{
    if ([_model.title isEqualToString:@"姓名"] || [_model.title isEqualToString:@"意向岗位"]) {
        return;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [tf resignFirstResponder];

    });
    
    if ([_model.title isEqualToString:@"最高学历"]) {
        self.dataSource = @[@"初中", @"高中|中专", @"大专",@"本科", @"硕士", @"博士"];
    }
    if ([_model.title isEqualToString:@"工作年限"]) {
        self.dataSource = @[@"应届毕业生", @"一年", @"两年",@"三年", @"四年", @"五年",@"六年", @"七年", @"八年",@"九年", @"十年以上", @"十五年以上"];
    }
    if ([_model.title isEqualToString:@"期望薪资"]) {
        self.dataSource = @[@"面议", @"1k以下", @"1-1.5k",@"1.5-2k", @"2.5-3k", @"3.5-4k",@"4-5k", @"5-6k", @"6-7k",@"7-8k", @"8-12k", @"12k以上"];
    }
    if ([_model.title isEqualToString:@"意向城市"]) {
        self.dataSource = @[@"义乌市", @"金华市", @"杭州市",];
    }

    [BRStringPickerView showStringPickerWithTitle:nil dataSource:self.dataSource defaultSelValue:self.dataSource[0] isAutoSelect:YES resultBlock:^(id selectValue) {
//        weakSelf.genderTF.text = selectValue;
    }];
    

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
