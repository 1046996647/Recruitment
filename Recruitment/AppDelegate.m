//
//  AppDelegate.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/9/6.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "AppDelegate.h"
#import "IQKeyboardManager.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

#import <UserNotifications/UserNotifications.h>


#import "NTESCellLayoutConfig.h"
#define NIMSDKAppKey @"a99978b70ffcf627c58dcada5eb78921"
#define NIMSDKCerName @"Recruitment"

@interface AppDelegate ()<BMKGeneralDelegate>

@property (strong, nonatomic) BMKMapManager *mapManager;


@end

@implementation AppDelegate

+ (AppDelegate *)share
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
    [self.window makeKeyAndVisible];
    
    [NSThread sleepForTimeInterval:1];
    
    TabBarController *tabVC = [[TabBarController alloc] init];
    self.tabVC = tabVC;
    self.window.rootViewController = tabVC;
    
    // 键盘遮盖处理第三方库
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"s4H2OnHPOuaE9UoteAbFaWGsvlGaT4lN"  generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    // 云信
    [[NIMSDKConfig sharedConfig] setEnabledHttpsForInfo:NO];
    
    //注册APP，请将 NIMSDKAppKey 换成您自己申请的App Key
    [[NIMSDK sharedSDK] registerWithAppID:NIMSDKAppKey cerName:NIMSDKCerName];
    
    //    //需要自定义消息时使用
    //    [NIMCustomObject registerCustomDecoder:[[NTESAttachmentDecoder alloc]init]];
    
    //开启控制台调试
    [[NIMSDK sharedSDK] enableConsoleLog];
    
    //注入 NIMKit 布局管理器
    [[NIMKit sharedKit] registerLayoutConfig:[NTESCellLayoutConfig new]];
    
    // 推送注册
    [self registerPushService];
    
    // 登录网易云
    [self loginNetCloud];
    
    return YES;
}


- (void)loginNetCloud
{
    NSString *account = [InfoCache unarchiveObjectWithFile:@"accid"];
    NSString *token = [InfoCache unarchiveObjectWithFile:@"accToken"];
    

    if (account.length>0 && token.length>0) {
        [[[NIMSDK sharedSDK] loginManager] autoLogin:account token:token];

    }
    
}

#pragma mark - misc
- (void)registerPushService
{
    if (@available(iOS 11.0, *))
    {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (!granted)
            {
                //                [[UIApplication sharedApplication].keyWindow makeToast:@"请开启推送功能否则无法收到推送通知" duration:2.0 position:CSToastPositionCenter];
            }
        }];
    }
    else
    {
        UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types
                                                                                 categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    
    //pushkit
    //    PKPushRegistry *pushRegistry = [[PKPushRegistry alloc] initWithQueue:dispatch_get_main_queue()];
    //    pushRegistry.delegate = self;
    //    pushRegistry.desiredPushTypes = [NSSet setWithObject:PKPushTypeVoIP];
    
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [[NIMSDK sharedSDK] updateApnsToken:deviceToken];
    
    NSLog(@"didRegisterForRemoteNotificationsWithDeviceToken:  %@", deviceToken);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    NSInteger count = [[[NIMSDK sharedSDK] conversationManager] allUnreadCount];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:count];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - BMKGeneralDelegate
- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}

@end
