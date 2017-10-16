//
//  PlaceView.h
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/9.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PlaceBlock)(NSString *place);

@interface PlaceView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) UIImageView *imgView;
@property(nonatomic,strong) NSArray *dataArr;
@property(nonatomic,copy) PlaceBlock block;


@end
