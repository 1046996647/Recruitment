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

#import <UMSocialCore/UMSocialCore.h>
#define USHARE_DEMO_APPKEY @"5a4ae4fbf29d981a430000b8"

// 友盟推送
#import "UMessage.h"
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000
#import <UserNotifications/UserNotifications.h>
#endif

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
    
    // 友盟第三方登录或分享----------------
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:USHARE_DEMO_APPKEY];
    
    [self configUSharePlatforms];
    
    [self confitUShareSettings];
    
    // 友盟推送
    [UMessage startWithAppkey:USHARE_DEMO_APPKEY launchOptions:launchOptions];
    //注册通知，如果要使用category的自定义策略，可以参考demo中的代码。
    [UMessage registerForRemoteNotifications];
    
    
    //打开日志，方便调试
    [UMessage setLogEnabled:YES];
    
    return YES;
}

// ------------登录或分享
- (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
}

- (void)configUSharePlatforms
{
    /*
     设置微信的appKey和appSecret
     [微信平台从U-Share 4/5升级说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_1
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx2e3acc98adb6399f" appSecret:@"93d8e66beb369eb6bb6981056eeee09e" redirectURL:nil];
    
    

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

// ------------推送
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [[NIMSDK sharedSDK] updateApnsToken:deviceToken];
    
    NSString *pushToken = [self stringDevicetoken:deviceToken];
    NSLog(@"deviceToken:%@",pushToken);
    
    [InfoCache archiveObject:pushToken toFile:@"pushToken"];
}

#pragma mark 以下的
-(NSString *)stringDevicetoken:(NSData *)deviceToken
{
    NSString *token = [deviceToken description];
    NSString *pushToken = [[[token stringByReplacingOccurrencesOfString:@"<"withString:@""]                   stringByReplacingOccurrencesOfString:@">"withString:@""] stringByReplacingOccurrencesOfString:@" "withString:@""];
    return pushToken;
}

//iOS10以下使用这个方法接收通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    //关闭友盟自带的弹出框
    [UMessage setAutoAlert:NO];
    [UMessage didReceiveRemoteNotification:userInfo];
    
//    NSString *pushValue = userInfo[@"type"];
    
    //面试邀请和我的信箱
    [[NSNotificationCenter defaultCenter] postNotificationName:@"KInterviewNotification" object:nil];
    
//    if ([pushValue isEqualToString:@"interview"]) {
//        //面试邀请
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"KInterviewNotification" object:nil];
//    }
//    else {
//        // 我的信箱通知
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"kIs_mess_newNotification" object:nil];
//
//
//    }
    
//    if ([pushValue isEqualToString:@"ArriveOrder"]) {
//        //完成订单通知事件(弹出评价视图)
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"kFinishOrderNotification" object:userInfo[@"orderId"]];
//    }
    
    //    self.userInfo = userInfo;
    //定制自定的的弹出框
    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
    {
        //            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"标题"
        //                                                                message:@"Test On ApplicationStateActive"
        //                                                               delegate:self
        //                                                      cancelButtonTitle:@"确定"
        //                                                      otherButtonTitles:nil];
        //
        //            [alertView show];
        
        //            [[ZAlertViewManager shareManager] showWithType:AlertViewTypeSuccess];
        
    }
}



//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于前台时的远程推送接受
        //关闭U-Push自带的弹出框
        [UMessage setAutoAlert:NO];
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        
        //面试邀请和我的信箱
        [[NSNotificationCenter defaultCenter] postNotificationName:@"KInterviewNotification" object:nil];
        
//        NSString *pushValue = userInfo[@"type"];
        
//        if ([pushValue isEqualToString:@"interview"]) {
//            //面试邀请
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"KInterviewNotification" object:nil];
//        }
//        else {
//            // 我的信箱通知
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"kIs_mess_newNotification" object:nil];
//
//
//        }

        //        //定制自定的的弹出框
        //        if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
        //        {
        //            [[ZAlertViewManager shareManager] showWithType:AlertViewTypeSuccess];
        //
        //        }
        
    }else{
        //应用处于前台时的本地推送接受
    }
    //当应用处于前台时提示设置，需要哪个可以设置哪一个
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
    //    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge);
    
}

//iOS10后新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        
    }else{
        //应用处于后台时的本地推送接受
    }
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
    
    //面试邀请和我的信箱通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"KInterviewNotification" object:nil];
    
//    // 我的信箱通知
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"kIs_mess_newNotification" object:nil];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
        
    }
    return result;
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
