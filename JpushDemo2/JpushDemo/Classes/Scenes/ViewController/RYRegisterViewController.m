//
//  RYRegisterViewController.m
//  JpushDemo
//
//  Created by 王树超 on 16/5/11.
//  Copyright © 2016年 王树超. All rights reserved.
//

#import "RYRegisterViewController.h"
#import "RYRegisterView.h"
#import "UIView+Extension.h"
#import <CommonCrypto/CommonDigest.h>
#import "JPUSHService.h"
@interface RYRegisterViewController ()
@property(nonatomic,strong)RYRegisterView *rootView;

@property(nonatomic,copy)NSString *account;
@property(nonatomic,copy)NSString *password;
@end

@implementation RYRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self initUI];
}
-(void)initUI{
    self.rootView = [[RYRegisterView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.rootView.loginButton addTarget:self action:@selector(Register)forControlEvents:UIControlEventTouchUpInside];
    
    [self.rootView.presentButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    self.view = self.rootView;
}
//登录按钮点击事件
-(void)Register{
    //非空验证
    if ([self.rootView.AccountTF.text isEqualToString:@""]) {
        [self.rootView.AccountTF ShakeView];
        return;
    }
    if ([self.rootView.passWordTF.text isEqualToString:@""]) {
        [self.rootView.passWordTF ShakeView];
        return;
    }
    NSString *str = [self.rootView.AccountTF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    _account =str;
    NSString *str1 = self.rootView.passWordTF.text;
    //加密
    _password = [Manager md5:str1];
    NSLog(@"%@",_password);
    
    
    
    
    //注册成功以后
    
    
    
    //注册完选择登陆的时候使用
    NSUserDefaults *userDefault = k_NSUDF;
    [userDefault setValue:_account forKey:k_currentUser];
    //同步
    [userDefault synchronize];
    
    [JPUSHService setTags:[NSSet set] alias:[Manager md5:_account] fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
        NSLog(@"%d",iResCode);
        NSLog(@"%@ ",iTags);
        NSLog(@"%@ ",iAlias);
    }];
    
}

-(void)dismiss{
    [self dismissViewControllerAnimated:YES completion:^{
        ;
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
