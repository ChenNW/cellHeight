//
//  cellModel.m
//  cell自定义高度
//
//  Created by Cnw on 2017/6/13.
//  Copyright © 2017年 cnw. All rights reserved.
//

#import "cellModel.h"

@implementation cellModel

+(cellModel *)getModelWithDict:(NSDictionary *)dict
{
    cellModel * model = [[cellModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key  {
    if([key isEqualToString:@"id"])
        self.userID = value;
}


@end
