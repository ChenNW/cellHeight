//
//  detailViewController.m
//  cell自定义高度
//
//  Created by RUAN-JSB-CNW on 2017/6/13.
//  Copyright © 2017年 cnw. All rights reserved.
//

#import "detailViewController.h"
#import <UIButton+WebCache.h>
#import <UIImageView+WebCache.h>

#import "requestManger.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "detailCell.h"
#import "productCell.h"

#define imageCount 4
@interface detailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    int page;
    NSInteger Tag;
    NSInteger selectIndex ;
}
@property (nonatomic , strong) UIView * headView,*lineView;
@property (nonatomic ,strong) UIButton * imageBtn,*typeBtn;
@property (nonatomic ,strong) UITableView * tableView;
@property (nonatomic ,strong) UIScrollView * scrollView;
@property (nonatomic ,strong) NSMutableArray * imagesArray,*allproductlist,*commentlist;

@end

@implementation detailViewController

-(NSMutableArray *)imagesArray
{
    if (!_imagesArray) {
        _imagesArray = [NSMutableArray array];
        NSArray * array = @[@"http:\/\/imgsh.shunhongweb.com\/uploads\/static\/image\/20170606\/1496742515238985.png",
                            @"http:\/\/imgsh.shunhongweb.com\/uploads\/static\/image\/20170606\/1496742515238985.png",
                            @"http:\/\/imgsh.shunhongweb.com\/uploads\/static\/image\/20170606\/1496742515238985.png",
                            @"http:\/\/imgsh.shunhongweb.com\/uploads\/static\/image\/20170606\/1496742966532067.png",
                            @"http:\/\/imgsh.shunhongweb.com\/uploads\/static\/image\/20170606\/1496742966532067.png",
                            @"http:\/\/imgsh.shunhongweb.com\/uploads\/static\/image\/20170606\/1496742515238985.png",
                            @"http:\/\/imgsh.shunhongweb.com\/uploads\/static\/image\/20170606\/1496742966532067.png"
                            ];
        [_imagesArray addObjectsFromArray:array];
    }
    
    return _imagesArray;

}
-(NSMutableArray *)allproductlist
{
    if (!_allproductlist) {
        _allproductlist = [NSMutableArray array];
    }
    
    return _allproductlist;
    
}
-(NSMutableArray *)commentlist
{
    if (!_commentlist) {
        _commentlist = [NSMutableArray array];
    }
    
    return _commentlist;
    
}
/**
 "http:\/\/imgsh.shunhongweb.com\/uploads\/static\/image\/20170606\/1496742515238985.png",
 "http:\/\/imgsh.shunhongweb.com\/uploads\/static\/image\/20170606\/1496742515238985.png",
 "http:\/\/imgsh.shunhongweb.com\/uploads\/static\/image\/20170606\/1496742515238985.png",
 "http:\/\/imgsh.shunhongweb.com\/uploads\/static\/image\/20170606\/1496742515238985.png"
 
 */


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    

}
-(void)getData
{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"session_key"] = @"575414970041929965";
    dict[@"storeid"] = @"4";
    
    [requestManger postReqeustWithURL:@"http://api.yibangw.com/store/machinedetail"
                               params:dict
                         successBlock:^(id returnData) {
                            
                             [self.imagesArray addObjectsFromArray:returnData[@"imagesarr"]];
                             [self.commentlist addObjectsFromArray:returnData[@"commentlist"]];
                             [self.allproductlist addObjectsFromArray:returnData[@"allproductlist"]];
                             [self setUI];
                             [self.tableView reloadData];

                       } failureBlock:^(NSError *error) {
                            
                      } requestTarget:self ishide:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情";
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self initTableView];
    [self getData];
    [self setUI];
   
    
}
// 初始化
-(void)initTableView
{
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    self.tableView = tableView;
    Tag = 100;
    tableView.tableHeaderView = [UIView new];
    self.tableView.fd_debugLogEnabled = YES;
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[detailCell class] forCellReuseIdentifier:@"detaliCell"];
    [self.view addSubview:tableView];

}
-(void)setUI
{
    if (self.headView) {
        [self.headView removeFromSuperview];
    }
    
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kWidth, 300)];
//    self.headView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:self.headView];
    self.tableView.tableHeaderView = self.headView;
    // 商家
    UIView * one = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 150)];
    one.backgroundColor = [UIColor redColor];
    [self.headView addSubview:one];
    
    // 图片
    UIView * two = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(one.frame), kWidth, 100)];
    [self.headView addSubview:two];
    two.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    
    // 相册label
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 35, two.frame.size.height)];
//    label.backgroundColor = [UIColor lightGrayColor];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"相\n册";
    [two addSubview:label];
    
    // 点击按钮
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth - 35, 0, 35, label.frame.size.height)];
//    [btn setBackgroundColor:[UIColor orangeColor]];
    btn.enabled = self.imagesArray.count > imageCount ? YES : NO;
    btn.titleLabel.lineBreakMode = 0;
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn setTitle:@"下\n一\n页" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn addTarget:self action:@selector(nextGroup) forControlEvents:UIControlEventTouchUpInside];
    [two addSubview:btn];
    
    // scrollview
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 0, two.frame.size.width - label.frame.size.width - btn.frame.size.width, btn.frame.size.height)];
    self.scrollView = scrollView;
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    
    CGFloat w = (scrollView.frame.size.width - 30)/imageCount;
    for (int i = 0; i < self.imagesArray.count; i++) {
        UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(i *(w + 10), (scrollView.frame.size.height - w)/2, w, w)];
        self.imageBtn = btn;
        [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:self.imagesArray[i]] forState:UIControlStateNormal placeholderImage: [UIImage imageNamed:@"123"]];
        [scrollView addSubview:btn];
    }
    
    scrollView.contentSize = CGSizeMake((self.imagesArray.count % imageCount == 0 ? self.imagesArray.count/imageCount :self.imagesArray.count/imageCount +1) * scrollView.frame.size.width, 0);
    [two addSubview:scrollView];
    
    // 按钮视图
    
    UIView * btnView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(two.frame), two.frame.size.width, 45)];
    [self.headView addSubview:btnView];
    btnView.backgroundColor = [UIColor whiteColor];
    
    NSArray * array = @[@"所有商品",@"商品评价"];
    for (int i = 0; i < 2; i++) {
        UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(i*btnView.frame.size.width/2, 0, btnView.frame.size.width/2, btnView.frame.size.height)];
        btn.tag = 100 + i;
        Tag = btn.tag;
        self.typeBtn = btn;
        [btn addTarget:self action:@selector(showData:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btnView addSubview:btn];
        if (i == 0) {
            [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        }else{
        
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }
        
    }
    
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.typeBtn.frame), self.typeBtn.width, 2)];
    self.lineView = line;
    line.backgroundColor = [UIColor orangeColor];
    [btnView addSubview:line];

    
    if (Tag == 100) {
        line.centerX = self.typeBtn.centerX;
    }
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (selectIndex == 0) {
        return self.allproductlist.count;
    }else{
     
        return self.commentlist.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (selectIndex == 0) {
        NSDictionary * dict = self.allproductlist[indexPath.row];
        productCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[productCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
    cell.title.text = dict[@"title"];
    cell.total_count.text = @"200个";
    cell.price.text = @"200元";
    cell.city.text = @"上海";
    [cell.image sd_setImageWithURL:[NSURL URLWithString:@"http:\/\/imgsh.shunhongweb.com\/uploads\/static\/image\/20170606\/1496742515238985.png"] placeholderImage:[UIImage imageNamed:@""]];
        return cell;
        
    }else{
    detailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"detaliCell"];
    [self configureCell:cell atIndexPath:indexPath];
        return cell;
    }
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( selectIndex == 1) {
        return [tableView fd_heightForCellWithIdentifier:@"detaliCell" cacheByIndexPath:indexPath configuration:^(detailCell * cell) {
            [self configureCell:cell atIndexPath:indexPath];
        }];
    }else{
   
    return 120;
        
    }

}
#pragma mark - 下一组图片
-(void)nextGroup
{
   
    NSInteger pages = self.imagesArray.count % imageCount == 0 ? (self.imagesArray.count / imageCount -1 ): self.imagesArray.count / imageCount;
    
    if (page >= pages ) {
        [LCProgressHUD showMessage:@"没有更多了"];
    }else{
   
        self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    }
    page ++;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
     page = scrollView.contentOffset.x /scrollView.frame.size.width;

}

