//
//  mainView.h
//  JpushDemo
//
//  Created by 王树超 on 16/5/12.
//  Copyright © 2016年 王树超. All rights reserved.
//

#import <UIKit/UIKit.h>

@class instructionView;

@interface mainView : UIView
@property(nonatomic,strong)UISegmentedControl *segment;
@property(nonatomic,strong)UIScrollView *mainScrollView;
//tableView
@property(nonatomic,strong)UITableView *mainTableView;
//collectonView
@property(nonatomic,strong)UICollectionView *mainCollectionView;
//webView
@property(nonatomic,strong)UIWebView *mainWebView;

//说明的页面
@property(nonatomic)instructionView *instructionView;

//tempView;
@property(nonatomic,strong)UIView *tempView;

//轮播图
@property(nonatomic,strong)SDCycleScrollView *cycleView;
@end
