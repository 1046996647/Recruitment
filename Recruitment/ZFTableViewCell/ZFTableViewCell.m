//
//  ZFTableViewCell.m
//  ZFTableViewCell
//
//  Created by 任子丰 on 15/11/13.
//  Copyright (c) 2015年 任子丰. All rights reserved.
//

#import "ZFTableViewCell.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ZFTableViewCellbuttonWidth 60.0f
#define ZFTableViewCellNotificationEnableScroll @"ZFTableViewCellNotificationEnableScroll"
#define ZFTableViewCellNotificationUnenableScroll @"ZFTableViewCellNotificationUnenableScroll"

@interface ZFTableViewCell()<UIScrollViewDelegate>{
    

    ZFTableViewCellState _state;/** cell的状态*/
    UIPanGestureRecognizer* _panGesture;/** pan手势*/
    
    ZFTableViewCellType _type;/** cell的侧滑样式*/
    CGFloat _buttonWidth;//按钮长度
}
/** tableView*/
@property (nonatomic,assign) UITableView *tableView;
/** 按钮的标题*/
@property (nonatomic,copy) NSArray *rightButtonTitles;
/** 当前Cell的状态*/
@property (nonatomic,assign) ZFTableViewCellState state;
/** 右划显示btn的背景视图*/
@property (nonatomic,strong) UIView *buttonsView;

@end

@implementation ZFTableViewCell
/** 正在修改的cell*/
static ZFTableViewCell *_editingCell;
@dynamic state;

