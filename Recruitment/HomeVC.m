
//
//  HomeVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/6.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "HomeVC.h"
#import "SDCycleScrollView.h"
#import "CustomerScrollView.h"
#import "JobTableView.h"
#import "SearchVC.h"
#import "ApplyJobVC.h"
#import "PlaceView.h"
#import "JobRecommandVC.h"
#import "HomeModel.h"
#import "EmergencyEnterpriseVC.h"

#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

@interface HomeVC ()<UITextFieldDelegate,SDCycleScrollViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>

@property (nonatomic,strong) SDCycleScrollView *cycleScrollView2;
@property (nonatomic,strong) CustomerScrollView * btnScrollView;
@property(nonatomic,strong) UIButton *forgetBtn1;
@property(nonatomic,strong) JobTableView *tableView;
@property(nonatomic,strong) UITextField *searchTF;
@property(nonatomic,strong) PlaceView *placeView;
@property(nonatomic,strong) UIImageView *imgView;
@property(nonatomic,strong) UIButton *placeBtn;
@property (nonatomic,assign) BOOL isRefresh;

@property(nonatomic,strong) NSMutableArray *urlArr;

@property (strong, nonatomic) BMKLocationService *locService;
@property (strong, nonatomic) BMKGeoCodeSearch *geocodesearch;
@property(nonatomic,strong) NSString *city;
@property(nonatomic,strong) NSString *siteId;


@end

@implementation HomeVC

- (PlaceView *)placeView
{
    if (!_placeView) {
        
        __weak typeof(self) weakSelf = self;
        _placeView = [[PlaceView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64)];
        _placeView.block = ^(NSDictionary *dic) {
            
            
            [weakSelf.placeView removeFromSuperview];
            weakSelf.imgView.image = [UIImage imageNamed:@"55"];
            weakSelf.placeBtn.selected = NO;
            if (dic) {
                [weakSelf.placeBtn setTitle:dic[@"site"] forState:UIControlStateNormal];
                [weakSelf.tableView.mj_header beginRefreshing];
                
                weakSelf.siteId = dic[@"siteId"];

                [InfoCache archiveObject:weakSelf.siteId toFile:@"siteId"];
            }
        };
    }
    return _placeView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.navigationItem.title = nil;
    
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 26+17, 17)];

    UIButton *placeBtn = [UIButton buttonWithframe:CGRectMake(0, 0, baseView.width-5, baseView.height) text:@"永康" font:SystemFont(12) textColor:@"FFFFFF" backgroundColor:nil normal:nil selected:nil];
    placeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [baseView addSubview:placeBtn];
    self.placeBtn = placeBtn;
    [placeBtn addTarget:self action:@selector(placeAction:) forControlEvents:UIControlEventTouchUpInside];

    
    UIImageView *imgView = [UIImageView imgViewWithframe:CGRectMake(baseView.width-7, 0, 12, placeBtn.height) icon:@"55"];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    [baseView addSubview:imgView];

    self.imgView = imgView;
    self.placeView.imgView = imgView;

    // iOS11的原因不能直接用UIButton，得用UIView
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:baseView];
    
    UIImageView *imgView1 = [UIImageView imgViewWithframe:CGRectMake(0, 0, 25, 15) icon:@"39"];
    imgView1.contentMode = UIViewContentModeScaleAspectFit;
    
    UITextField *searchTF = [UITextField textFieldWithframe:CGRectMake(0, 0, kScreen_Width-66-22, 25) placeholder:@"关键词/职位/公司" font:nil leftView:imgView1 backgroundColor:@"#E95F08"];
    searchTF.font = [UIFont systemFontOfSize:12];
    [searchTF setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];// 设置这里时searchTF.font也要设置不然会偏上
    [searchTF setValue:[UIColor colorWithHexString:@"#FFB261"] forKeyPath:@"_placeholderLabel.textColor"];
    searchTF.layer.cornerRadius = searchTF.height/2;
    searchTF.layer.masksToBounds = YES;
    searchTF.delegate = self;
    self.searchTF = searchTF;
//    self.navigationItem.titleView = searchTF;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchTF];
    
    if (IS_iPhone6Plus) {
        searchTF.width = kScreen_Width-66-32;
    }

    [self initHeaderView];
    
    // 下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self headerRefresh];
    }];
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;
    
    [self homepage_info];

     // 选择项数据
    [self getSelectItems];
    [self getSelectItemJob];
    
    //初始化BMKLocationService定位服务
    _locService = [[BMKLocationService alloc]init];
    //    _locService.delegate = self;
    
    // 反检索
    _geocodesearch = [[BMKGeoCodeSearch alloc] init];
    //    _geocodesearch.delegate = self;
    
    //启动LocationService
    [_locService startUserLocationService];

