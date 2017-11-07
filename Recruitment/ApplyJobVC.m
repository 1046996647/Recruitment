//
//  ApplyJobVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/8.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ApplyJobVC.h"
#import "JobCell.h"
#import "JobView.h"
#import "JobDetailVC.h"
#import "LoginVC.h"
#import "DiySearchBar.h"
#import "NSStringExt.h"

@interface ApplyJobVC ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property(nonatomic,strong) UIButton *forgetBtn1;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) DiySearchBar *searchBar;
@property(nonatomic,strong) UIButton *lastBtn;
@property(nonatomic,strong) JobView *jobview;
@property(nonatomic,strong) UIButton *applyBtn;

@property(nonatomic,assign) NSInteger pageNO;
@property(nonatomic,strong) NSMutableArray *modelArr;
@property (nonatomic,assign) BOOL isRefresh;

@property(nonatomic,strong) NSString *cate_id;
@property(nonatomic,strong) NSString *order;
@property(nonatomic,strong) NSDictionary *data;

@property(nonatomic,strong) NSMutableArray *selectedArr;// 选择数组


@end

@implementation ApplyJobVC


- (JobView *)jobview
{
    if (!_jobview) {
        
        __weak typeof(self) weakSelf = self;
        _jobview = [[JobView alloc] initWithFrame:CGRectMake(0, 40, kScreen_Width, kScreen_Height-(64+40))];
        _jobview.block = ^(id obj, NSInteger tag) {
            
            weakSelf.lastBtn.selected = NO;
            
            UILabel *label = [weakSelf.lastBtn viewWithTag:100+weakSelf.lastBtn.tag];
            UIImageView *imgView = [weakSelf.lastBtn viewWithTag:101+weakSelf.lastBtn.tag];
            label.textColor = [UIColor colorWithHexString:@"#333333"];
            imgView.image = [UIImage imageNamed:@"33"];

            
            if (tag == 0) {
                
                weakSelf.cate_id = obj;
            }
            if (tag == 1) {
                weakSelf.order = obj;

            }
            if (tag == 2) {
                weakSelf.data = obj;

            }
            
            // 进入刷新状态
            [weakSelf.tableView.mj_header beginRefreshing];
            
        };
    }
    return _jobview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _searchBar = [[DiySearchBar alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width-14-54, 30)];
    _searchBar.delegate = self;
//    _searchBar.placeholder = @"搜索";
    //    _searchBar.showsCancelButton = YES;
    //    _searchBar.tintColor = [UIColor colorWithHexString:@"#f99740"];// "取消"字体颜色和光标颜色
    [_searchBar setBackgroundImage:[UIImage new]];
    //    _searchBar.barTintColor = [UIColor colorWithHexString:@"#FFFFFF"];

    if (![self.searchText isEqualToString:@"附近工作"]) {
        _searchBar.text = self.searchText;

    }
//    _searchBar.backgroundColor = [UIColor redColor];
    
    // 边框设置
    UITextField *searchField = [_searchBar valueForKey:@"searchField"];
    searchField.layer.cornerRadius = _searchBar.height/2;
    searchField.layer.masksToBounds = YES;
    searchField.font = [UIFont systemFontOfSize:12];
    [searchField setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];// 设置这里时searchTF.font也要设置不然会偏上
    
    UIView *view = [[UIView alloc] initWithFrame:_searchBar.bounds];
    [view addSubview:_searchBar];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];

    
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64-40)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreen_Height-64-40, kScreen_Width, 40)];
    [self.view addSubview:bottomView];

    UIButton *selectBtn = [UIButton buttonWithframe:CGRectMake(0, 0, 100, bottomView.height) text:@"全选" font:[UIFont systemFontOfSize:14] textColor:@"#333333" backgroundColor:@"#FFFFFF" normal:nil selected:nil];
    [bottomView addSubview:selectBtn];
    [selectBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *applyBtn = [UIButton buttonWithframe:CGRectMake(selectBtn.right, 0, kScreen_Width-selectBtn.right, bottomView.height) text:@"申请职位" font:[UIFont systemFontOfSize:14] textColor:@"#FFFFFF" backgroundColor:@"#666666" normal:nil selected:nil];
    [bottomView addSubview:applyBtn];
    self.applyBtn = applyBtn;
    applyBtn.userInteractionEnabled = NO;
    [applyBtn addTarget:self action:@selector(applyAction) forControlEvents:UIControlEventTouchUpInside];

    
    // 下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self headerRefresh];
    }];
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;
    
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        if (self.modelArr.count > 0) {
            // 搜索职位
            [self get_jobs_list];
        }
        
    }];

    self.pageNO = 1;
    self.modelArr = [NSMutableArray array];
    self.selectedArr = [NSMutableArray array];

    
    // 搜索职位
    [self get_jobs_list];
    

}


