//
//  netTipView.h
//  AFNRequest
//
//  Created by cnw on 2017/5/24.
//  Copyright © 2017年 cnw. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol netTipViewDelegate <NSObject>

@optional;

-(void)reloadNetworkDataSource:(id)sender;

@end

@interface netTipView : UIView

+(instancetype)TipView;

@property(nonatomic , weak)id<netTipViewDelegate>delegte;

@end