//    self.siteId = @"2";
    [InfoCache archiveObject:@"2" toFile:@"siteId"];
    
    PersonModel *model = [InfoCache unarchiveObjectWithFile:Person];
    if (model) {
        [self.view makeToast:@"请记得刷新你的简历~" duration:1.5 position:@"12"];
    }

}

- (void)headerRefresh
{
    [_locService startUserLocationService];

    
    [self homepage_info];
    self.isRefresh = YES;
}

- (void)homepage_info
{
    if (!self.isRefresh) {
        [SVProgressHUD show];
        
    }
    
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    
    [paraDic setValue:[InfoCache unarchiveObjectWithFile:@"siteId"] forKey:@"siteId"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Homepage_info dic:paraDic showHUD:NO Succed:^(id responseObject) {
        
        self.isRefresh = YES;
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
        
        NSNumber *code = [responseObject objectForKey:@"status"];
        if (1 == [code integerValue]) {
            
            // carousel
            NSMutableArray *imgArr = [NSMutableArray array];
            NSMutableArray *urlArr = [NSMutableArray array];
            for (NSDictionary *dic in responseObject[@"data"][@"carousel"]) {
                HomeModel *model = [HomeModel yy_modelWithJSON:dic];
                [imgArr addObject:model.img];
                [urlArr addObject:model.url];
            }
            self.urlArr = urlArr;
            self.cycleScrollView2.imageURLStringsGroup = imgArr;
            
            // button
            
            //        NSMutableArray *arrM1 = [NSMutableArray array];
            //        for (NSDictionary *dic in responseObject[@"data"][@"button"]) {
            //            HomeModel *model = [HomeModel yy_modelWithJSON:dic];
            //            [arrM1 addObject:model];
            //        }
            _btnScrollView.dataArr = responseObject[@"data"][@"button"];
            
            
            // like
            NSMutableArray *arrM2 = [NSMutableArray array];
            for (NSDictionary *dic in responseObject[@"data"][@"like"]) {
                JobModel *model = [JobModel yy_modelWithJSON:dic];
                [arrM2 addObject:model];
            }
            self.tableView.dataArr = arrM2;
            [self.tableView reloadData];
        }

        
    } failure:^(NSError *error) {
        
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)searchTFAction
{
    SearchVC *vc = [[SearchVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)placeAction:(UIButton *)btn
{
    btn.selected = !btn.selected;
    
    if (btn.selected) {
        [self.view addSubview:self.placeView];
        self.imgView.image = [UIImage imageNamed:@"箭头"];
    }
    else {
        [self.placeView removeFromSuperview];
        self.imgView.image = [UIImage imageNamed:@"55"];

    }
}

- (void)initHeaderView
{
    // 头视图
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0)];
//    [self.view addSubview:headView];
    
    // 情景二：采用网络图片实现
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    
    // 网络加载 --- 创建带标题的图片轮播器
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreen_Width, 100) delegate:self placeholderImage:[UIImage imageNamed:@""]];
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView2.currentPageDotColor = [UIColor colorWithHexString:@"#F78724"]; // 自定义分页控件小圆标颜色
    [headView addSubview:cycleScrollView2];
    cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
    cycleScrollView2.backgroundColor = [UIColor clearColor];
    self.cycleScrollView2 = cycleScrollView2;
    
    _btnScrollView = [[CustomerScrollView alloc] initWithFrame:CGRectMake(0, cycleScrollView2.bottom, kScreen_Width, 190)];
    [headView addSubview:_btnScrollView];
    
    __weak typeof(self) weakSelf = self;
    _btnScrollView.block = ^(NSDictionary *dic) {
        
        ApplyJobVC *vc = [[ApplyJobVC alloc] init];
        vc.searchText = dic[@"name"];
        vc.siteId = weakSelf.siteId;
        vc.city = weakSelf.city;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    NSArray *imgArr = @[@"44",@"45"];
    NSArray *titleArr1 = @[@"可沟通的职位",@"急聘企业"];
    NSArray *titleArr2 = @[@"来和老板直接聊offer吧!",@"没什么比急聘能更快入职"];
    for (int i=0; i<titleArr1.count; i++) {
        
        UIButton *forgetBtn = [UIButton buttonWithframe:CGRectMake(i*kScreen_Width/2, _btnScrollView.bottom+8, kScreen_Width/2, 69) text:nil font:nil textColor:nil backgroundColor:@"#FFFFFF" normal:nil selected:nil];
        [headView addSubview:forgetBtn];
        self.forgetBtn1 = forgetBtn;
        forgetBtn.tag = i;
        [forgetBtn addTarget:self action:@selector(pushAction:) forControlEvents:UIControlEventTouchUpInside];

        
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake((forgetBtn.width-(86+52+19)*scaleWidth)/2, (forgetBtn.height-(20+13+14))/2, (86+52+19)*scaleWidth, 20+13+14)];
        [forgetBtn addSubview:baseView];
        baseView.userInteractionEnabled = NO;
        
        UILabel *label1 = [UILabel labelWithframe:CGRectMake(0, 0, baseView.width, 20) text:titleArr1[i] font:[UIFont systemFontOfSize:16] textAlignment:NSTextAlignmentLeft textColor:@"#000000"];
        [baseView addSubview:label1];
        
        UILabel *label2 = [UILabel labelWithframe:CGRectMake(label1.left, label1.bottom+13, baseView.width, 14) text:titleArr2[i] font:[UIFont systemFontOfSize:11] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
        [baseView addSubview:label2];
        
        UIImageView *imgView = [UIImageView imgViewWithframe:CGRectMake(baseView.width-15, 18, 19, 19) icon:imgArr[i]];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        [baseView addSubview:imgView];
        
        if (i == 0) {
            imgView = [UIImageView imgViewWithframe:CGRectMake(forgetBtn.width-1, 10, 1, 50) icon:@"Line 2"];
            imgView.contentMode = UIViewContentModeScaleAspectFit;
            [forgetBtn addSubview:imgView];
        }
        
    }
    
    UIView *likeView = [[UIView alloc] initWithFrame:CGRectMake(0, self.forgetBtn1.bottom+8, kScreen_Width, 33)];
    likeView.backgroundColor = [UIColor whiteColor];
    [headView addSubview:likeView];

    UIImageView *likeImgView = [UIImageView imgViewWithframe:CGRectMake(12, (likeView.height-14)/2, 15, 14) icon:@"42"];
    likeImgView.contentMode = UIViewContentModeScaleAspectFit;
    [likeView addSubview:likeImgView];
    
    UILabel *likeLab = [UILabel labelWithframe:CGRectMake(likeImgView.right+8, likeImgView.center.y-9, 100, 18) text:@"猜你喜欢" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#000000"];
    [likeView addSubview:likeLab];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, likeView.height-1, kScreen_Width, 1)];
    line1.backgroundColor = [UIColor colorWithHexString:@"#C2C2C2"];
    [likeView addSubview:line1];
    
    headView.height = likeView.bottom;

    _tableView = (JobTableView *)[JobTableView tableViewWithframe:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64-49)];
    [self.view addSubview:_tableView];
    _tableView.tableHeaderView = headView;

}

