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

- (void)setModel:(PersonModel *)model
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
        
        for (NSDictionary *dic in self.selectArr) {
            if ([dic[@"name"] isEqualToString:@"comp_edu"]) {
                
                NSString *str = dic[@"data"];
                self.dataSource = [str componentsSeparatedByString:@","];
                break;
            }
        }
    }
    if ([_model.title isEqualToString:@"工作年限"]) {
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSDictionary *dic in self.selectArr) {
            if ([dic[@"name"] isEqualToString:@"comp_years"]) {
                
                NSString *str = dic[@"data"];
                NSArray *arr = [str componentsSeparatedByString:@","];
                
                for (NSString *s in arr) {
                    NSString *s1 = [NSString stringWithFormat:@"%@年",s];
                    [arrM addObject:s1];
                }
                self.dataSource = arrM;
                break;
            }
        }

    }
    if ([_model.title isEqualToString:@"期望薪资"]) {
        for (NSDictionary *dic in self.selectArr) {
            if ([dic[@"name"] isEqualToString:@"comp_pay"]) {
                
                NSString *str = dic[@"data"];
                self.dataSource = [str componentsSeparatedByString:@","];
                break;
            }
        }
    }
    if ([_model.title isEqualToString:@"意向城市"]) {
        self.dataSource = @[@"义乌市", @"东阳市", @"金华市",@"浦江县",@"永康市",@"慈溪市",@"余姚市"];
    }

    [BRStringPickerView showStringPickerWithTitle:nil dataSource:self.dataSource defaultSelValue:self.dataSource[0] isAutoSelect:NO resultBlock:^(id selectValue) {
        
        _tf.text = selectValue;
        
        if ([_model.title isEqualToString:@"工作年限"]||
            [_model.title isEqualToString:@"工作经验"]) {
            
            _model.text = [_model.text substringToIndex:_model.text.length-1];
            NSLog(@"-----%@",selectValue);
            
        }
        
//        if ([_model.title isEqualToString:@"意向城市"]) {
//
//            _model.text = selectValue;
//
//        }
//        else {
//            _model.text = [NSString stringWithFormat:@"%ld",[self.dataSource indexOfObject:selectValue]+1];
//
//        }
        
        
    }];
    

}

//- (void)endAction:(UITextField *)tf
//{
//    [tf resignFirstResponder];
//
//}

- (void)changeAction:(UITextField *)tf
{
    _model.text = tf.text;
}


@end
