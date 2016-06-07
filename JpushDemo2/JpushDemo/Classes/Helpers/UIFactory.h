//
//  UIFactory.h
//  JpushDemo
//
//  Created by 王树超 on 16/5/6.
//  Copyright © 2016年 王树超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define k_factory UIFactory 
@interface UIFactory : NSObject
+(instancetype)sharedUIFactory;

//根据标题床架button
+(UIButton *)createButtonWithTiltle:(NSString *)title;
//创建普通的不带点击方法的button
+(UIButton *)createButtonWithTiltle:(NSString *)title Frame:(CGRect)frame;
//创建普通button带点击方法的
+(UIButton *)createCommonButton:(NSString *)title target:(id)target action:(SEL)selector;

+ (id)createLabelWith:(CGRect)frame
                 text:(NSString *)text
                 font:(UIFont *)font
            textColor:(UIColor *)textColor
      backgroundColor:(UIColor *)backgroundColor;

@end
