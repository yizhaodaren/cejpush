//
//  OpengingTheAnimatonView.h
//  JpushDemo
//
//  Created by 王树超 on 16/5/9.
//  Copyright © 2016年 王树超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpengingTheAnimatonView : UIView
+ (instancetype)addToView:(UIView *)view withImage:(UIImage *)image backgroundColor:(UIColor *)backgroundColor;

- (void)startAnimation;
@end
