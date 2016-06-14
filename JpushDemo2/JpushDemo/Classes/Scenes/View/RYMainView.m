//
//  RYMainView.m
//  JpushDemo
//
//  Created by 王树超 on 16/5/6.
//  Copyright © 2016年 王树超. All rights reserved.
//

#import "RYMainView.h"

#define PagesCount 3

@interface RYMainView()<UIScrollViewDelegate>

@end

@implementation RYMainView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createMainScrollView];
        [self createImageView];
        [self createButton];
        [self createPageControl];
        
    }
       return self;
}
-(void)createMainScrollView{
    self.mainScrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    //设置 contentSize, 3个
    self.mainScrollView.contentSize = CGSizeMake(PagesCount*k_ScreenWith, 0);
    //设置不让弹动
    [self.mainScrollView setBounces:NO];
    //设置整页翻动
    self.mainScrollView.pagingEnabled = YES;
   //不显示横向滚动条
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    
    //设置代理
    self.mainScrollView.delegate = self;
    [self addSubview:self.mainScrollView];
    
}
-(void)createImageView{
    for (int i = 1; i <PagesCount + 1; i++) {
        //图片名字
        NSString *name = [NSString stringWithFormat:@"image%d.png",i];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((i-1)*k_ScreenWith,0, k_ScreenWith, k_ScreenHeight)];
        imageView.image = [UIImage imageNamed:name];
        
        imageView.userInteractionEnabled = YES;
        [self.mainScrollView addSubview:imageView];
        
    }
}
-(void)createButton{
    //布局
    self.button = [UIFactory createButtonWithTiltle:@"kaish" Frame:CGRectMake(k_ScreenWith * (PagesCount -1),k_ScreenHeight/3*2, k_ScreenWith, k_ScreenHeight/3)];
    //self.button.center = self.center;
    
    [self.mainScrollView addSubview:self.button];

}
-(void)createPageControl{
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, k_ScreenHeight-100, k_ScreenWith, 40)];
    self.pageControl.numberOfPages = PagesCount;
    [self addSubview:self.pageControl];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.pageControl.currentPage = self.mainScrollView.contentOffset.x/(k_ScreenWith);
}
@end
