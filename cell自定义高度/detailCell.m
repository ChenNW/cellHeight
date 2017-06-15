//
//  detailCell.m
//  cell自定义高度
//
//  Created by Cnw on 2017/6/13.
//  Copyright © 2017年 cnw. All rights reserved.
//

#import "detailCell.h"
#define imageW  50
@interface detailCell ()

@end

@implementation detailCell
-(NSMutableArray *)imagesArray
{
    if (!_imagesArray) {
        _imagesArray = [NSMutableArray array];
    }
    
    return _imagesArray;
}

- (void)awakeFromNib {
    [super awakeFromNib];
   self.contentView.bounds = [UIScreen mainScreen].bounds;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initContent];
//        self.backgroundColor = [UIColor redColor];
    }
    
    return self;

}
-(void)initContent
{
    self.image = [[UIImageView alloc] init];
    self.image.layer.cornerRadius = imageW/2;
    self.image.clipsToBounds = YES;
    [self.contentView addSubview:self.image];
    
    self.nickname = [[UILabel alloc] init];
    self.nickname.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.nickname];
    
    self.mobile = [[UILabel alloc] init];
    self.mobile.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.mobile];
    
    self.create_time = [[UILabel alloc] init];
    self.create_time.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.create_time];
    
    
    self.content = [[UILabel alloc] init];
    self.content.numberOfLines = 0;
    self.content.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:self.content];
    

//    self.images = [[UIImageView alloc] init];
//    [self.contentView addSubview:self.images];

    // 头像
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(10);
        make.width.and.height.offset(imageW);
    }];
    
    // 昵称
    [self.nickname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.image.mas_right).offset(10);
        make.centerY.equalTo(self.image.mas_centerY);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];

    // 电话
    [self.mobile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nickname.mas_right).offset(10);
        make.centerY.equalTo(self.image.mas_centerY);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);
        
    }];
    
    // 创建时间
    [self.create_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mobile.mas_right).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.centerY.equalTo(self.image.mas_centerY);
        make.height.mas_equalTo(20);
    }];
    
    // 内容
    self.content.font = [UIFont systemFontOfSize:16];
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.left.equalTo(self.nickname.mas_left).offset(0);
        make.top.equalTo(self.image.mas_bottom).offset(0);
        make.right.equalTo(self.contentView).offset(-15);
        
    }];
    
//    // 下边图片
 
    NSLog(@"%ld--------",self.imagesArray.count);
    for (int i = 0; i <self.imagesArray.count; i++) {
        self.images = [[UIImageView alloc] init];
        [self.contentView addSubview:self.images];
        
        [self.images mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nickname.mas_left).offset(i *(imageW + 10));
            make.top.equalTo(self.content.mas_bottom).offset(10);
            make.width.and.height.offset(50);
        }];
        
    }
    
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat totalHeight = 0;
    
    CGFloat h;
    if (self.images.image == nil) {
        h = imageW;
    }else{
        h = 2*imageW ;
    }
    totalHeight += h + [self.content sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width - imageW -35, 0)].height;

    
    totalHeight += 30;
     // margins
    return CGSizeMake(size.width, totalHeight);
}
@end
