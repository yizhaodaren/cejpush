//
//  ViewController.m
//  JpushDemo
//
//  Created by 王树超 on 16/5/5.
//  Copyright © 2016年 王树超. All rights reserved.
//

#import "ViewController.h"
#import "JPUSHService.h"
@interface ViewController ()
//extern NSString *const kJPFNetworkIsConnectingNotification; // 正在连接中
//extern NSString *const kJPFNetworkDidSetupNotification;     // 建立连接
//extern NSString *const kJPFNetworkDidCloseNotification;     // 关闭连接
//extern NSString *const kJPFNetworkDidRegisterNotification;  // 注册成功
//extern NSString *const kJPFNetworkDidLoginNotification;     // 登录成功
//extern NSString *const kJPFNetworkDidReceiveMessageNotification;         // 收到消息(非APNS)
//extern NSString *const kJPFServiceErrorNotification;  // 错误提示
@end

@implementation ViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //注册通知JPUSH通知
    [self registerNOtification];
    
    
    //用于绑定Tag的 根据自己想要的Tag加入，值得注意的是这里Tag需要用到NSSet
    //[JPUSHService setTags:[NSSet set]callbackSelector:nil object:self];
    //用于绑定Alias的  使用NSString 即可
    //[JPUSHService setAlias:@"wsc" callbackSelector:@selector(back:) object:self];
  
    
    //用于同时绑定Tag与Alias的  我主要是在项目的登录成功或者自动登录后，使用用户的唯一标示进行绑定，或者根据需求添加一些前缀
    
   // [JPUSHService setTags:[NSSet set] alias:@"wsc" callbackSelector:@selector() target:self];
    
    
   // [JPUSHService setTags:[NSSet set] alias:@"wsc" callbackSelector:@selector(<#selector#>) object:<#(id)#>]
    
 
//    去除绑定
//    用户进行退出登录的方法里添加去除绑定即可，值得注意的是用到即时通讯的话，被挤下线也要去除绑定，已被坑，贴代码
    
    //没有值就代表去除
    //[JPUSHService setTags:[NSSet set]callbackSelector:nil object:self];
    //[JPUSHService setAlias:@"" callbackSelector:nil object:self];
    //[JPUSHService setTags:[NSSet set] alias:@"" callbackSelector:nil target:self];
    
    
    
    
    //本地通知  100秒以后会再次通知 程序在后台的时候也执行
//  UILocalNotification *location =  [JPUSHService setLocalNotification:[NSDate dateWithTimeIntervalSinceNow:100]
//                             alertBody:@"alert content"
//                                 badge:1
//                           alertAction:@"buttonText"
//                         identifierKey:@"identifierKey"
//                              userInfo:nil
//                             soundName:nil];
//    [JPUSHService showLocalNotificationAtFront:location identifierKey:nil];
//
    
    
}
#pragma mark 注册Jpusuh 的通知
-(void)registerNOtification{
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    
    //接受到自定义消息推送
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    // 错误提示
    [defaultCenter addObserver:self selector:@selector(ServiceErrorNotification:) name:kJPFServiceErrorNotification object:nil];
    
    //正在连接
    [defaultCenter addObserver:self selector:@selector(ConnectingNotification) name:kJPFNetworkIsConnectingNotification object:nil];
    //建立连接
    [defaultCenter addObserver:self selector:@selector(DidSetupNotification) name:kJPFNetworkDidSetupNotification object:nil];
    //关闭连接
    [defaultCenter addObserver:self selector:@selector(DidCloseNotification) name:kJPFNetworkDidCloseNotification object:nil];
    //注册成功
    [defaultCenter addObserver:self selector:@selector(DidRegisterNotification) name:kJPFNetworkDidRegisterNotification object:nil];
    //登录成功
    [defaultCenter addObserver:self selector:@selector(DidLoginNotification) name:kJPFNetworkDidLoginNotification object:nil];
    

}


#pragma mark 极光的通知消息处理
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    
    NSDictionary * userInfo = [notification userInfo];
    NSString *content = [userInfo valueForKey:@"content"];
    NSDictionary *extras = [userInfo valueForKey:@"extras"];
    NSString *customizeField1 = [extras valueForKey:@"customizeField1"]; //自定义参数，key是自己定义的
    NSLog(@"%@ ",content);
    NSLog(@"%@ ",customizeField1);
    
    
    
    
    
    
}
//收到错误消息
-(void)ServiceErrorNotification:(NSNotification*)notification{
    NSLog(@"收到错误消息");
}
//注册成功
-(void)DidRegisterNotification
{
    //登录激光以后 获取注册码
    NSLog(@"注册成功%@ ",[JPUSHService registrationID]);
  
}
-(void)ConnectingNotification
{
    NSLog(@"正在连接");
}
-(void)DidSetupNotification{
    NSLog(@"建立连接");
}
-(void)DidCloseNotification
{
    NSLog(@"关闭连接");
}
-(void)DidLoginNotification{
    NSLog(@"登录成功");

  
    //代码只被执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [JPUSHService setTags:[NSSet set] alias:[Manager md5:[k_NSUDF objectForKey:k_currentUser]] fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
            NSLog(@"%d",iResCode);
            NSLog(@"%@ ",iTags);
            NSLog(@"%@ ",iAlias);
        }];
    });
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
