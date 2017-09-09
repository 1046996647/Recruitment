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

@interface ApplyJobVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UIButton *forgetBtn1;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UISearchBar *searchBar;
@property(nonatomic,strong) UIButton *lastBtn;
@property(nonatomic,strong) JobView *jobview;


@end

@implementation ApplyJobVC

- (JobView *)jobview
{
    if (!_jobview) {
        _jobview = [[JobView alloc] initWithFrame:CGRectMake(0, 31, kScreen_Width, kScreen_Height-(64+31))];
    }
    return _jobview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width-14-54, 21)];
//    _searchBar.delegate = self;
//    _searchBar.placeholder = @"搜索";
    //    _searchBar.showsCancelButton = YES;
    //    _searchBar.tintColor = [UIColor colorWithHexString:@"#f99740"];// "取消"字体颜色和光标颜色
    [_searchBar setBackgroundImage:[UIImage new]];
    //    _searchBar.barTintColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_searchBar];

//    self.navigationItem.titleView = _searchBar;
    
    // 边框设置
    UITextField *searchField = [_searchBar valueForKey:@"searchField"];
    searchField.layer.cornerRadius = _searchBar.height/2;
    searchField.layer.masksToBounds = YES;
    
    _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64-40)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreen_Height-64-40, kScreen_Width, 40)];
    [self.view addSubview:bottomView];

    UIButton *selectBtn = [UIButton buttonWithframe:CGRectMake(0, 0, 100, bottomView.height) text:@"全选" font:[UIFont systemFontOfSize:14] textColor:@"#333333" backgroundColor:@"#FFFFFF" normal:nil selected:nil];
    [bottomView addSubview:selectBtn];
    
    UIButton *applyBtn = [UIButton buttonWithframe:CGRectMake(selectBtn.right, 0, kScreen_Width-selectBtn.right, bottomView.height) text:@"申请职位" font:[UIFont systemFontOfSize:14] textColor:@"#FFFFFF" backgroundColor:@"#666666" normal:nil selected:nil];
    [bottomView addSubview:applyBtn];

    
}

- (void)btnAction:(UIButton *)btn
{
    
    [self.view addSubview:self.jobview];
    self.jobview.tag = btn.tag;
    
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
//    return [self.dataArr[section] count];
    return 20;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    JobDetailVC *vc = [[JobDetailVC alloc] init];
    vc.title = @"职位详情";
    [self.navigationController pushViewController:vc animated:YES];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 31)];
    view.backgroundColor = [UIColor whiteColor];
    
    NSArray *titleArr1 = @[@"行业类型",@"排序",@"筛选"];
    for (int i=0; i<titleArr1.count; i++) {
        
        UIButton *forgetBtn = [UIButton buttonWithframe:CGRectMake(i*kScreen_Width/3, 0, kScreen_Width/3, view.height) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:nil selected:nil];
        [view addSubview:forgetBtn];
        [forgetBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        forgetBtn.tag = i;
        
        UILabel *label1 = [UILabel labelWithframe:CGRectMake(forgetBtn.width/2-10, 0, 46, view.height) text:titleArr1[i] font:[UIFont systemFontOfSize:11] textAlignment:NSTextAlignmentCenter textColor:@"#333333"];
        [forgetBtn addSubview:label1];
        label1.tag = 100+forgetBtn.tag;
        
        UIImageView *imgView = [UIImageView imgViewWithframe:CGRectMake(0, (forgetBtn.height-3)/2, 6, 3) icon:@"33"];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        [forgetBtn addSubview:imgView];
        imgView.tag = 101+forgetBtn.tag;

        
        if (i == 0) {
            
            self.lastBtn = forgetBtn;
            
            label1.frame = CGRectMake(forgetBtn.width/2-46+10, 0, 46, view.height);
            imgView.frame = CGRectMake(forgetBtn.width/2+10, (forgetBtn.height-5)/2, 8, 5);
        }
        else {
            label1.frame = CGRectMake(forgetBtn.width/2-24, 0, 24, view.height);
            imgView.frame = CGRectMake(forgetBtn.width/2+5, (forgetBtn.height-5)/2, 8, 5);
        }
        
        if (i < titleArr1.count) {
            
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(forgetBtn.width-1, 8, 1, 16)];
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
    return 31;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JobCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[JobCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    cell.type = 1;
    cell.model = nil;
    
    return cell;
}


@end
