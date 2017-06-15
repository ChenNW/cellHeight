//
//  requestManger.h
//  AFNRequest
//
//  Created by cnw on 2017/5/24.
//  Copyright © 2017年 cnw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIViewController+requestVC.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "LCProgressHUD.h"

@interface requestManger : NSObject
/** 网络请求超时的时间 */
#define Request_timeOut 30

/** 网络请求URL */
@property (nonatomic, strong) NSString *url;

/** 网络请求参数 */
@property (nonatomic, strong) NSDictionary *params;

/** 请求成功回调 */
typedef void (^CSuccessBlock)(id  returnData);

/** 请求失败回调 */
typedef void (^CFailureBlock)(NSError * error);

/**
 *  post请求参数
 *
 *  @param url          请求url
 *  @param params       请求参数
 *  @param successBlock 请求成功block
 *  @param failureBlock 请求失败block
 *  @param target       请求所在控制器
 *  @param ishide       没网络图片是否加载
 */

+ (void)postReqeustWithURL:(NSString*)url
                    params:(NSDictionary*)params
              successBlock:(CSuccessBlock)successBlock
              failureBlock:(CFailureBlock)failureBlock
             requestTarget:(UIViewController*)target
                    ishide:(BOOL)ishide;
/** get 请求 */
+(void)getReqeustWithURL:(NSString *)url
                  params:(NSDictionary *)params
            successBlock:(CSuccessBlock)successBlock
            failureBlock:(CFailureBlock)failureBlock
           requestTarget:(UIViewController*)target
                  ishide:(BOOL)ishide;
/** post 上传图片 */
+(void)postReqeustWithURL:(NSString *)url
                   params:(NSDictionary *)params
               imageArray:(NSArray*)imageArray
             successBlock:(CSuccessBlock)successBlock
             failureBlock:(CFailureBlock)failureBlock
            requestTarget:(UIViewController*)target;
/** 网络检测 */

+(void)startMonitor;
@end
