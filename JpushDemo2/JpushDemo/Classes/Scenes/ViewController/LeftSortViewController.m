//
//  LeftSortViewController.m
//  JpushDemo
//
//  Created by 王树超 on 16/5/11.
//  Copyright © 2016年 王树超. All rights reserved.
//

#import "LeftSortViewController.h"

#import "RYOpinionViewController.h"
#import "RYAboutOurViewController.h"
#import "AppDelegate.h"
//分享
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
//布局设置
#define cellHight 60

@interface LeftSortViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation LeftSortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    // Do any additional setup after loading the view.
}
-(void)initUI{
    
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, k_ScreenWith - 100, k_ScreenHeight) style:UITableViewStylePlain];
    /**
     *设置代理
     */
    table.delegate = self;
    table.dataSource = self;
   
    /**
     *头视图
     */
   UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, k_ScreenWith, 100)];
    headerView.backgroundColor = [UIColor blackColor];
    
    //添加头像
    self.userImageView = [[UIImageView alloc]init];
    
   [headerView addSubview:self.userImageView];
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@20);
        make.width.equalTo(@70);
        make.height.equalTo(@70);
    }];
    
    
    self.userImageView.image = [UIImage imageNamed:@"user_image.png"];

    self.userImageView.layer.cornerRadius = 35;
    self.userImageView.clipsToBounds = YES;
    //用户名称button
    self.userNameButton = [k_factory createCommonButton:@"微信登录" target:self action:@selector(wxlogin)];

    
    [headerView addSubview:self.userNameButton];
    
    [self.userNameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.userImageView);
        make.left.equalTo(self.userImageView.mas_right).offset(10);
        make.height.equalTo(@40);
    }];
    
    
    table.tableHeaderView = headerView;
    
    /**
     *尾视图
     */
    UIView *footerView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, k_ScreenHeight - 100 - 5 * cellHight)];
    footerView.backgroundColor = [UIColor blackColor];
    
    table.tableFooterView = footerView;
 
    table.separatorColor = [UIColor redColor];
    
    //table.separatorInset = UIEdgeInsetsMake(0,80, 0, 80); // 设置端距，这里表示separator离左边和右边均80像素
    table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:table];
    

    
}
#pragma mark 微信登录点击事件
-(void)wxlogin{

    [ShareSDK getUserInfo:SSDKPlatformTypeWechat onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        if (state == SSDKResponseStateSuccess)
        {
            
            NSLog(@"uid=%@",user.uid);
            NSLog(@"%@",user.credential);
            NSLog(@"token=%@",user.credential.token);
            NSLog(@"nickname=%@",user.nickname);
            NSLog(@"性别%ld ",user.gender);
            NSLog(@"头像%@ ",user.icon);
            NSLog(@"用户主页%@ ",user.url);
        }
        
        else
        {
            NSLog(@"%@",error);
        }
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TableView代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ff"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ff"];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor blackColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    [self handelCell:cell withIndexPath:indexPath];

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
        {
            
            /**
             *分享
             */
            //关闭抽屉
            [g_App.leftSlideVC closeLeftView];
            //1、创建分享参数
            NSArray* imageArray = @[[UIImage imageNamed:@"image1.png"]];
           // （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
            if (imageArray) {
                
                NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
                [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                                 images:imageArray
                                                    url:[NSURL URLWithString:@"http://mob.com"]
                                                  title:@"分享标题"
                                                   type:SSDKContentTypeAuto];
                //2、分享（可以弹出我们的分享菜单和编辑界面）
                [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                         items:nil
                                   shareParams:shareParams
                           onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                               
                               switch (state) {
                                   case SSDKResponseStateSuccess:
                                   {
                                       UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                           message:nil
                                                                                          delegate:nil
                                                                                 cancelButtonTitle:@"确定"
                                                                                 otherButtonTitles:nil];
                                       [alertView show];
                                       break;
                                   }
                                   case SSDKResponseStateFail:
                                   {
                                       UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                                       message:[NSString stringWithFormat:@"%@",error]
                                                                                      delegate:nil
                                                                             cancelButtonTitle:@"OK"
                                                                             otherButtonTitles:nil, nil];
                                       [alert show];
                                       break;
                                   }
                                   default:
                                       break;
                               }
                           }  
                 ];}
        }
            break;
        case 3:
        {
            
            //关闭抽屉
            [g_App.leftSlideVC closeLeftView];
            
            RYOpinionViewController *vc = [[RYOpinionViewController alloc]initWithNibName:@"RYOpinionViewController" bundle:nil];
            
            [(UINavigationController *)g_App.leftSlideVC.mainVC pushViewController:vc animated:YES];

        }
            break;
        case 4:
        {
            //关闭抽屉
            [g_App.leftSlideVC closeLeftView];
            
            RYAboutOurViewController *vc = [[RYAboutOurViewController alloc]initWithNibName:@"RYAboutOurViewController" bundle:nil];
            
            [(UINavigationController *)g_App.leftSlideVC.mainVC pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellHight;
}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 500)];
//    view.backgroundColor = [UIColor blueColor];
//    return view;
//}
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 500)];
//    view.backgroundColor = [UIColor redColor];
//    
//    return view;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 50;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 50;
//}
//-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
//{
//   
//    return @"haha";
//}

#pragma mark cell处理
-(void)handelCell:(UITableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%lf",cell.frame.size.height);
    
    switch (indexPath.row) {
        case 0:
        {
            cell.imageView.image = [UIImage imageNamed:@"user_phone"];
            cell.textLabel.text = @"13153802083";
        }
            break;
        case 1:
        {
            cell.imageView.image = [UIImage imageNamed:@"user_email"];
            cell.textLabel.text = @"邮箱设置";
       
        }
            break;
        case 2:
        {
            cell.imageView.image = [UIImage imageNamed:@"user_share"];
            cell.textLabel.text = @"分享好友";
            
        }
            break;
        case 3:
        {
            cell.imageView.image = [UIImage imageNamed:@"user_opinion"];
            cell.textLabel.text = @"意见反馈";
            
                 }
            break;
        case 4:
        {
            cell.imageView.image = [UIImage imageNamed:@"user_aboutOur"];
            cell.textLabel.text = @"关于我们";
        
        }
            break;
        default:
            break;
    }
    
}



@end
