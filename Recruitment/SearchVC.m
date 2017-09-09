//
//  SearchVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/7.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "SearchVC.h"
#import "HotJobCell.h"

@interface SearchVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate>

@property(nonatomic,strong) UISearchBar *searchBar;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UIButton *cancelBtn;



@end

@implementation SearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.backButton = nil;

    
    UIButton *cancelBtn = [UIButton buttonWithframe:CGRectMake(0, 0, 26, 17) text:@"取消" font:[UIFont systemFontOfSize:12] textColor:@"#333333" backgroundColor:nil normal:nil selected:nil];
    [cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    self.cancelBtn = cancelBtn;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn];

    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width-12-54, 21)];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"搜索";
//    _searchBar.showsCancelButton = YES;
//    _searchBar.tintColor = [UIColor colorWithHexString:@"#f99740"];// "取消"字体颜色和光标颜色
    [_searchBar setBackgroundImage:[UIImage new]];
//    _searchBar.barTintColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_searchBar];
    
    // 边框设置
    UITextField *searchField = [_searchBar valueForKey:@"searchField"];
    searchField.layer.cornerRadius = _searchBar.height/2;
    searchField.layer.masksToBounds = YES;
    searchField.font = [UIFont systemFontOfSize:12];
    [searchField setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];// 设置这里时searchTF.font也要设置不然会偏上

    
    // 尾视图
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0)];
    
    UILabel *hotLab = [UILabel labelWithframe:CGRectMake(16, 18, 50, 17) text:@"热门职位" font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentRight textColor:@"#999999"];
    [footView addSubview:hotLab];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(hotLab.left, hotLab.bottom+7, kScreen_Width-hotLab.left*2, 1)];
    line.backgroundColor = [UIColor colorWithHexString:@"#C7C7C7"];
    [footView addSubview:line];
    
    //
    CGFloat width = (kScreen_Width-24-23*2)/3;
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(width, 26);
//    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 5;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, line.bottom+11, kScreen_Width,26*2+10) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    //        collectionView.scrollsToTop = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    [collectionView registerClass:[HotJobCell class] forCellWithReuseIdentifier:@"cellID"];
    collectionView.contentInset = UIEdgeInsetsMake(0, 12, 0, 12);
    [footView addSubview:collectionView];
    
    footView.height = collectionView.bottom;
    
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64)];
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = footView;

}

- (void)cancelAction
{

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    return self.model.images.count;
    return 6;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HotJobCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
//    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:self.model.images[indexPath.item]]];
    return cell;
    
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
}




@end
