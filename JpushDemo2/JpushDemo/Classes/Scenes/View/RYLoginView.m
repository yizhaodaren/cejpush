//
//  RYLoginView.m
//  JpushDemo
//
//  Created by 王树超 on 16/5/11.
//  Copyright © 2016年 王树超. All rights reserved.
//

#import "RYLoginView.h"
#import <Masonry.h>
#define WS(weakSelf) __weak __typeof(&*self)weakSelf = self;
@interface RYLoginView()
@property(nonatomic,strong)UIView *BackView;
@property(nonatomic,strong)UILabel *AccountLable;
@property(nonatomic,strong)UILabel *PasswordLable;
@end

@implementation RYLoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createBackView];
        [self initUI];
        
    }
    return self;
}

//背景View
-(void)createBackView{
    self.BackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, k_ScreenWith, k_ScreenHeight/3)];
    self.BackView.center = self.center;
    [self.BackView setBackgroundColor:[UIColor colorWithRed:255/255.0 green:251/255.0 blue:240/255.0 alpha:0.5]];
    [self addSubview:self.BackView];
}
-(void)initUI{
    //账号标签
    self.AccountLable = [[UILabel alloc]init];
    self.AccountLable.text = @"账号";
    
    //密码标签
    self.AccountLable.backgroundColor = [UIColor redColor];
    self.PasswordLable = [[UILabel alloc]init];
     self.PasswordLable.text = @"密码";
    //账号输入框
    self.AccountTF = [[UITextField alloc]init];
    self.AccountTF.backgroundColor = [UIColor blackColor];
    self.AccountTF.keyboardType = UIKeyboardTypeNumberPad;
    
    //密码输入框
    self.passWordTF = [[UITextField alloc]init];
    self.passWordTF.backgroundColor = [UIColor blackColor];
    self.passWordTF.secureTextEntry = YES;
    //登录按钮
    self.loginButton = [k_factory createButtonWithTiltle:@"登录"];
    self.loginButton.backgroundColor = [UIColor blueColor];
    
    //切换按钮
    self.presentButton = [k_factory createButtonWithTiltle:@"注册"];
    self.presentButton.backgroundColor = [UIColor redColor];
    
    [self.BackView addSubview:self.AccountLable];
    [self.BackView addSubview:self.PasswordLable];
    [self.BackView addSubview:self.AccountTF];
    [self.BackView addSubview:self.passWordTF];
    [self.BackView addSubview:self.loginButton];
    [self.BackView addSubview:self.presentButton];
    
    //创建一个弱类型的self
    WS(ws);
    [self.AccountLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@20);
        make.width.equalTo(@40);
        make.height.equalTo(@40);
        
    }];
    [self.PasswordLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.AccountLable.mas_left);
        make.top.equalTo(ws.AccountLable.mas_bottom).offset(20);
        make.width.equalTo(ws.AccountLable);
        make.height.equalTo(@40);
    }];
    [self.AccountTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.AccountLable);
        make.left.equalTo(ws.AccountLable.mas_right).offset(20);
        make.right.equalTo(ws.mas_right).offset(-20);
        make.height.equalTo(ws.AccountLable);
    }];
      [self.passWordTF mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.equalTo(ws.AccountTF);
          make.width.equalTo(ws.AccountTF);
          make.top.equalTo(ws.PasswordLable);
          make.height.equalTo(ws.AccountTF);
      }];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws);
        make.top.equalTo(ws.passWordTF.mas_bottom).offset(20);
        make.width.equalTo(@200);
        make.height.equalTo(@45);
    }];
    [self.presentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.loginButton);
        make.left.equalTo(ws.loginButton.mas_right).offset(20);
        make.right.equalTo(ws).offset(-20);
        make.height.equalTo(ws.loginButton);
    }];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
