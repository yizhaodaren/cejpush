//
//  Headers.h
//  JpushDemo
//
//  Created by 王树超 on 16/6/1.
//  Copyright © 2016年 王树超. All rights reserved.
//

#ifndef Headers_h
#define Headers_h



#define k_NSUDF [NSUserDefaults standardUserDefaults]
#define k_ScreenWith [UIScreen mainScreen].bounds.size.width
#define k_ScreenHeight [UIScreen mainScreen].bounds.size.height
#define k_WhiteColor [UIColor whiteColor]



#define g_App ((AppDelegate*)[[UIApplication sharedApplication] delegate])
#define g_window [UIApplication sharedApplication].keyWindow
#define g_wait [JXWaitView sharedInstance]




#define k_currentUser @"currentUser"

#define k_FIRST @"firstStart"
#define k_USER @"user"
#define k_PWD  @"password"

//Masonry使用
#define WS(weakSelf) __weak __typeof(&*self)weakSelf = self;


#endif /* Headers_h */
