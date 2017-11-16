//
//  EmergencyEnterpriseVC.m
//  Recruitment
//
//  Created by ZhangWeiLiang on 2017/10/12.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "EmergencyEnterpriseVC.h"
#import "JobModel.h"
#import "CompanyDetailVC.h"
#import <WebKit/WebKit.h>
#import <AVFoundation/AVFoundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface EmergencyEnterpriseVC ()<UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;

@end

@implementation EmergencyEnterpriseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.title = @"UIWebView-JavaScriptCore";
//    self.view.backgroundColor = [UIColor whiteColor];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64)];
    self.webView.delegate = self;
    //    NSURL *htmlURL = [[NSBundle mainBundle] URLForResource:@"index.html" withExtension:nil];
    
    NSURL *htmlURL = [NSURL URLWithString:@"http://api.52ykjob.com:8080/52dyjob/index.php/index/advCompany?type=ios"];
    NSURLRequest *request = [NSURLRequest requestWithURL:htmlURL];
    
    self.webView.backgroundColor = [UIColor clearColor];
    // UIWebView 滚动的比较慢，这里设置为正常速度
    self.webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

#pragma mark - private method
- (void)addCustomActions
{
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
//    [context evaluateScript:@"var arr = [3, 4, 'abc'];"];
    
//    [self addScanWithContext:context];
//
//    [self addLocationWithContext:context];
//
//    [self addSetBGColorWithContext:context];
//
//    [self addShareWithContext:context];
    
    [self addPayActionWithContext:context];
    
//    [self addShakeActionWithContext:context];
//
//    [self addGoBackWithContext:context];
}

//- (void)addScanWithContext:(JSContext *)context
//{
//    context[@"scan"] = ^() {
//        NSLog(@"扫一扫啦");
//    };
//}
//
//- (void)addLocationWithContext:(JSContext *)context
//{
//    context[@"getLocation"] = ^() {
//        // 获取位置信息
//
//        // 将结果返回给js
//        NSString *jsStr = [NSString stringWithFormat:@"setLocation('%@')",@"广东省深圳市南山区学府路XXXX号"];
//        [[JSContext currentContext] evaluateScript:jsStr];
//    };
//}
//
//- (void)addShareWithContext:(JSContext *)context
//{
//    context[@"share"] = ^() {
//        NSArray *args = [JSContext currentArguments];
//
//        if (args.count < 3) {
//            return ;
//        }
//
//        NSString *title = [args[0] toString];
//        NSString *content = [args[1] toString];
//        NSString *url = [args[2] toString];
//        // 在这里执行分享的操作
//
//        // 将分享结果返回给js
//        NSString *jsStr = [NSString stringWithFormat:@"shareResult('%@','%@','%@')",title,content,url];
//        [[JSContext currentContext] evaluateScript:jsStr];
//    };
//}
//
//- (void)addSetBGColorWithContext:(JSContext *)context
//{
//    __weak typeof(self) weakSelf = self;
//    context[@"setColor"] = ^() {
//        NSArray *args = [JSContext currentArguments];
//
//        if (args.count < 4) {
//            return ;
//        }
//
//        CGFloat r = [[args[0] toNumber] floatValue];
//        CGFloat g = [[args[1] toNumber] floatValue];
//        CGFloat b = [[args[2] toNumber] floatValue];
//        CGFloat a = [[args[3] toNumber] floatValue];
//
//        weakSelf.view.backgroundColor = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a];
//    };
//}

- (void)addPayActionWithContext:(JSContext *)context
{
    context[@"payAction"] = ^() {
        NSArray *args = [JSContext currentArguments];
        
        NSString *orderNo = [args[0] toString];
        
        // 主线程执行：
        dispatch_async(dispatch_get_main_queue(), ^{
            
            JobModel *model = [[JobModel alloc] init];
            model.companyId = orderNo;
            
            CompanyDetailVC *vc = [[CompanyDetailVC alloc] init];
            vc.title = @"公司详情";
            vc.model = model;
            [self.navigationController pushViewController:vc animated:YES];        });

    };
}

//- (void)addShakeActionWithContext:(JSContext *)context
//{
//
//    context[@"shake"] = ^() {
//        AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
//    };
//}
//
//- (void)addGoBackWithContext:(JSContext *)context
//{
//    __weak typeof(self) weakSelf = self;
//    context[@"goBack"] = ^() {
//        [weakSelf.webView goBack];
//    };
//}


#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidFinishLoad");
    
    [self addCustomActions];
}


@end
