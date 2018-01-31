//
//  RCTabBarController.m
//  ChangeLanguage
//
//  Created by RongCheng on 16/7/21.
//  Copyright © 2016年 RongCheng. All rights reserved.
//

#import "TabBarController.h"
#import "NavigationController.h"

#import "HomeVC.h"
#import "ResumeVC.h"
#import "SessionListViewController.h"
#import "PersonalCenterVC.h"

#import "UITabBar+badge.h"


@interface TabBarController ()<UITabBarControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong) UIView *redDot;


@end

@implementation TabBarController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
 如果是tabBarController里好几个navigationBarController，可以这样：
 
 UINavigationController *navVC = (UINavigationController *)tabVC.selectedViewController;
 
 UIViewController *currentVC = self.navigationController.topViewController;
 
 先取到是哪个navVC，然后取这个navVC最顶部的currentVC；
 */

+ (void)initialize{
   /**
    * 设置 TabBarItem的字体大小与颜色，可参考UIButton
    */
    
    NSMutableDictionary * tabDic=[NSMutableDictionary dictionary];
    tabDic[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    tabDic[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary * selectedTabDic=[NSMutableDictionary dictionary];
    selectedTabDic[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    selectedTabDic[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#F7932A"];
    
    UITabBarItem *item=[UITabBarItem appearance];
    [item setTitleTextAttributes:tabDic forState:(UIControlStateNormal)];
    [item setTitleTextAttributes:selectedTabDic forState:(UIControlStateSelected)];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.tabBar.backgroundColor = [UIColor colorWithHexString:@"#FEFEFE"];
//    [self.tabBar setBackgroundImage:[[UIImage alloc]init]];
//    [self.tabBar setShadowImage:[[UIImage alloc]init]];
    self.delegate = self;
    
    [self setChildViewController:[[HomeVC alloc]init] Title:@"首页" Image:@"62" SelectedImage:@"63"];
    
    [self setChildViewController:[[SessionListViewController alloc]init] Title:@"消息" Image:@"61" SelectedImage:@"60"];

    [self setChildViewController:[[ResumeVC alloc]init] Title:@"简历" Image:@"59" SelectedImage:@"58"];
    
    [self setChildViewController:[[PersonalCenterVC alloc]init] Title:@"个人" Image:@"57" SelectedImage:@"56"];

    
//    [self selectController:2];
    //显示

    
    // 面试邀请和我的信箱
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(is_new) name:@"KInterviewNotification" object:nil];
    
    [self is_new];


}



- (void)is_new
{
    
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Is_new dic:paraDic showHUD:NO Succed:^(id responseObject) {
        
//        {
//            countInvite = 12;
//            countMess = 7;
//            message = "";
//            status = 1;
//        }
        NSNumber *countInvite = [responseObject objectForKey:@"countInvite"];
        NSNumber *countMess = [responseObject objectForKey:@"countMess"];

        if (countInvite.integerValue > 0) {
            
            //显示
            [self.tabBar showBadgeOnItemIndex:1];
            [self.tabBar showBadgeOnItemIndex:2];

        }
        else {
            //隐藏
            [self.tabBar hideBadgeOnItemIndex:1];
            [self.tabBar hideBadgeOnItemIndex:2];
        }
        
        if (countMess.integerValue > 0) {
            
            [self.tabBar showBadgeOnItemIndex:3];

        }
        else {
            
            [self.tabBar hideBadgeOnItemIndex:3];

        }
//        [_msgView reloadData];
        
    } failure:^(NSError *error) {
        
        
    }];
}


- (void)selectController:(NSInteger)index{
    self.selectedIndex=index;
}

/**
 *  初始化控制器
 */
- (void)setChildViewController:(UIViewController*)childVC Title:(NSString*)title Image:(NSString *)image SelectedImage:(NSString *)selectedImage
{
    /**
     *  添加 tabBarItem 上的文字和图片
     */
    childVC.title=title;
    childVC.tabBarItem.image=[UIImage imageNamed:image];
    childVC.tabBarItem.selectedImage=[[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NavigationController *nav = [[NavigationController alloc]initWithRootViewController:childVC];
//    nav.delegate = self;
    [self addChildViewController:nav];
    
//    _redDot = [[UIView alloc] initWithFrame:CGRectMake(childVC.tabBarItem, 0, 8, 8)];
//    _redDot.layer.cornerRadius = _redDot.height/2;
//    _redDot.layer.masksToBounds = YES;
//    _redDot.backgroundColor = [UIColor redColor];
//    [childVC.tabBarItem addSubview:_redDot];
//    _redDot.hidden = YES;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-UITabBarControllerDelegate
//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
//{
//    viewController = (UINavigationController
//                      *)viewController.childViewControllers[0];
//    if ([viewController isKindOfClass:[HomeVC class]]) {
//        self.btn.selected = YES;
//
//    }
//    else {
//        self.btn.selected = NO;
//
//    }
//}
//#pragma mark - UINavigationControllerDelegate
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    BOOL isHomePage = [viewController isKindOfClass:[self class]];
//    
//    [navigationController setNavigationBarHidden:isHomePage animated:YES];
//}



@end
