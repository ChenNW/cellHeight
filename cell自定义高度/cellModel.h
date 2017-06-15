//
//  cellModel.h
//  cell自定义高度
//
//  Created by Cnw on 2017/6/13.
//  Copyright © 2017年 cnw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface cellModel : NSObject
+(cellModel *)getModelWithDict:(NSDictionary *)dict;


@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *image;
@property (nonatomic ,strong) NSArray * images;
@property (nonatomic ,copy) NSString * userID;
@end
