//
//  MainViewController.h
//  JpushDemo
//
//  Created by 王树超 on 16/5/12.
//  Copyright © 2016年 王树超. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^BLOCK)(NSDictionary * userInfo);
@interface MainViewController : UIViewController

@property(nonatomic,copy)BLOCK userInfoBlock;
@property(nonatomic,strong)NSString *itemString;

@end
