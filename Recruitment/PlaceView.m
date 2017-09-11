//
//  PlaceView.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/9.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "PlaceView.h"
#import "HotJobCell.h"

@implementation PlaceView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame ];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:108/255.0 green:108/255.0 blue:108/255.0 alpha:.4];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [self addGestureRecognizer:tap];
        
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0)];
        baseView.backgroundColor = [UIColor whiteColor];
        [self addSubview:baseView];

        
        UILabel *hotLab = [UILabel labelWithframe:CGRectMake(16, 18, 50, 17) text:@"城市" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentRight textColor:@"#333333"];
        [baseView addSubview:hotLab];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(hotLab.left, hotLab.bottom+7, kScreen_Width-hotLab.left*2, 1)];
        line.backgroundColor = [UIColor colorWithHexString:@"#C7C7C7"];
        [baseView addSubview:line];
        
        //
        CGFloat width = (kScreen_Width-24-23*2)/3;
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(width, 26);
        //    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 12;
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, line.bottom+11, kScreen_Width,26*2+12) collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        //        collectionView.scrollsToTop = NO;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        [collectionView registerClass:[HotJobCell class] forCellWithReuseIdentifier:@"cellID"];
        collectionView.contentInset = UIEdgeInsetsMake(0, 12, 0, 12);
        [baseView addSubview:collectionView];
        
        baseView.height = collectionView.bottom+12;
    }
    
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //    return self.model.images.count;
    return 6;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self removeFromSuperview];
    self.imgView.image = [UIImage imageNamed:@"55"];

}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HotJobCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    cell.jobLab.text = @"义乌";
    return cell;
    
}

- (void)tapAction
{
    [self removeFromSuperview];
    self.imgView.image = [UIImage imageNamed:@"55"];

}

@end
