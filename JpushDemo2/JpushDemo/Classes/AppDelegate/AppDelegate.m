//
//  AppDelegate.m
//  JpushDemo
//
//  Created by 王树超 on 16/5/5.
//  Copyright © 2016年 王树超. All rights reserved.
//

#import "AppDelegate.h"
#import "JPUSHService.h"

#define APPKEY @"911c809b54312c314659e432"
#import "RYMainViewController.h"
#import "MainViewController.h"
#import "LeftSortViewController.h"
#import "LeftSlideViewController.h"
#import "RYLoginViewController.h"
//微信支付
#import "WXApi.h"
#import "WXApiObject.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    

#pragma mark 状态栏操作
    //1、在info.plist中，将View controller-based status bar appearance设为NO.
    //2,设置手机上方的状态栏颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //隐藏状态栏操作
   // [UIApplication sharedApplication].statusBarHidden = YES;
#pragma mark 微信支付
    [WXApi registerApp:@"" withDescription:@"微信支付"];
 
    //如果程序不在运行状态 通过这里有没有值判断是根据通知打开还是（如果有值是通知打开的） 图标打开的
    NSDictionary *remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (remoteNotification) {
        NSLog(@"通知打开");
        NSLog(@"%@ ",remoteNotification);
    }else{
        NSLog(@"图标打开");
    }
    
#pragma makr 注册推送
    //极光推送
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                      UIRemoteNotificationTypeSound |UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    

    //JAppKey : 是你在极光推送申请下来的appKey Jchannel : 可以直接设置默认值即可 Publish channel
  [JPUSHService setupWithOption:launchOptions appKey:APPKEY
                          channel:@"Publish channel" apsForProduction:NO]; //如果是生产环境应该设置为YES


#pragma mark 布局
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor redColor];
    
    //window添加背景图片
    self.bgImgeView= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"image4.png"]];
    self.bgImgeView.frame =  CGRectMake(0, 0, k_ScreenWith, k_ScreenHeight);
    [self.window addSubview:self.bgImgeView];
    
    [self.window makeKeyAndVisible];
    
    
    
    
    
    
    
    

    
#pragma mark 抽屉主页面
    
    LeftSortViewController *leftSortVC = [[LeftSortViewController alloc]init];
    MainViewController *VC = [[MainViewController alloc]init];
    
  UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:VC];
    self.leftSlideVC = [[LeftSlideViewController alloc]initWithLeftView:leftSortVC andMainView:naVC];
    
//根据本地是否有用户登录
    if ([k_NSUDF boolForKey:k_FIRST]) {
        NSLog(@"存在用户");
        
#pragma mark 可选择 看是否需要
        //先去尝试登录反馈后  成功以后跳转到主页面
        
        self.window.rootViewController = self.leftSlideVC;
    }else{
        NSLog(@"不错在用户");
        RYMainViewController *vc = [[RYMainViewController alloc]init];
        vc.view.backgroundColor = [UIColor whiteColor];
        //登录界面
      //  RYLoginViewController *vc = [[RYLoginViewController alloc]init];
        self.window.rootViewController = vc;
        
        
      //启动后的一个动画
        CGFloat  mScreenWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat  mScreenHeight= [UIScreen mainScreen].bounds.size.height;
        UIImageView *splashView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, mScreenHeight)];
        //将图片添加到UIImageView对象中
        splashView.image=[UIImage imageNamed:@"zanwei"];
        [self.window addSubview:splashView];
        [self.window bringSubviewToFront:splashView];
        //设置动画效果
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:6.0];
        [UIView setAnimationDelegate:self];
        splashView.alpha=0.0;
        splashView.frame=CGRectMake(-60, -90, 440, 700);
        [UIView commitAnimations];

    }
    
    return YES;
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    NSString *alert = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    if (application.applicationState == UIApplicationStateActive) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"推送消息"
                                                            message:alert
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
    //[application setApplicationIconBadgeNumber:0];
    [JPUSHService handleRemoteNotification:userInfo];
    // Required,For systems with less than or equal to iOS6
   // [JPUSHService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {

    //收到通知传递给 RYMainView 展示
    
    if (((MainViewController *)self.leftSlideVC.mainVC).userInfoBlock) {
        
        ((MainViewController *)self.leftSlideVC.mainVC).userInfoBlock(userInfo);
    }
    
    
    
    NSString *alert = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    
    if (application.applicationState == UIApplicationStateActive) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"推送消息"
                                                            message:alert
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
    //[application setApplicationIconBadgeNumber:0];
    
    // IOS 7 Support Required
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}



//- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    // Override point for customization after application launch.
//    return YES;
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    
        NSLog(@"进将要入前台");
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
        NSLog(@"进入后台");
//    
//    UIBackgroundTaskIdentifier _bgTask;
//    
//    _bgTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
//        // Synchronize the cleanup call on the main thread in case
//        // the task actually finishes at around the same time.
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (_bgTask != UIBackgroundTaskInvalid)
//            {
//                [[UIApplication sharedApplication] endBackgroundTask:_bgTask];
//                
//                _bgTask = UIBackgroundTaskInvalid;
//            }
//        });
//    }];
    //亦或
    
#pragma mark  程序在后台的情况下 退出也可以执行applicationWillTerminate
    [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^(){
        //程序在10分钟内未被系统关闭或者强制关闭，则程序会调用此代码块，可以在这里做一些保存或者清理工作
        NSLog(@"程序关闭");
    }];

    
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    
    NSLog(@"进将要入后台");
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    
    NSLog(@"应用进入前台");
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
    NSLog(@"退出应用程序");
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//微信支付页面跳转

- (void)showAlert: (NSString *) message
{
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:message message:@" " delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [av show];
    //[self showMsg:message];
}
-(void)showAlertWithTitle:(NSString *)title CancelTitle:(NSString *)cancelTitle WithCancelHandel:(void(^)())cancenHandelBlock WithActionTitle:(NSString *)actionTitle WithActionHandel:(void(^)())actionhandelBlock WithTaget:(id)taget{
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:cancenHandelBlock];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:actionhandelBlock];
    [alertVC addAction:cancelAction];
    [alertVC addAction:okAction];
    [taget presentViewController:alertVC animated:YES completion:nil];
    
}


@end
