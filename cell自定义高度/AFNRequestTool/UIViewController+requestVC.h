//
//  UIViewController+requestVC.h
//  AFNRequest
//
//  Created by cnw on 2017/5/24.
//  Copyright © 2017年 cnw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import "netTipView.h"

@interface UIViewController (requestVC) <netTipViewDelegate>

/**
 *  为控制器扩展方法，刷新网络时候执行，建议必须实现
 */
- (void)reloadRequest;
/**
 *  显示没有网络
 */
- (void)showNonetWork;

/**
 *  隐藏没有网络
 */
- (void)hiddenNonetWork;

@end
