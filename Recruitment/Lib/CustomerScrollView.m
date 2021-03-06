//
//  CustomerScrollView.m
//  colloctionViewTest
//
//  Created by jerry on 16/12/15.
//  Copyright © 2016年 jerry. All rights reserved.
//

#import "CustomerScrollView.h"



#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define NavBarH 64
#define TabBarH 44
#define WIDTH_RATE (SCREEN_WIDTH/375)   // 屏幕宽度系数（以4.7英寸为基准）
#define HEIGHT_RATE (SCREEN_HEIGHT/667)

//#define BGColor [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0]
#define NumberOfSinglePage 8 // 一个页面可容纳的最多按钮数
#define leftRightGap 25*WIDTH_RATE
#define topBottomGap 25
#define ViewMargin 20
#define BtnWH 65

@interface CustomerScrollView ()<UIScrollViewDelegate>
@property (nonatomic,weak) UIScrollView * contentScrollView;
@property (nonatomic,strong) UIPageControl * pageControl;
@end

@implementation CustomerScrollView

#pragma mark - getter


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 属性初始值
        self.viewSize = CGSizeMake(BtnWH, BtnWH);
        self.numberOfSinglePage = NumberOfSinglePage;
        self.viewGap = leftRightGap;
        self.viewMargin = ViewMargin;
        
        // 初始化
        [self initDataAndSubviews];

    }
    return self;
}

-(void)initDataAndSubviews{

    
    UIScrollView * contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _contentScrollView = contentScrollView;
    _contentScrollView.delegate = self;
    contentScrollView.backgroundColor = [UIColor whiteColor];
    contentScrollView.pagingEnabled = YES;
    contentScrollView.showsVerticalScrollIndicator = NO;
    contentScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:contentScrollView];

//    // 添加pageControl
//    UIPageControl * pageControl = [[UIPageControl alloc] init];
//    pageControl.frame = CGRectMake(SCREEN_WIDTH/2, self.height-20, 0, 0);
//    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
//    pageControl.currentPageIndicatorTintColor = [UIColor darkGrayColor];
//    pageControl.hidesForSinglePage = YES;
//    pageControl.numberOfPages = pageCount;
//    _pageControl = pageControl;
//    [self addSubview:_pageControl];
//    [self bringSubviewToFront:_pageControl];
    
}

// 循环添加按钮
-(void)addBtnsWithPageNum:(NSInteger)number{
    
    // 添加按钮
    NSInteger maxCol = 4;
    NSInteger maxRow = 2;
    
    CGFloat btnW = self.viewSize.width * WIDTH_RATE;
    CGFloat btnH = self.viewSize.height * HEIGHT_RATE;
    CGFloat leftRightMargin = (SCREEN_WIDTH - (maxCol * btnW + (maxCol-1) * leftRightGap))/2; // 左右内边距;
    CGFloat topBottomMargin = (self.height - (maxRow * btnH + (topBottomGap+0)))/2;
    
    NSInteger count = self.dataArr.count - (number * self.numberOfSinglePage);
    NSInteger indexCount;
    if (count > 0 && count <= self.numberOfSinglePage) {
        
        indexCount = count;
    }else if(count > self.numberOfSinglePage){
        
        indexCount = self.numberOfSinglePage;
    }else{
        
        return;
    }
    
    NSLog(@"btnCount:%ld",indexCount);

    for (int i = 0; i<indexCount; i++) {
        UIButton  * btn = [[UIButton alloc] init];
        
        int col = i % maxCol;
        int row = i / maxCol;
        NSInteger index = i + number * self.numberOfSinglePage;
        NSDictionary * btnDic = self.dataArr[index];
        
        //设置图片内容（使图片和文字水平居中显示）
//        btn.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
//        btn.backgroundColor = [UIColor orangeColor];
//        [btn setTitle:btnDic[@"name"] forState:UIControlStateNormal];
//        [btn setImage:[UIImage imageNamed:btnDic[@"image"]] forState:UIControlStateNormal];
//        [btn sd_setImageWithURL:[NSURL URLWithString:btnDic[@"img"]] forState:UIControlStateNormal];
        //[btn setTitle:btnDic[@"title"] forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
//        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        // 设置图片frame
        
        btn.x = col * (btnW + leftRightGap) + leftRightMargin + number * self.width;
        btn.y = row * (btnH + topBottomGap) + topBottomMargin;
        
        btn.width = btnW;
        btn.height = btnH;
        btn.tag = index;
        
//        [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.currentImage.size.height+20 ,-btn.imageView.frame.size.width, 0,0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
//        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, (btn.width - btn.imageView.width)/2 ,0 ,0)];//图片距离右边框距离减少图片的宽度，其它不变
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *imgView = [UIImageView imgViewWithframe:CGRectMake(0, 0, btn.width, btn.height-20) icon:nil];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        [imgView sd_setImageWithURL:[NSURL URLWithString:btnDic[@"img"]]];
         [btn addSubview:imgView];

         UILabel *lab = [UILabel labelWithframe:CGRectMake(0, btn.height-20, btn.width, 20) text:btnDic[@"name"] font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentCenter textColor:@"#333333"];
         [btn addSubview:lab];
        
        [_contentScrollView addSubview:btn];
    }

}

// 按钮点击事件

-(void)btnClick:(UIButton *)btn{
    
    NSLog(@"click:%ld",btn.tag);
    
    if (self.block) {
        self.block(self.dataArr[btn.tag]);
    }
}

- (void)setDataArr:(NSArray *)dataArr
{
    _dataArr = dataArr;
    
    for (UIView *view in _contentScrollView.subviews) {
        [view removeFromSuperview];
        NSLog(@"%@",view);
    }
    
//    if (!self.dataArr) {
//        // 加载默认测试数据
//        NSLog(@"加载测试数据");
//        NSString * dataPath = [[NSBundle mainBundle] pathForResource:@"funKeyboardData.plist" ofType:nil];
//        _dataArr = [NSArray arrayWithContentsOfFile:dataPath];
//    }
    
    NSInteger pageCount = self.dataArr.count / self.numberOfSinglePage;
    if (self.dataArr.count % self.numberOfSinglePage > 0) {
        pageCount += 1;
    }
    
    NSLog(@"pageCount:%ld",pageCount);
    
    _contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * pageCount, self.frame.size.height);
    
    for (int i = 0; i < pageCount; i++) {
        [self addBtnsWithPageNum:i];
    }
    

}

#pragma mark - scroll delegate 

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//
//    NSInteger correntCount = (scrollView.contentOffset.x + self.width/2)/self.width;
//    self.pageControl.currentPage = correntCount;
//}

@end