- (void)pushAction:(UIButton *)btn
{
    if (btn.tag == 0) {
        
        JobRecommandVC *vc = [[JobRecommandVC alloc] init];
        vc.title = @"可直接沟通的职位推荐";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else {
        EmergencyEnterpriseVC *vc = [[EmergencyEnterpriseVC alloc] init];
        vc.title = @"详情";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    _locService.delegate = self;
    _geocodesearch.delegate = self;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"#FF9123"];

//    self.searchTF.backgroundColor = [UIColor colorWithHexString:@"#E95F08"];
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    _locService.delegate = nil;
    _geocodesearch.delegate = nil;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"#F2F2F2"];
//
//    self.searchTF.backgroundColor = [UIColor clearColor];

}


#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self searchTFAction];
    return NO;
}


//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    NSLog(@"heading is %@",userLocation.heading);
}

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    [_locService stopUserLocationService];//定位完成停止位置更新(导致反检索失败)
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    
    //地理反编码
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    
    reverseGeocodeSearchOption.reverseGeoPoint = userLocation.location.coordinate;
    
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    
    if(flag){
        
        NSLog(@"反geo检索发送成功");
        
        [_locService stopUserLocationService];
        
    }else{
        
        NSLog(@"反geo检索发送失败");
        
    }
}


#pragma mark -------------地理反编码的delegate---------------

-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error

{
    NSLog(@"%@----%i",result,error);
    
    if (result) {
        
        self.city = result.addressDetail.city;
        //        NSLog(@"address:%@----%@",result.addressDetail,result.address);

        

    }

    
    
    //addressDetail:     层次化地址信息
    
    //address:    地址名称
    
    //businessCircle:  商圈名称
    
    // location:  地址坐标
    
    //  poiList:   地址周边POI信息，成员类型为BMKPoiInfo
    
    //    for (BMKPoiInfo *info in result.poiList) {
    //        NSLog(@"address:%@----%@",info.name,info.address);
    //
    //    }
    
}
    
- (void)getSelectItems
{
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Get_setting dic:nil showHUD:NO Succed:^(id responseObject) {
        
        NSArray *selectArr = responseObject[@"data"];
        [InfoCache archiveObject:selectArr toFile:SelectItem];
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)getSelectItemJob
{
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Get_jobs_cate dic:nil showHUD:NO Succed:^(id responseObject) {
        
        NSArray *selectArr = responseObject[@"data"];
        [InfoCache archiveObject:selectArr toFile:SelectItemJob];
        
    } failure:^(NSError *error) {
        
    }];
    
}




@end
