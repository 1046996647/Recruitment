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

@interface TabBarController ()<UITabBarControllerDelegate,UINavigationControllerDelegate>


@end

@implementation TabBarController

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
