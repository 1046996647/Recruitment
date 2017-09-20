//
//  SearchVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/7.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "SearchVC.h"
#import "HotJobCell.h"
#import "SearchCell.h"

#define HistoryPath @"HistoryPath"


@interface SearchVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UISearchBar *searchBar;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UIButton *cancelBtn;
@property(nonatomic,strong) NSMutableArray *hisArr;



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
    [footView addSubview:collectionView];
    
    footView.height = collectionView.bottom;
    
    // 搜索历史记录
    _hisArr = [[InfoCache getValueForKey:HistoryPath] mutableCopy];
    if (!_hisArr) {
        _hisArr = [NSMutableArray array];
        
    }
    
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64)];
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = footView;
    _tableView.delegate = self;
    _tableView.dataSource = self;

}

- (void)cancelAction
{

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)deleteAction:(UIButton *)btn
{
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    return [self.dataArr count];
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 12+28;
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 12+28)];
    UIButton *delBtn = [UIButton buttonWithframe:CGRectMake((kScreen_Width-150)/2, 0, 150, 28) text:@"删除所有记录" font:[UIFont systemFontOfSize:12] textColor:@"#C70000" backgroundColor:@"#FFFFFF" normal:@"37" selected:nil];
    delBtn.layer.cornerRadius = 5;
    delBtn.layer.masksToBounds = YES;
    delBtn.layer.borderColor = [UIColor colorWithHexString:@"#C70000"].CGColor;
    delBtn.layer.borderWidth = 1;
    [view addSubview:delBtn];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 1)];
    line.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
    [view addSubview:line];

    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[SearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.delBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];

    }
    
    cell.delBtn.tag = indexPath.row;
    
    return cell;
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    return self.model.images.count;
    return 6;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
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
    if (searchBar.text.length == 0) {
        [searchBar resignFirstResponder];
        
        return;
    }
    
    [searchBar resignFirstResponder];
    //    [self pushAction:textField.text];
    if (![self.hisArr containsObject:searchBar.text]) {
        [self.hisArr addObject:searchBar.text];
        [InfoCache saveValue:_hisArr forKey:HistoryPath];
        [self.tableView reloadData];
    }
}

// 搜索结果
//- (void)pushAction:(NSString *)text
//{
//    SearchResultVC *vc = [[SearchResultVC alloc] init];
//    vc.title = @"搜索结果";
//    vc.longitude = self.longitude;
//    vc.latitude = self.latitude;
//    vc.searchText = text;
//    [self.navigationController pushViewController:vc animated:YES];
//}


@end
