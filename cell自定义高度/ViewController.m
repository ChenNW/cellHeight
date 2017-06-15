//
//  ViewController.m
//  cell自定义高度
//
//  Created by RUAN-JSB-CNW on 2017/6/13.
//  Copyright © 2017年 cnw. All rights reserved.
//

#import "ViewController.h"
#import "detailViewController.h"
@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"hello";
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 180, 100, 100)];
    btn.backgroundColor = [UIColor purpleColor];
    [btn setTitle:@"点击" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)jump
{
    detailViewController * detail= [[detailViewController alloc] init];
    [self.navigationController pushViewController:detail animated:YES];
}
@end
