//
//  ReceiveMsgCell.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/18.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ReceiveMsgCell.h"

@implementation ReceiveMsgCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                     delegate:(id<ZFTableViewCellDelegate>)delegate
                  inTableView:(UITableView *)tableView
        withRightButtonTitles:(NSArray *)rightButtonTitles
        withRightButtonColors:(NSArray *)rightButtonColors type:(ZFTableViewCellType)type
                    rowHeight:(NSInteger)rowHeight
{
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier
                       delegate:delegate
                    inTableView:tableView
          withRightButtonTitles:rightButtonTitles
          withRightButtonColors:rightButtonColors
                           type:type
                      rowHeight:(NSInteger)rowHeight];
    
    if (self){
        
        self.scrollView.backgroundColor = [UIColor colorWithHexString:@"#efefef"];
        self.cellContentView.backgroundColor = [UIColor clearColor];
        
        _selectBtn = [UIButton buttonWithframe:CGRectMake(0, 0, 35, 100) text:@"" font:nil textColor:nil backgroundColor:nil normal:@"31" selected:@"Rectangle 12"];
        [self.cellContentView addSubview:_selectBtn];
        [_selectBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];

        
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(_selectBtn.right, 0, kScreen_Width-_selectBtn.right-10, 100)];
        //        baseView.layer.cornerRadius = 10;
        //        baseView.layer.masksToBounds = YES;
        baseView.backgroundColor = [UIColor whiteColor];
        [self.cellContentView addSubview:baseView];
        
        
        _timeLab = [UILabel labelWithframe:CGRectMake(baseView.width-50-8, 8, 50, 13) text:@"12:18:30" font:[UIFont systemFontOfSize:11] textAlignment:NSTextAlignmentRight textColor:@"#999999"];
        [baseView addSubview:_timeLab];
        
        _nameLab = [UILabel labelWithframe:CGRectMake(19, 19, baseView.width-19-60, 17) text:@"凌小慧" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#F5A623"];
        [baseView addSubview:_nameLab];

        
//        _typeLab = [UILabel labelWithframe:CGRectMake(_nameLab.left, _nameLab.bottom+7, baseView.width-_nameLab.left-12, 16) text:@"类型：回复" font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
//        [baseView addSubview:_typeLab];
        
        _contenLab = [UILabel labelWithframe:CGRectMake(_nameLab.left, _nameLab.bottom+7, baseView.width-_nameLab.left-12, 16) text:@"信息内容：知道了，谢谢您！" font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
        [baseView addSubview:_contenLab];
        
    }
    
    return self;
    
}

- (void)selectAction:(UIButton *)btn
{
    _model.isSelected = !_model.isSelected;
    btn.selected = _model.isSelected;
    
    if (self.block) {
        self.block(_model);
    }
}

- (void)setModel:(ReceiveMsgModel *)model
{
    _model = model;
    
    _nameLab.text = model.title;
    _contenLab.text = [NSString stringWithFormat:@"信息内容：%@",model.info];;
//    _typeLab.text = [NSString stringWithFormat:@"类型：%@",model.type];
    _timeLab.text = model.addTime;

    _selectBtn.selected = _model.isSelected;

}









@end
