//
//  AppDelegate.h
//  JpushDemo
//
//  Created by 王树超 on 16/5/5.
//  Copyright © 2016年 王树超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftSlideViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong)UIImageView *bgImgeView;

@property(nonatomic,strong)LeftSlideViewController *leftSlideVC;

//封装弹框
-(void)showAlert:(NSString *)message;
-(void)showAlertWithTitle:(NSString *)title CancelTitle:(NSString *)cancelTitle WithCancelHandel:(void(^)())cancenHandelBlock WithActionTitle:(NSString *)actionTitle WithActionHandel:(void(^)())actionhandelBlock WithTaget:(id)taget;
@end

