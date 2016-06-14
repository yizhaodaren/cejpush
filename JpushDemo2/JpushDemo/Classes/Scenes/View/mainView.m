//
//  mainView.m
//  JpushDemo
//
//  Created by 王树超 on 16/5/12.
//  Copyright © 2016年 王树超. All rights reserved.
//

#import "mainView.h"

@implementation mainView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    [self createSegment];
    [self createScrollView];
    [self createTable];
    [self createCollectionView];
    [self createWebView];
    }
    return self;
}
-(void)createSegment{
    NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"消息"];
    NSRange messageRange = {0,[message length]};
    [message addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:messageRange];
    
    NSMutableAttributedString * telephone = [[NSMutableAttributedString alloc]initWithString:@"电话"];
    NSRange telephoneRange = {0,[telephone length]};
    [telephone addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:telephoneRange];
    
    
    self.segment = [[UISegmentedControl alloc]initWithItems:@[@"消息",@"语音应答",@"使用说明"]];
    self.segment.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3];
    self.segment.tintColor = [UIColor whiteColor];


    //点击的效果
    self.segment.momentary = YES;
    self.segment.layer.masksToBounds = YES;
    
    //设置segment的颜色
    self.segment.tintColor = [UIColor clearColor];
    
    //一种字体
    //NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName: [UIColor lightTextColor]};
    //设置选择状态的字体
   // [self.segment setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];
    //设置文字属性
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName: [UIColor whiteColor]};
    [self.segment setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];

    
    //设置
   // self.segment.tintColor= [UIColor colorWithRed:0.0 green:0.00 blue:0.0 alpha:0.20];

    [self addSubview:self.segment];
    WS(ws)
    
    [self.segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@64);
        make.left.equalTo(@0);
        make.right.equalTo(ws);
        make.height.equalTo(@45);
    }];
    self.tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 42, k_ScreenWith/3, 3)];
    self.tempView.backgroundColor = [UIColor redColor];
    [self.segment addSubview: self.tempView];

}

//创建大的ScrollView
-(void)createScrollView{
    self.mainScrollView = [[UIScrollView alloc]init];
    [self addSubview:self.mainScrollView];
    self.mainScrollView.backgroundColor =[UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    self.mainScrollView.contentSize = CGSizeMake(k_ScreenWith * 3, 0);
    self.mainScrollView.scrollEnabled = NO;
    //self.mainScrollView.pagingEnabled = YES;
    
    
    WS(ws)
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.segment.mas_bottom);
        make.left.equalTo(ws);
        make.right.equalTo(ws);
        make.bottom.equalTo(ws);
    }];
}
//创建TableView
-(void)createTable{
    //创建mainTableView
    self.mainTableView = [[UITableView alloc]
    initWithFrame:CGRectMake(0, 0, k_ScreenWith, k_ScreenHeight - 64 -45) style:UITableViewStyleGrouped];
    
    
    NSArray *array = @[@"h1.jpg",@"h2.jpg"];
    self.cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, k_ScreenWith, 100) shouldInfiniteLoop:YES imageNamesGroup:array];
    
    
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    
   // self.cycleView.imageURLStringsGroup = imagesURLStrings;

    //添加headerView
    self.mainTableView.tableHeaderView = self.cycleView;
    //设置背景透明
    self.mainTableView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    //隐藏滚动条
    self.mainTableView.showsVerticalScrollIndicator = NO;
    
    
    [self.mainScrollView addSubview:self.mainTableView];
    
}
//创建collectionView
-(void)createCollectionView{
    //他决定了collectionView的布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(100, 100);
    layout.minimumLineSpacing= 10;
    layout.minimumInteritemSpacing = 10;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    layout.headerReferenceSize = CGSizeMake(375, 50);
    layout.footerReferenceSize = CGSizeMake(375, 50);
    
    self.mainCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(k_ScreenWith, 0, k_ScreenWith, k_ScreenHeight - 100) collectionViewLayout:layout];
    
    
    self.mainCollectionView.backgroundColor = [UIColor grayColor];
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"image1"]];
    image.userInteractionEnabled = YES;
    self.mainCollectionView.backgroundView = image;
    
    
    [self.mainScrollView addSubview:self.mainCollectionView];

    
//    self.mainCollectionView = [UICollectionView ]
}
-(void)createWebView{
    self.mainWebView = [[UIWebView alloc]initWithFrame:CGRectMake(k_ScreenWith *2, 0, k_ScreenWith, k_ScreenHeight - 64 -45)];
    self.mainWebView.backgroundColor = [UIColor whiteColor];
    [self.mainScrollView addSubview:self.mainWebView];
}

@end
