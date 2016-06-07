//
//  UIView+Extension.m
//  JpushDemo
//
//  Created by 王树超 on 16/5/11.
//  Copyright © 2016年 王树超. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
/**
 *  @brief  震动动画
 */
-(void)ShakeView
{
    self.translatesAutoresizingMaskIntoConstraints = YES;
    CALayer *lbl = [self layer];
    CGPoint posLbl = [lbl position];
    CGPoint y = CGPointMake(posLbl.x-10, posLbl.y);
    CGPoint x = CGPointMake(posLbl.x+10, posLbl.y);
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    [animation setAutoreverses:YES];
    [animation setDuration:0.07];
    [animation setRepeatCount:3];
    [lbl addAnimation:animation forKey:nil];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
}

@end
