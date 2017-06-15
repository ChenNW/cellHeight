//
//  productCell.h
//  cell自定义高度
//
//  Created by RUAN-JSB-CNW on 2017/6/14.
//  Copyright © 2017年 cnw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface productCell : UITableViewCell
/** 标题 */
@property(nonatomic ,strong)UILabel *title;
/** 总数 */
@property(nonatomic ,strong)UILabel *total_count;
/** 价格 */
@property(nonatomic ,strong)UILabel *price;
/** 图片 */
@property(nonatomic ,strong)UIImageView *image;
/** 城市 */
@property(nonatomic ,strong)UILabel *city;
@end
