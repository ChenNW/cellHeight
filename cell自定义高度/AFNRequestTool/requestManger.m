//
//  requestManger.m
//  AFNRequest
//
//  Created by cnw on 2017/5/24.
//  Copyright © 2017年 cnw. All rights reserved.
//

#import "requestManger.h"

@implementation requestManger
+(void)startMonitor
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                [SVProgressHUD showInfoWithStatus:@"没有网络"];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [SVProgressHUD showInfoWithStatus:@"wifi状态下"];
                break;
                
            default:
                break;
        }
    }];
}
// post
+(void)postReqeustWithURL:(NSString *)url
                   params:(NSDictionary *)params
             successBlock:(CSuccessBlock)successBlock
             failureBlock:(CFailureBlock)failureBlock
            requestTarget:(UIViewController*)target
                   ishide:(BOOL)ishide
{
    __block BOOL hide = ishide;
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if(status >0){
            [target hiddenNonetWork];
            [LCProgressHUD showLoading:@"正在加载"];
            AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
            //设置请求超时
            manager.requestSerializer.timeoutInterval = Request_timeOut;
            [manager.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil]];
            
            [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                successBlock(responseObject);
                [LCProgressHUD hide];
                NSData * data = [self dataWithObject:responseObject];
                NSLog(@"jsonData---%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                hide = YES;
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failureBlock(error);
                [LCProgressHUD hide];
                if (hide == NO) {

                    hide = YES;
                    [target showNonetWork];
                }
                NSLog(@"请求数据===%@",error);
                
            }];
            
            
            
        }else if (status <= 0 && hide == NO){
            
            [target showNonetWork];
            
        }
        
    }];
}
// get
+(void)getReqeustWithURL:(NSString *)url
                  params:(NSDictionary *)params
            successBlock:(CSuccessBlock)successBlock
            failureBlock:(CFailureBlock)failureBlock
           requestTarget:(UIViewController *)target
                  ishide:(BOOL)ishide
{
    __block BOOL hide = ishide;
    
    
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status>0) {
            [target hiddenNonetWork];//去掉提示视图
            [LCProgressHUD showLoading:@"正在加载"];
            AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
            //设置请求超时
            manager.requestSerializer.timeoutInterval = Request_timeOut;
            [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil]];
            
            [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                successBlock(responseObject);
                NSData * data = [self dataWithObject:responseObject];
                NSLog(@"jsonData---%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);

                
                [LCProgressHUD hide];
                hide = YES;
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 failureBlock(error);
                NSLog(@"请求数据===%@",error);
                [LCProgressHUD hide];
                if (hide == NO) {

                    hide = YES;
                    [target showNonetWork];
                }
            }];
        }else if (status <= 0 && hide == NO){// 断网情况下是否显示提示图片
            [LCProgressHUD hide];
            
            [target showNonetWork];
        }
        
    }];
}
// post上传图片图片必须为数组形式
+(void)postReqeustWithURL:(NSString *)url
                   params:(NSDictionary *)params
               imageArray:(NSArray*)imageArray
             successBlock:(CSuccessBlock)successBlock
             failureBlock:(CFailureBlock)failureBlock
            requestTarget:(UIViewController*)target
{
    
    [LCProgressHUD showLoading:@"正在加载"];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if(status >0){
            [LCProgressHUD showLoading:@"正在加载"];
            AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
            //设置请求超时
            manager.requestSerializer.timeoutInterval = Request_timeOut;
            [manager.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil]];
            
            [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                for (int i = 0; i<imageArray.count; i++) {
                    
                    NSData * data;
                    if (UIImagePNGRepresentation(imageArray[i]) == nil) {
                        data = UIImageJPEGRepresentation(imageArray[i], 1.0); // jpeg
                        
                    }else {
                        data = UIImagePNGRepresentation(imageArray[i]); // png
                        
                    }
                    data = UIImageJPEGRepresentation(imageArray[i],0.14);
                    
                    
                    NSString * temp = NSTemporaryDirectory();
                    NSString * path = [temp stringByAppendingFormat:@"%i.png",i];
                    [data writeToFile:path atomically:YES];
                    
                    [formData appendPartWithFileData:data
                                                name:[NSString stringWithFormat:@"%i",i]
                                            fileName:path
                                            mimeType:@"image/jpeg/png"];
                    
                }

            } progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                successBlock(responseObject);
                
                NSData * data = [self dataWithObject:responseObject];
                NSLog(@"jsonData---%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                
                [LCProgressHUD hide];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failureBlock(error);
                [LCProgressHUD hide];
            }];
            
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:@"网络未连接"];
            
        }
        
    }];
}
+ (NSData *)dataWithObject:(id)dict
{
    if (![dict isKindOfClass:[NSDictionary class]]
        && ![dict isKindOfClass:[NSArray class]]
        ) {
        NSLog(@"dataFromDict dict error");
        
        return nil;
    }
    
    //使用系统版本
    NSError *error  = nil;
    id result       = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    if (error) {
        NSLog(@"jsonManager data error->%@", error);
    }
    
    return result;
}

@end
