//
//  UIViewController+requestVC.m
//  AFNRequest
//
//  Created by cnw on 2017/5/24.
//  Copyright © 2017年 cnw. All rights reserved.
//

#import "UIViewController+requestVC.h"

@implementation UIViewController (requestVC)

- (void)showNonetWork
{
    netTipView* tipview = [netTipView TipView];
    tipview.delegte = self;
    [self.view addSubview:tipview];
}

- (void)hiddenNonetWork
{
    for (UIView* view in self.view.subviews) {
        if ([view isKindOfClass:[netTipView class]]) {
            [view removeFromSuperview];
        }
    }
}

- (void)reloadNetworkDataSource:(id)sender
{
    if ([self respondsToSelector:@selector(reloadRequest)]) {
        [self performSelector:@selector(reloadRequest)];
    }
}
- (void)reloadRequest
{
    NSLog(@"必须由网络控制器(%@)重写这个方法(%@)，才可以使用再次刷新网络",NSStringFromClass([self class]),NSStringFromSelector(@selector(reloadRequest)));
}

@end
