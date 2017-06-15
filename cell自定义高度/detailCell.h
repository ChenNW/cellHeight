//
//  detailCell.h
//  cell自定义高度
//
//  Created by Cnw on 2017/6/13.
//  Copyright © 2017年 cnw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cellModel.h"

@interface detailCell : UITableViewCell
/** 模型 */
//@property(nonatomic ,strong)cellModel *cellModel;
/** 内容 */
@property(nonatomic ,strong)UILabel *content;
/** 手机号 */
@property(nonatomic ,strong)UILabel *mobile;
/** 昵称 */
@property(nonatomic ,strong)UILabel *nickname;
/** 头像 */
@property(nonatomic ,strong)UIImageView *image;
/** 创建时间 */
@property(nonatomic ,strong)UILabel *create_time;
/** 评价图片 */
@property(nonatomic ,strong)UIImageView *images;
@property (nonatomic ,strong) NSMutableArray * imagesArray;
@end
