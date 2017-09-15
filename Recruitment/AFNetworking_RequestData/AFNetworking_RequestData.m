//
//  AFNetworking_RequestData.m
//  AFNetworking_RequestData
//
//  Created by 余晋龙 on 2016/10/31.
//  Copyright © 2016年 余晋龙. All rights reserved.
//


#import "AFNetworking_RequestData.h"


@implementation AFNetworking_RequestData


//默认网络请求时间
static const NSUInteger kDefaultTimeoutInterval = 20;

#pragma GET请求--------------
+(void)requestMethodGetUrl:(NSString*)url
                       dic:(NSMutableDictionary*)dic
                   showHUD:(BOOL)hud
                    Succed:(Success)succed
                   failure:(Failure)failure{
    //1.数据请求接口 2.请求方法 3.参数
    //请求成功   返回数据
    //请求失败   返回错误
    [AFNetworking_RequestData Manager:url Method:@"GET"  dic:dic showHUD:(BOOL)hud requestSucced:^(id responseObject) {
        
        succed(responseObject);
        
    } requestfailure:^(NSError *error) {
        
        failure(error);
        
    }];
}
#pragma POST请求--------------
+(void)requestMethodPOSTUrl:(NSString*)url
                  dic:(NSMutableDictionary*)dic
              showHUD:(BOOL)hud
               Succed:(Success)succed
              failure:(Failure)failure{
    
    [AFNetworking_RequestData Manager:url Method:@"POST"  dic:dic showHUD:hud requestSucced:^(id responseObject) {
        
        succed(responseObject);
        
    } requestfailure:^(NSError *error) {
        
        failure(error);
    }];
}

//=====================
+(void)Manager:(NSString*)url Method:(NSString*)Method dic:(NSMutableDictionary*)dic showHUD:(BOOL)hud requestSucced:(Success)Succed requestfailure:(Failure)failure
{
    
    if (hud) {
        [SVProgressHUD show];
    }
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = kDefaultTimeoutInterval; //默认网络请求时间
     manager.responseSerializer = [AFJSONResponseSerializer serializer]; //申明返回的结果是json类型
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/json", @"text/javascript",@"text/html", nil];
    
//    PersonModel *person = [InfoCache unarchiveObjectWithFile:Person];
    NSString *token = [InfoCache unarchiveObjectWithFile:@"token"];
    NSString *userid = [InfoCache unarchiveObjectWithFile:@"userid"];
    
    //======POST=====
    if ([Method isEqualToString:@"POST"]) {

        
        if (userid && dic) {
            [dic  setValue:userid forKey:@"userid"];
            [dic  setValue:token forKey:@"token"];

        }

        [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSLog(@"%@",responseObject);

            if (hud) {
                [SVProgressHUD dismiss];
            }
            NSNumber *code = [responseObject objectForKey:@"status"];
            if (0 == [code integerValue]) {
                
                NSString *message = [responseObject objectForKey:@"message"];
                
                if (message) {
                    [[UIApplication sharedApplication].keyWindow.rootViewController.view makeToast:message];

                }
            }
            else {
                Succed(responseObject);

            }
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (hud) {
                [SVProgressHUD dismiss];
            }
            
            if (![UIApplication sharedApplication].keyWindow.rootViewController.view.isShowing) {
                
                [[UIApplication sharedApplication].keyWindow.rootViewController.view makeToast:@"网络似乎已断开!"];

            }
            NSLog(@"%@",error);

            failure(error);
            

        }];
        
        
    //=========GET======
    }else{
        
        [manager GET:url parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (hud) {
                [SVProgressHUD dismiss];
            }
            
            Succed(responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (hud) {
                [SVProgressHUD dismiss];
            }
            
            [[UIApplication sharedApplication].keyWindow.rootViewController.view makeToast:@"网络似乎已断开!"];

            failure(error);
            NSLog(@"%@",error);

        }];
    }
    
}

@end