-(void)showData:(UIButton *)btn
{
    self.lineView.centerX = btn.centerX;
    NSInteger tag = btn.tag - 100;
    switch (tag) {
        case 0:
        {
            selectIndex = 0;
            for (int i = 0; i < 2; i++) {
                if (i!=0) {
                    UIButton *btn = (UIButton *)[self.view viewWithTag:i + 100];
                    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                }
                
            }
           
            
        }
            break;
        case 1:
        {
            selectIndex = 1;
            for (int i = 0; i < 2; i++) {
                if (i!=1) {
                    UIButton *btn = (UIButton *)[self.view viewWithTag:i+100];
                    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                    
                }
                
            }

            
        }
            break;
            
        default:
            break;
    }
    
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];

    [self.tableView reloadData];
    
}
- (void)configureCell:(detailCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.fd_enforceFrameLayout = NO;
    cellModel * model = [cellModel getModelWithDict:self.commentlist[indexPath.row]];
    cell.mobile.text = model.mobile;
    cell.nickname.text = model.nickname;
    [cell.image sd_setImageWithURL:[NSURL URLWithString:model.image.length >0 ? model.image : @""] placeholderImage:[UIImage imageNamed:@""]];
    NSString * str;
    if (indexPath.row == 0) {
        str = @"蝶花地文化低味道好i额u文化低威海卫都和我i电话i味道好唯";
    }else if (indexPath.row == 1){
    
      str = @"蝶花地文化低味道好i额u文化低威海卫都和我i电话i味道好唯蝶花地文化低味道好i额u文化低威海卫都和我i电话i味道好唯蝶花地文化低味道好i额u文化低威海卫都和我i电话i味道好唯蝶花地文化低味道好i额u文化低威海卫都和我i电话i味道好唯蝶花地文化低味道好i额u文化低威海卫都和我i电话i味道好唯";
    }else{
    
    str = @"蝶花地文化低味道好i额u文化低威海卫都和我i电话i味道好唯蝶花地文化低味道好i额u文化低威海卫都和我i电话i味道好唯蝶花地文化低味道好i额u文化低威海卫都和我i电话i味道好唯蝶花地文化低味道好i额u文化低威海卫都和我i电话i味道好唯蝶花地文化低味道好i额u文化低威海卫都和我i电话i味道好唯蝶花地文化低味道好i额u文化低威海卫都和我i电话i味道好唯蝶花地文化低味道好i额u文化低威海卫都和我i电话i味道好唯蝶花地文化低味道好i额u文化低威海卫都和我i电话i味道好唯蝶花地文化低味道好i额u文化低威海卫都和我i电话i味道好唯";
    }
    cell.content.text = str;
    cell.create_time.text = model.create_time;
    
    NSString * url ,* url1 ,*url2;
//    NSMutableArray * array;
//    cell.imagesArray = array;
  
//    if (indexPath.row == 0) {
//        if (cell.imagesArray.count >0) {
//            [cell.imagesArray removeAllObjects];
//        }
//        url = @"http:\/\/imgsh.shunhongweb.com\/uploads\/static\/image\/20170606\/1496742966532067.png";
//        url1 = @"http:\/\/imgsh.shunhongweb.com\/uploads\/static\/image\/20170606\/1496742966532067.png";
//        [cell.imagesArray addObject:url]; [cell.imagesArray addObject:url1];
//    }else if (indexPath.row == 1){
//        if (cell.imagesArray.count >0) {
//            [cell.imagesArray removeAllObjects];
//        }
//        url = @"http:\/\/imgsh.shunhongweb.com\/uploads\/static\/image\/20170606\/1496742966532067.png";
//        [cell.imagesArray addObject:url];
//
//    
//    }else{
        if (cell.imagesArray.count >0) {
            [cell.imagesArray removeAllObjects];
        }
        url2 = @"http:\/\/imgsh.shunhongweb.com\/uploads\/static\/image\/20170606\/1496742966532067.png";
        url = @"http:\/\/imgsh.shunhongweb.com\/uploads\/static\/image\/20170606\/1496742966532067.png";
        url1 = @"http:\/\/imgsh.shunhongweb.com\/uploads\/static\/image\/20170606\/1496742966532067.png";
        [cell.imagesArray addObject:url]; [cell.imagesArray addObject:url1];[cell.imagesArray addObject:url2];
//
//    }
    NSLog(@"%@---%ld---%@",cell.imagesArray,cell.imagesArray.count,cell.imagesArray[indexPath.row]);
    [cell.images sd_setImageWithURL:[NSURL URLWithString:cell.imagesArray[indexPath.row]] placeholderImage:[UIImage imageNamed:@""]];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (selectIndex == 1) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
}









@end