/**
 *  自定义Cell
 *
 *  @param style             cell的样式
 *  @param reuseIdentifier   cell的重用标示
 *  @param delegate          ZFTableViewCellDelegate代理
 *  @param tableView         tableView
 *  @param rowHeight         每一行cell的高度
 *  @param rightButtonTitles 右边按钮的标题数组
 *  @param rightButtonColors 右边按钮的背景颜色数组
 *
 *  @return 返回cell
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                     delegate:(id<ZFTableViewCellDelegate>)delegate
                  inTableView:(UITableView *)tableView
        withRightButtonTitles:(NSArray*)rightButtonTitles
        withRightButtonColors:(NSArray *)rightButtonColors
                         type:(ZFTableViewCellType)type
                    rowHeight:(NSInteger)rowHeight
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.tableView = tableView;
        self.delegate = delegate;
        
        _buttonWidth = 100;

        
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.contentSize = CGSizeMake(ScreenWidth + _buttonWidth * (rightButtonTitles.count), rowHeight);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:_scrollView];
        
        //cell的分享部分
        _shareView = [[ZFShareView alloc] initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, rowHeight)];
        _shareView.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:_shareView];
        
        //右边的Btn
        self.rightButtonTitles = rightButtonTitles;
        CGFloat leftButtonViewWidth = _buttonWidth * self.rightButtonTitles.count;
        _buttonsView = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth-leftButtonViewWidth, 0,
                                                               leftButtonViewWidth, rowHeight)];
        [self.scrollView addSubview:_buttonsView];
        
        // buttons数组初始化
        _buttons = [NSMutableArray array];
        
        CGFloat buttonHeight = rowHeight;
        for (int a = 0; a < self.rightButtonTitles.count; a++) {
            CGFloat left = a * (_buttonWidth);
            
            // 当做UIview来用
            UIButton* button = [[UIButton alloc]initWithFrame:CGRectMake(left, 0, _buttonWidth,buttonHeight)];
            button.autoresizingMask = UIViewAutoresizingFlexibleHeight;
            button.backgroundColor = rightButtonColors[a];
//            [button setTitle:self.rightButtonTitles[a] forState:UIControlStateNormal];

            [_buttonsView addSubview:button];
            
            
            if (type == ZFTableViewCellTypeOne) {

                NSArray *imgArr = @[@"102",@"103"];
                
                for (int i = 0; i < imgArr.count; i++) {
                    UIButton *oneButton = [UIButton buttonWithframe:CGRectMake(i*(_buttonWidth/2), 0, _buttonWidth/2, buttonHeight) text:nil font:nil textColor:nil backgroundColor:nil normal:imgArr[i] selected:nil];
                    oneButton.tag = i;
                    [button addSubview:oneButton];
                    [oneButton addTarget:self action:@selector(onButton:) forControlEvents:UIControlEventTouchUpInside];
//                    oneButton.backgroundColor = [UIColor yellowColor];
                }
                
            }
            else if (type == ZFTableViewCellTypeTwo) {
                
                NSArray *imgArr = @[@"31",@"9"];
                NSArray *titleArr = @[@"删除简历",@"邀请面试"];
                
                for (int i = 0; i < imgArr.count; i++) {
                    UIButton *twoButton = [UIButton buttonWithframe:CGRectMake(4, 10+i*(29+18), 84, 29) text:titleArr[i] font:SystemFont(14) textColor:@"#D0021B" backgroundColor:nil normal:imgArr[i] selected:nil];
                    twoButton.tag = i;
                    twoButton.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
                    [button addSubview:twoButton];
                    [twoButton addTarget:self action:@selector(onButton:) forControlEvents:UIControlEventTouchUpInside];
                    twoButton.layer.cornerRadius = 5;
                    twoButton.layer.masksToBounds = YES;
                    twoButton.layer.borderColor = [UIColor colorWithHexString:@"#D0021B"].CGColor;
                    twoButton.layer.borderWidth = 1;
                    
                    [_buttons addObject:twoButton];

                    
                }
                
            }else if (type == ZFTableViewCellTypeThree) {
                
                NSArray *imgArr = @[@"31-1",@"9-1"];
                NSArray *titleArr = @[@"删除",@"查看"];
                
                for (int i = 0; i < imgArr.count; i++) {
                    UIButton *twoButton = [UIButton buttonWithframe:CGRectMake(4, 10+i*(29+18), 84, 29) text:titleArr[i] font:SystemFont(14) textColor:@"#D0021B" backgroundColor:nil normal:imgArr[i] selected:nil];
                    twoButton.tag = i;
                    twoButton.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
                    twoButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8);
                    [button addSubview:twoButton];
                    [twoButton addTarget:self action:@selector(onButton:) forControlEvents:UIControlEventTouchUpInside];
                    twoButton.layer.cornerRadius = 5;
                    twoButton.layer.masksToBounds = YES;
                    twoButton.layer.borderColor = [UIColor colorWithHexString:@"#D0021B"].CGColor;
                    twoButton.layer.borderWidth = 1;
                    
                }
                
            } else if (type == ZFTableViewCellTypeFour) {
                
                NSArray *imgArr = @[@"9",@"31"];
                NSArray *titleArr = @[@"邀请信",@"删除"];
                
                for (int i = 0; i < imgArr.count; i++) {
                    UIButton *twoButton = [UIButton buttonWithframe:CGRectMake(4, 10+i*(29+18), 84, 29) text:titleArr[i] font:SystemFont(14) textColor:@"#D0021B" backgroundColor:nil normal:imgArr[i] selected:nil];
                    twoButton.tag = i;
                    twoButton.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
                    twoButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8);
                    [button addSubview:twoButton];
                    [twoButton addTarget:self action:@selector(onButton:) forControlEvents:UIControlEventTouchUpInside];
                    twoButton.layer.cornerRadius = 5;
                    twoButton.layer.masksToBounds = YES;
                    twoButton.layer.borderColor = [UIColor colorWithHexString:@"#D0021B"].CGColor;
                    twoButton.layer.borderWidth = 1;
                }
                
            } else if (type == ZFTableViewCellTypeFive) {
                
                NSArray *imgArr = @[@"31",@"43"];
                NSArray *titleArr = @[@"删除",@"修改"];
                
                for (int i = 0; i < imgArr.count; i++) {
                    UIButton *twoButton = [UIButton buttonWithframe:CGRectMake(4, 10+i*(29+18), 84, 29) text:titleArr[i] font:SystemFont(14) textColor:@"#D0021B" backgroundColor:nil normal:imgArr[i] selected:nil];
                    twoButton.tag = i;
                    twoButton.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
                    twoButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8);
                    [button addSubview:twoButton];
                    [twoButton addTarget:self action:@selector(onButton:) forControlEvents:UIControlEventTouchUpInside];
                    twoButton.layer.cornerRadius = 5;
                    twoButton.layer.masksToBounds = YES;
                    twoButton.layer.borderColor = [UIColor colorWithHexString:@"#D0021B"].CGColor;
                    twoButton.layer.borderWidth = 1;
                }
                
                
                
            } else {
                
                NSArray *imgArr = @[@"31",@"43"];
                NSArray *titleArr = @[@"取消收藏",@"分配职位"];
                
                for (int i = 0; i < imgArr.count; i++) {
                    UIButton *twoButton = [UIButton buttonWithframe:CGRectMake(4, 10+i*(29+18), 84, 29) text:titleArr[i] font:SystemFont(14) textColor:@"#D0021B" backgroundColor:nil normal:imgArr[i] selected:nil];
                    twoButton.tag = i;
                    twoButton.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
                    [button addSubview:twoButton];
                    [twoButton addTarget:self action:@selector(onButton:) forControlEvents:UIControlEventTouchUpInside];
                    twoButton.layer.cornerRadius = 5;
                    twoButton.layer.masksToBounds = YES;
                    twoButton.layer.borderColor = [UIColor colorWithHexString:@"#D0021B"].CGColor;
                    twoButton.layer.borderWidth = 1;
                }
                
            }
            

        }
        
        //cell的内容部分
        CGRect cellContentViewFrame = self.bounds;
        if ([self.tableView respondsToSelector:@selector(separatorInset)]){
            cellContentViewFrame = CGRectMake(0, 0, ScreenWidth, rowHeight);
        }
        _cellContentView = [[UIView alloc]initWithFrame:cellContentViewFrame];
        _cellContentView.backgroundColor = [UIColor whiteColor];
        [_scrollView addSubview:_cellContentView];
        
        
        
        UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapGesture:)];
        [self.cellContentView addGestureRecognizer:tapGesture];
        
   
        ///外部通知，把cell改为原来的状态
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationChangeToUnexpanded:) name:ZFTableViewCellNotificationChangeToUnexpanded object:nil];
        ///内部通知所有的cell可以滚动scrollView了
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationEnableScroll:) name:ZFTableViewCellNotificationEnableScroll object:nil];
        ///内部通知所有的cell不可以滚动scrollView(除当前编辑的这个外)
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationUnenableScroll:) name:ZFTableViewCellNotificationUnenableScroll object:nil];
    }
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)prepareForReuse{
    [super prepareForReuse];
    [self.scrollView setContentOffset:CGPointZero];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat height = self.bounds.size.height;
    _scrollView.frame = CGRectMake(0, 0, ScreenWidth, height);
    _shareView.frame = CGRectMake(ScreenWidth, 0, ScreenWidth, height);
    CGFloat leftButtonViewWidth = _buttonWidth * self.rightButtonTitles.count;
    _buttonsView.frame = CGRectMake(ScreenWidth-leftButtonViewWidth, 0,
                                    leftButtonViewWidth, height);
    _cellContentView.frame = self.bounds;
    
}

#pragma mark - Properties
-(void)setState:(ZFTableViewCellState)state{
    _state = state;
    if (state == ZFTableViewCellStateExpanded){
        [self.scrollView setContentOffset:CGPointMake(self.buttonsView.frame.size.width, 0.0f) animated:YES];
        _editingCell = self;
        ///通知所有的cell停止滚动(除自己这个)
        [[NSNotificationCenter defaultCenter] postNotificationName:ZFTableViewCellNotificationUnenableScroll object:nil];
        ///往tableView上添加一个手势处理,使得在tableView上的拖动也只是影响当前这个cell的scrollView
        if (!_panGesture){
            _panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(onPanGesture:)];
            [self.tableView addGestureRecognizer:_panGesture];
        }
    }
    else if(state == ZFTableViewCellStateUnexpanded){
        ///停止tableView的手势
        if (_panGesture){
            [self.tableView removeGestureRecognizer:_panGesture];
            _panGesture = nil;
        }
        ///为了不让快速按下时鼓动状态固定在一半，一开始就先停止触摸
        self.tableView.userInteractionEnabled = NO;
        double delayInSeconds = 0.3;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            self.tableView.userInteractionEnabled = YES;
        });
        ///
        [self.scrollView setContentOffset:CGPointZero animated:YES];
        ///tableView可以滚动了
        _editingCell = nil;
        self.tableView.scrollEnabled = YES;
        self.tableView.allowsSelection = YES;
        ///通知所有的cell可以滚动
        [[NSNotificationCenter defaultCenter] postNotificationName:ZFTableViewCellNotificationEnableScroll object:nil];
    }
    [UIView animateWithDuration:.3 animations:^{
        self.shareView.transform = CGAffineTransformMakeTranslation(ScreenWidth, 0);
    }];
}
-(ZFTableViewCellState)state{
    return _state;
}

#pragma mark - Action

-(void)onButton:(id)sender{
    NSIndexPath* indexPath = [self.tableView indexPathForCell:self];
    UIButton* button = (UIButton*)sender;
    if ([self.delegate respondsToSelector:@selector(buttonTouchedOnCell:atIndexPath:atButtonIndex:)]){
        [self.delegate buttonTouchedOnCell:self atIndexPath:indexPath atButtonIndex:button.tag];
    }
}

#pragma mark - Gesture

-(void)onTapGesture:(UITapGestureRecognizer*)recognizer{
    if (_editingCell){
        _editingCell.state = ZFTableViewCellStateUnexpanded;
    }
    else{
        if ([self.tableView.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]){
            NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:self];
            [self.tableView.delegate tableView:self.tableView didSelectRowAtIndexPath:cellIndexPath];
        }
    }
}

-(void)onPanGesture:(UIPanGestureRecognizer*)recognizer{
    if (!_editingCell)
    {
        [self.tableView removeGestureRecognizer:_panGesture];
        _panGesture = nil;
       return;
    }
    if (recognizer.state == UIGestureRecognizerStateChanged){
        CGFloat translate_x = [recognizer translationInView:_editingCell.tableView].x;
        CGFloat offset_x = self.buttonsView.frame.size.width;
        CGFloat move_offset_x = offset_x-translate_x;
        [_editingCell.scrollView setContentOffset:CGPointMake(move_offset_x, 0)];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded||
             recognizer.state == UIGestureRecognizerStateCancelled ||
             recognizer.state == UIGestureRecognizerStateFailed){
        _editingCell.state = ZFTableViewCellStateUnexpanded;
    }
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(scrollView.contentOffset.x < 0) {
        self.scrollView.scrollEnabled = NO;
        return;
    }
    self.scrollView.scrollEnabled = YES;
    self.buttonsView.transform = CGAffineTransformMakeTranslation(scrollView.contentOffset.x, 0.0f);
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    self.scrollView.scrollEnabled = YES;
    if (scrollView.contentOffset.x >= self.buttonsView.frame.size.width / self.rightButtonTitles.count){
        self.state = ZFTableViewCellStateExpanded;
    }else if(scrollView.contentOffset.x < 0) {
        self.scrollView.scrollEnabled = NO;
        return;
    }else{
        self.state = ZFTableViewCellStateUnexpanded;
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if(scrollView.contentOffset.x < 0) {
        self.scrollView.scrollEnabled = NO;
        return;
    }
    scrollView.scrollEnabled = YES;
}

#pragma mark - Notififcation

///外部通知，把cell改为原来的状态
-(void)notificationChangeToUnexpanded:(NSNotification*)notification{
    self.state = ZFTableViewCellStateUnexpanded;
}
///内部通知所有的cell可以滚动scrollView了
-(void)notificationEnableScroll:(NSNotification*)notification{
    [self.scrollView setContentOffset:CGPointZero animated:YES];
}
///内部通知所有的cell不可以滚动scrollView(除当前编辑的这个外)
-(void)notificationUnenableScroll:(NSNotification*)notification{
    if (_editingCell != self) {
        self.scrollView.scrollEnabled = YES;
        [self.scrollView setContentOffset:CGPointZero animated:YES];
        [UIView animateWithDuration:.3 animations:^{
            self.shareView.transform = CGAffineTransformMakeTranslation(ScreenWidth, 0);
        }];
    }
}@end
