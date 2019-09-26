//
//  XCNetworking.m
//  贷上你
//
//  Created by Kunlin Lin on 2019/6/24.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import "XCNetworking.h"
#import "AFNetworking.h"


@interface XCNetworking()

@end

// 测试环境
//static const NSString * BaseUrl = @"http://39.96.185.116:8080/dlh-android-api";
// 正式环境
static const NSString * BaseUrl = @"https://dlh.shtmedia.com/dlh-android-api";


@implementation XCNetworking

+ (void)post:(NSString *)url
      params:(NSDictionary *)params
     success:(void (^)(id responseObj))success
     failure:(void (^)(NSError *error))failure{
    
    if([ComTool isVPNConnected] ||[ComTool isProxyOpened]){
        return;
    }
    
    NSString *completeUrl = [NSString stringWithFormat:@"%@%@",BaseUrl,url];
    
    AFHTTPSessionManager *manager  = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil ];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [manager POST:completeUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"-请求地址--%@",completeUrl);
        if (success) {
            
            if ([completeUrl containsString:@"gethomepage"]) {
//                 homepage需要解析json再回调
                NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                           options:NSJSONReadingMutableContainers
                                                                             error:nil];
                success(dic);
            }
            else
            {
                 success(responseObject);
            }
           
           
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            NSData *responseData = error.userInfo[@"com.alamofire.serialization.response.error.data"];
            NSString *result = [[NSString alloc] initWithData:responseData  encoding:NSUTF8StringEncoding];
            NSLog(@"errResult%@",result);
            failure(error);
        }
    }];
}

+ (void)get:(NSString *)url
     params:(NSDictionary *)params
    success:(void (^)(id responseObj))success
    failure:(void (^)(NSError *error))failure{
    if([ComTool isVPNConnected] ||[ComTool isProxyOpened]){
        return;
    }
    NSString *completeUrl = [NSString stringWithFormat:@"%@%@",BaseUrl,url];
    
    AFHTTPSessionManager *manager  = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil ];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [manager GET:completeUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                       options:NSJSONReadingMutableContainers
                                                                         error:nil];
            success(dic);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            NSData *responseData = error.userInfo[@"com.alamofire.serialization.response.error.data"];
            NSString *result = [[NSString alloc] initWithData:responseData  encoding:NSUTF8StringEncoding];
            NSLog(@"errResult%@",result);
            failure(error);
        }
    }];
}

#pragma mark - 是否加密
+ (void)encryption:(void (^)(NSString *key)) success{
    NSDictionary *dic = @{@"category":@"isEncryption"};
    [XCNetworking post:@"/sysconstant/getconstants" params:dic success:^(id  _Nonnull responseObj) {
        if (success) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObj
                                                                options:NSJSONReadingMutableContainers
                                                                  error:nil];
          NSString *str = dic[@"data"][0][@"value"];
            success(str);
        }
    } failure:^(NSError * _Nonnull error) {
    }];
}

#pragma mark - 获取秘钥
+ (void)key:(void (^)(NSString *key)) success{
    NSDictionary *dic = @{@"category":@"desKey"};
    [XCNetworking post:@"/sysconstant/getconstants" params:dic success:^(id  _Nonnull responseObj) {
        if (success) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObj
                                                                options:NSJSONReadingMutableContainers
                                                                  error:nil];
            NSString *str = dic[@"data"][0][@"value"];
            success(str);
        }
    } failure:^(NSError * _Nonnull error) {
    }];
}

#pragma mark - 获取电话
+ (void)phone:(void (^)(NSString *key)) success{
    if([ComTool isVPNConnected] ||[ComTool isProxyOpened]){
        return;
    }
    NSDictionary *dic = @{@"category":@"phone"};
    [XCNetworking post:@"/sysconstant/getconstants" params:dic success:^(id  _Nonnull responseObj) {
        if (success) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObj
                                                                options:NSJSONReadingMutableContainers
                                                                  error:nil];
            NSString *str = dic[@"data"][0][@"value"];
            success(str);
        }
    } failure:^(NSError * _Nonnull error) {
    }];
}

@end
