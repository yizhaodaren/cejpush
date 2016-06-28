//
//  RYLoginViewController.m
//  JpushDemo
//
//  Created by 王树超 on 16/5/11.
//  Copyright © 2016年 王树超. All rights reserved.
//

#import "RYLoginViewController.h"
#import "JPUSHService.h"
#import "RYLoginView.h"
#import "UIView+Extension.h"
#import <CommonCrypto/CommonDigest.h>
#import "RYRegisterViewController.h"
#import "MainViewController.h"
#import "LeftSortViewController.h"
#import "LeftSlideViewController.h"
#import "AppDelegate.h"
@interface RYLoginViewController ()
@property (weak, nonatomic) IBOutlet UIView *RootView;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumbetTF;

@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *getVerificationcodeButton;


- (IBAction)loginButtonAction:(id)sender;

- (IBAction)getVerificationcodeButtonAtion:(id)sender;


//@property(nonatomic,strong)RYLoginView *rootView;
//
//@property(nonatomic,copy)NSString *account;
//@property(nonatomic,copy)NSString *password;
@end

@implementation RYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    /[JPUSHService]
    [self initUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
}
-(void)keyboardWillShow:(NSNotification *)notification{
    static CGFloat normalKeyboardHeight = 216.0f;
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    CGFloat distancetomove = kbSize.height;
    NSLog(@"%f",distancetomove);
}
-(void)initUI{

    //设置背景透明
    [self.RootView setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.3]];
    self.RootView.layer.cornerRadius = 5;
    self.RootView.clipsToBounds = YES;
    
    
//    self.rootView = [[RYLoginView alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    [self.rootView.loginButton addTarget:self action:@selector(login)forControlEvents:UIControlEventTouchUpInside];
//    [self.rootView.presentButton addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
//                                                          
//    self.view = self.rootView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//登录按钮点击事件
-(void)login{
    //非空验证
//    if ([self.rootView.AccountTF.text isEqualToString:@""]) {
//        [self.rootView.AccountTF ShakeView];
//        return;
//    }
//    if ([self.rootView.passWordTF.text isEqualToString:@""]) {
//        [self.rootView.passWordTF ShakeView];
//        return;
//    }
//    NSString *str = [self.rootView.AccountTF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
//    _account =str;
//    NSString *str1 = self.rootView.passWordTF.text;
//    
//    //加密
//    _password = [Manager md5:str1];
//    NSLog(@"%@",_password);
//    
//    //登录
//    
//    
//    
//    
//    //得到登录成功反馈以后
//    
//    NSUserDefaults *userDefault = k_NSUDF;
//    [userDefault setValue:_account forKey:k_currentUser];
//    //同步
//    [userDefault synchronize];
//    
//     [JPUSHService setTags:[NSSet set] alias:[Manager md5:[k_NSUDF objectForKey:k_currentUser]] fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
    
#pragma mark 设置修改用户为可接受通知回到函数成功以后再调用跳转页面否者提示登录失败
    
//        NSLog(@"%d",iResCode);
//        NSLog(@"%@ ",iTags);
//        NSLog(@"%@ ",iAlias);
//    }];
    //跳转到主页
 
    
    
    

    //获取抽屉并模态过去
    [self presentViewController:g_App.leftSlideVC animated:YES completion:^{
        ;
    }];


}

//切换至注册
-(void)present{
    RYRegisterViewController *registerVC = [[RYRegisterViewController alloc]init];
    [self presentViewController:registerVC animated:YES completion:^{
        ;
    }];
}



- (IBAction)loginButtonAction:(id)sender {
    
    //获取抽屉并模态过去
    [self presentViewController:g_App.leftSlideVC animated:YES completion:^{
        ;
    }];
}

- (IBAction)getVerificationcodeButtonAtion:(id)sender {
}
@end
