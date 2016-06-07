//
//  UIFactory.m
//  JpushDemo
//
//  Created by 王树超 on 16/5/6.
//  Copyright © 2016年 王树超. All rights reserved.
//

#import "UIFactory.h"

@implementation UIFactory
+(instancetype)sharedUIFactory{
    static UIFactory *factory = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        factory = [[UIFactory alloc]init];
    });
    
    return factory;
}
//创建普通的不带点击方法的button
+(UIButton *)createButtonWithTiltle:(NSString *)title Frame:(CGRect)frame{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (title != nil) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if ((frame.size.height == CGRectZero.size.height)&&(frame.size.width == CGRectZero.size.width)) {
        
    }else{
         button.frame = frame;
    }
    return button;
}
//创建普通button带点击方法的
+(UIButton *)createCommonButton:(NSString *)title target:(id)target action:(SEL)selector{
    
   UIButton *button = [UIFactory createButtonWithTiltle:title];
    if ((selector != nil)&&(target != nil)) {
        [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    return button;
}
+(UIButton *)createButtonWithTiltle:(NSString *)title{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    return button;
}

+ (id)createLabelWith:(CGRect)frame
                 text:(NSString *)text
                 font:(UIFont *)font
            textColor:(UIColor *)textColor
      backgroundColor:(UIColor *)backgroundColor {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.font = font;
    label.textColor = textColor;
    label.backgroundColor = backgroundColor;
    return label;
}
@end
