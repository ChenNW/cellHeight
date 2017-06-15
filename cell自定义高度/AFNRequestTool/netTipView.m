//
//  netTipView.m
//  AFNRequest
//
//  Created by cnw on 2017/5/24.
//  Copyright © 2017年 cnw. All rights reserved.
//

#import "netTipView.h"

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width //屏幕宽
#define kScreenHeight [UIScreen mainScreen].bounds.size.height //屏幕高
@implementation netTipView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.frame = CGRectMake(0, 64,kScreenWidth,kScreenHeight);
        UIImageView * tipimage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        tipimage.contentMode = UIViewContentModeScaleAspectFit;
        tipimage.center = CGPointMake(kScreenWidth/2, kScreenHeight/2 - 100);
        tipimage.image = [UIImage imageNamed:@"no_wifi"];
        [self addSubview:tipimage];
        
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth - 80)/2 , CGRectGetMaxY(tipimage.frame), 80, 50)];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 10;
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        btn.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0];
        [btn setTitle:@"重试" forState:UIControlStateNormal];
        [self addSubview:btn];
        
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}
+(instancetype)TipView
{
    return [[self alloc] init];

}
-(void)click:(UIButton*)btn
{

    if ([self.delegte respondsToSelector:@selector(reloadNetworkDataSource:)]) {
        [self.delegte reloadNetworkDataSource:btn];
    }
}

@end