- (void)applyAction
{
    PersonModel *model = [InfoCache unarchiveObjectWithFile:Person];
    if (!model) {
        LoginVC *vc = [[LoginVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
        return;
    }
    
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    
    // 公司id
    NSMutableArray *cidArr = [NSMutableArray array];
    for (JobModel *model in self.selectedArr) {
        [cidArr addObject:model.companyId];
    }
    NSString *string1 = [cidArr componentsJoinedByString:@","]; //,为分隔符
    [paraDic setValue:string1 forKey:@"companyId"];

    // 职位id
    NSMutableArray *idArr = [NSMutableArray array];
    for (JobModel *model in self.selectedArr) {
        [idArr addObject:model.ID];
    }
    NSString *string = [idArr componentsJoinedByString:@","]; //,为分隔符
    [paraDic setValue:string forKey:@"id"];
    
    // 有问题：申请成功后 收藏字段还是0
    [AFNetworking_RequestData requestMethodPOSTUrl:Send_resume dic:paraDic showHUD:YES Succed:^(id responseObject) {


    } failure:^(NSError *error) {


    }];

}

- (void)selectAction:(UIButton *)btn
{
    if ([btn.currentTitle isEqualToString:@"全选"]) {
        [btn setTitle:@"全不选" forState:UIControlStateNormal];
        
        for (JobModel *model in self.modelArr) {
            model.isSelected = YES;
            
            if (![self.selectedArr containsObject:model]) {
                [self.selectedArr addObject:model];
            }
        }
        self.applyBtn.backgroundColor = [UIColor colorWithHexString:@"#FDA326"];
        self.applyBtn.userInteractionEnabled = YES;

    }
    else {
        [btn setTitle:@"全选" forState:UIControlStateNormal];
        for (JobModel *model in self.modelArr) {
            model.isSelected = NO;
            
        }
        [self.selectedArr removeAllObjects];
        self.applyBtn.backgroundColor = [UIColor colorWithHexString:@"#666666"];
        self.applyBtn.userInteractionEnabled = NO;

    }

    [_tableView reloadData];
}

- (void)headerRefresh
{
    self.pageNO = 1;
    if (self.modelArr.count > 0) {
        [self.modelArr removeAllObjects];
        
    }
    [self get_jobs_list];
}

- (void)get_jobs_list
{
    if (!self.isRefresh) {
        [SVProgressHUD show];
        
    }

    // key/关键字/p/当前页码/size/每页显示条数
    NSString *urlStr = [NSString stringWithFormat:@"%@/key/%@/p/%ld",Get_jobs_list,self.searchText,self.pageNO];
    
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    if (self.cate_id) {
        [paraDic setValue:self.cate_id forKey:@"cateId"];
    }
    if (self.order) {
        [paraDic setValue:self.order forKey:@"order"];
    }
    if (self.data) {
        [paraDic setValue:self.data forKey:@"data"];
    }
//    [paraDic setValue:@87 forKey:@"cateid"];

    NSLog(@"paraDic:%@",paraDic);
    
    [AFNetworking_RequestData requestMethodPOSTUrl:urlStr dic:paraDic showHUD:NO Succed:^(id responseObject) {
        
        self.isRefresh = YES;
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        NSArray *arr = responseObject[@"data"];
        if ([arr count]) {
            
            NSMutableArray *arrM = [NSMutableArray array];
            for (NSDictionary *dic in arr) {
                JobModel *model = [JobModel yy_modelWithJSON:dic];
                [arrM addObject:model];
            }
            
            [self.modelArr addObjectsFromArray:arrM];
            
            self.pageNO++;
        }
        else {
            
            // 拿到当前的上拉刷新控件，变为没有更多数据的状态
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        [self.tableView reloadData];

        
    } failure:^(NSError *error) {
        
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}

- (void)btnAction:(UIButton *)btn
{
    
    [self.view addSubview:self.jobview];
    self.jobview.aTag = btn.tag;
    
    if (self.lastBtn != btn) {
        
        UILabel *label = [self.lastBtn viewWithTag:100+self.lastBtn.tag];
        UIImageView *imgView = [self.lastBtn viewWithTag:101+self.lastBtn.tag];
        label.textColor = [UIColor colorWithHexString:@"#333333"];
        imgView.image = [UIImage imageNamed:@"33"];
        
        label = [btn viewWithTag:100+btn.tag];
        imgView = [btn viewWithTag:101+btn.tag];
        label.textColor = [UIColor colorWithHexString:@"#FF9123"];
        imgView.image = [UIImage imageNamed:@"Triangle"];
        
    }
    else {
        
        btn.selected = !btn.selected;
        
        UILabel *label = [btn viewWithTag:100+btn.tag];
        UIImageView *imgView = [btn viewWithTag:101+btn.tag];
        
        if (btn.selected) {
            label.textColor = [UIColor colorWithHexString:@"#FF9123"];
            imgView.image = [UIImage imageNamed:@"Triangle"];
        }
        else {
            
            [self.jobview removeFromSuperview];
            label.textColor = [UIColor colorWithHexString:@"#333333"];
            imgView.image = [UIImage imageNamed:@"33"];
        }
    }

    self.lastBtn = btn;
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.modelArr count];
//    return 20;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    JobModel *model = self.modelArr[indexPath.row];

    JobDetailVC *vc = [[JobDetailVC alloc] init];
    vc.title = @"职位详情";
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 40)];
    view.backgroundColor = [UIColor whiteColor];
    
    NSArray *titleArr1 = @[@"行业类型",@"排序",@"筛选"];
    for (int i=0; i<titleArr1.count; i++) {
        
        UIButton *forgetBtn = [UIButton buttonWithframe:CGRectMake(i*kScreen_Width/3, 0, kScreen_Width/3, view.height) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:nil selected:nil];
        [view addSubview:forgetBtn];
        [forgetBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        forgetBtn.tag = i;
        
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectZero];
        [forgetBtn addSubview:baseView];
        baseView.userInteractionEnabled = NO;
        
        CGSize size = [NSString textLength:titleArr1[i] font:[UIFont systemFontOfSize:12]];
        
        UILabel *label1 = [UILabel labelWithframe:CGRectMake(0, 0, size.width, view.height) text:titleArr1[i] font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentCenter textColor:@"#333333"];
        [baseView addSubview:label1];
        label1.tag = 100+forgetBtn.tag;
        
        UIImageView *imgView = [UIImageView imgViewWithframe:CGRectMake(label1.right+8, (forgetBtn.height-3)/2, 8, 6) icon:@"33"];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        [baseView addSubview:imgView];
        imgView.tag = 101+forgetBtn.tag;
        
        baseView.frame = CGRectMake((forgetBtn.width-imgView.right)/2, 0, imgView.right, forgetBtn.height);

        
        if (i == 0) {
            
            self.lastBtn = forgetBtn;

        }

        
        if (i < titleArr1.count) {
            
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(forgetBtn.width-1, 8, 1, view.height-16)];
            line.backgroundColor = [UIColor colorWithHexString:@"#C7C7C7"];
            [forgetBtn addSubview:line];

        }
        
    }
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, view.bottom-.5, kScreen_Width, .5)];
    line.backgroundColor = [UIColor colorWithHexString:@"#C7C7C7"];
    [view addSubview:line];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JobCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[JobCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.block = ^(JobModel *model) {
            if (model.isSelected) {
                [self.selectedArr addObject:model];

            }
            else {
                [self.selectedArr removeObject:model];
            }
            
            if (self.selectedArr.count>0) {
                self.applyBtn.backgroundColor = [UIColor colorWithHexString:@"#FDA326"];
                self.applyBtn.userInteractionEnabled = YES;

            }
            else {
                self.applyBtn.backgroundColor = [UIColor colorWithHexString:@"#666666"];
                self.applyBtn.userInteractionEnabled = NO;

            }

        };
    }

    cell.type = 1;
    
    if (self.modelArr.count > 0) {
        JobModel *model = self.modelArr[indexPath.row];
        cell.model = model;
    }

    return cell;
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.lastBtn.selected = NO;
    [self.jobview removeFromSuperview];
    
    if (searchBar.text.length == 0) {
        [searchBar resignFirstResponder];
        
        return;
    }
    
    [searchBar resignFirstResponder];

    self.searchText = searchBar.text;
    // 进入刷新状态
    [self.tableView.mj_header beginRefreshing];
}


@end
