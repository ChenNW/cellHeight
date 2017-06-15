//
//  productCell.m
//  cell自定义高度
//
//  Created by RUAN-JSB-CNW on 2017/6/14.
//  Copyright © 2017年 cnw. All rights reserved.
//

#import "productCell.h"

@implementation productCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 图片
        self.image = [[UIImageView alloc] init];
        [self.contentView addSubview:self.image];
        
        // 标题
        self.title = [[UILabel alloc] init];
        [self.contentView addSubview:self.title];
        
        //总数
        self.total_count = [[UILabel alloc] init];
        self.total_count.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.total_count];
        
        //城市
        self.city = [[UILabel alloc] init];
        [self.contentView addSubview:self.city];
        
        //价格
        self.price = [[UILabel alloc] init];
        self.price.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.price];
        
        
        [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.top.equalTo(self.contentView).offset(10);
            make.width.and.height.offset(80);
        }];
        
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(20);
            make.left.equalTo(self.image.mas_right).offset(10);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(20);
        }];
        
        [self.total_count mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.title.mas_right).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.top.equalTo(self.contentView).offset(20);
            make.height.equalTo(self.title.mas_height);
            
        }];
        
        [self.city mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.title.mas_left);
            make.top.equalTo(self.image.mas_bottom);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(20);
        }];
        
        [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-10);
            make.top.equalTo(self.city.mas_top);
            make.left.equalTo(self.city.mas_right).offset(10);
            make.height.equalTo(self.city.mas_height);
        }];
    }
    return self;
}
@end
