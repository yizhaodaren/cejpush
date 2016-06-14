//
//  RYMainViewController.m
//  JpushDemo
//
//  Created by 王树超 on 16/5/6.
//  Copyright © 2016年 王树超. All rights reserved.
//

#import "RYMainViewController.h"
#import "RYMainView.h"
#import "OpengingTheAnimatonView.h"
#import "LeftSlideViewController.h"
#import "LeftSortViewController.h"
#import "ViewController.h"
#import "RYLoginViewController.h"
@interface RYMainViewController ()
//开屏动画
@property(nonatomic,strong)OpengingTheAnimatonView *animation;
@property(nonatomic,strong)RYMainView *mainView;
@end

@implementation RYMainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
   
//    static int isFullScreen; //   1 == 全屏  3 == 竖屏
//    
//    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
//        
//        SEL selector = NSSelectorFromString(@"setOrientation:");
//        
//        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
//        
//        [invocation setSelector:selector];
//        
//        [invocation setTarget:[UIDevice currentDevice]];
//        
//        isFullScreen  = 2;
//        NSLog(@"-%d-",isFullScreen);
//        
//        [invocation setArgument:&isFullScreen atIndex:2];
//        NSLog(@"-%d-",isFullScreen);
//        
//        [invocation invoke];
//        
//    }
    
    //初始化界面
    [self initUI];
    //因为动画是添加到self.view 上的 所以这里要在设置好self.view 以后设置动画
    [self OpeningAnimation];
    
}

-(void)initUI{
    self.mainView = [[RYMainView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.mainView.backgroundColor = [UIColor grayColor];
    self.mainView.button.backgroundColor = [UIColor redColor];
    self.view = self.mainView;
    
    [self.mainView.button addTarget:self action:@selector(buttonDidClicked) forControlEvents:UIControlEventTouchUpInside];

}

-(void)OpeningAnimation{
    self.animation = [OpengingTheAnimatonView addToView:self.view withImage:[UIImage imageNamed:@"TwitterLogo_white"] backgroundColor:[UIColor colorWithRed:85/255.f green:172/255.f blue:238/255.f alpha:1]];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.animation startAnimation];
    });
    
}

-(void)buttonDidClicked{
    
    
//    LeftSortViewController *leftSortVC = [[LeftSortViewController alloc]init];
//    
//    
//    ViewController *VC = [[ViewController alloc]init];
//  
//    LeftSlideViewController *leftVC = [[LeftSlideViewController alloc]initWithLeftView:leftSortVC andMainView:VC];
    

    
   //[self presentViewController:leftVC animated:YES completion:nil];
    
    RYLoginViewController *loginVC =[[RYLoginViewController alloc]init];
    [self presentViewController:loginVC animated:YES completion:^{
        ;
    }];
    
}

//#pragma mark 结束减速的时候
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    NSInteger index = self.mainView.mainScrollView.contentOffset.x/k_ScreenWith;
//    self.mainView.mainScrollView.contentOffset =CGPointMake(index * k_ScreenWith, 0);
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 控制横屏竖屏的
//-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//{
//    return UIInterfaceOrientationLandscapeLeft;
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskLandscape;
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
 
 
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
