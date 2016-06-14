//
//  MainViewController.m
//  JpushDemo
//
//  Created by 王树超 on 16/5/12.
//  Copyright © 2016年 王树超. All rights reserved.
//

#import "MainViewController.h"
#import "JPUSHService.h"
#import "mainView.h"
#import "RYSettingViewController.h"
#import "ContactFromAddressBookManager.h"
#import "Contact.h"
#import "MessageModel.h"
#import "RYMessageTableViewCell.h"

#define APPKEY @"911c809b54312c314659e432"
@interface MainViewController()<UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,SDCycleScrollViewDelegate>
@property(nonatomic,strong)mainView *rootView;
@end

@implementation MainViewController
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    //注册通知JPUSH通知
    [self registerNOtification];
    
    //推送处理
    self.userInfoBlock = ^(NSDictionary *userInfo){
        NSLog(@"%@",userInfo);
    };

    //设置导航栏代理
    self.navigationController.delegate = self;
    //创建item
    [self createNavigationItem];

    
    _rootView = [[mainView alloc]initWithFrame:[UIScreen  mainScreen].bounds];
    self.view = _rootView;
    _rootView.mainTableView.delegate = self;
    _rootView.mainTableView.dataSource = self;
    _rootView.mainCollectionView.delegate = self;
    _rootView.mainCollectionView.dataSource = self;
    //设置轮播图在创建_rootView以后
     [self settingSDCycleScrollView];
    

    /**
     *注册cell
     */
    
    [_rootView.mainTableView registerNib:[UINib nibWithNibName:@"RYMessageTableViewCell" bundle:nil] forCellReuseIdentifier:@"messageCell"];
    
    [_rootView.mainCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"flag"];
    
    [_rootView.segment addTarget:self action:@selector(segmentAction) forControlEvents:UIControlEventValueChanged];
    
    //获取通讯录
    [[ContactFromAddressBookManager sharedCFABManger] fetchContact];
    //添加测试数据
    [[FMDBManager sharedFMDBManager] insertToMessageWith:@"18510919140" And:@"nain"];
       [[FMDBManager sharedFMDBManager] insertToMessageWith:@"13206353783" And:@"nain"];
    //获取本地数据
    [[FMDBManager sharedFMDBManager] search];
 
    

    
}

-(void)segmentAction{
    
    //动画时间
    float time = 0.4;
    switch (_rootView.segment.selectedSegmentIndex) {
        case 0:{
            _rootView.mainScrollView.contentOffset =CGPointMake(0, 0);
            [UIView animateWithDuration:time animations:^{
                CGPoint center = _rootView.tempView.center;
                _rootView.tempView.center = CGPointMake((k_ScreenWith/6), center.y);
            }];
            break;
        }
          case 1:
        {
            _rootView.mainScrollView.contentOffset = CGPointMake(k_ScreenWith *1, 0);
            
          [UIView animateWithDuration:time animations:^{
              CGPoint center = _rootView.tempView.center;
              _rootView.tempView.center = CGPointMake(k_ScreenWith/3 +(k_ScreenWith/6), center.y);
          }];
       
      
    
        }
            break;
            case 2:
        {
            _rootView.mainScrollView.contentOffset = CGPointMake(k_ScreenWith *2, 0);
            [UIView animateWithDuration:time animations:^{
                CGPoint center = _rootView.tempView.center;
                _rootView.tempView.center = CGPointMake(k_ScreenWith/3*2 +(k_ScreenWith/6), center.y);
            }];
        }
        default:
            break;
    }
}

#pragma mark tableView代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [Manager sharedManger].array.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RYMessageTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"messageCell"];
//    if (!cell) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"jj"];
//    }
   cell.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    //选中类型
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    MessageModel *model =[Manager sharedManger].array[indexPath.row];
    
    //如果有名字显示名字，不然就显示电话号码
    if (model.fromUserName == NULL) {
         cell.messageLabel.text = model.fromUserPhone;
    }else{
        cell.messageLabel.text = model.fromUserName;
    }
    cell.deleteCellButton.tag = indexPath.row + 10000;
    cell.backMessageButton.tag = indexPath.row + 20000;
    cell.backPhoneButton.tag = indexPath.row + 30000;
    
    [cell.backPhoneButton addTarget:self action:@selector(backPhong:) forControlEvents:UIControlEventTouchUpInside];
    [cell.backMessageButton addTarget:self action:@selector(backSMS:) forControlEvents:UIControlEventTouchUpInside];
    [cell.deleteCellButton addTarget:self action:@selector(deleteMSM:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

#pragma makr UICollectionView 的代理
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"flag" forIndexPath:indexPath];
    
    cell.layer.cornerRadius = cell.bounds.size.width/2;
    cell.clipsToBounds = YES;
    cell.backgroundColor = [UIColor redColor];

    return cell;
}


#pragma mark 创建item
-(void)createNavigationItem{
   // self.navigationItem.leftBarButtonItem=
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"menu"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(leftItemDidClicked)];
    
#warning 暂时的label 应该改成全局的
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
    label.text = @"微信登录";
    label.textColor = [UIColor whiteColor];
    label.userInteractionEnabled = YES;
    
    self.itemString = @"微信登录";
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithTitle:self.itemString style:UIBarButtonItemStylePlain target:self action:@selector(leftItemDidClicked)];
   // item2.title =@"登录过了";
    

    NSArray *itemArray = [NSArray arrayWithObjects:item1,item2,nil];
    self.navigationItem.leftBarButtonItems = itemArray;
    
    
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"seting"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(rightItemDidClicked)];
}
-(void)settingSDCycleScrollView{
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    
    _rootView.cycleView.imageURLStringsGroup = imagesURLStrings;
    _rootView.cycleView.delegate = self;
}
#pragma mark SDCycleScrollView代理方法
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"点击了第%ld张图片",index);
}
#pragma mark item点击方法
-(void)leftItemDidClicked{
    
 
    
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (tempAppDelegate.leftSlideVC.closed) {
        [tempAppDelegate.leftSlideVC openLeftView];
    }else{
        [tempAppDelegate.leftSlideVC closeLeftView];
    }
    
}
-(void)rightItemDidClicked{
    RYSettingViewController *setingVC = [[RYSettingViewController alloc]initWithNibName:@"RYSettingViewController" bundle:nil];
    
    
    [self.navigationController pushViewController:setingVC animated:NO];
    
    
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
    NSLog(@"%@ ",notification);
    NSLog(@"%@ ",content);
    NSLog(@"%@ ",customizeField1);
    NSLog(@"%@ ",userInfo);
    
    
    
    //转换模型 刷新页面
    NSString *nameOrphoneNumber = [content substringFromIndex:3];
    /**
     *<#something#>
     */
#pragma mark 把手机号替换成名字
    for (Contact *contact in [ContactFromAddressBookManager sharedCFABManger].ContactArray) {
        if ([nameOrphoneNumber isEqualToString:contact.ContactPhoneNumber]) {
            nameOrphoneNumber = contact.ContactName;
        }
    }
    
   // NSString *dateString = [userInfo valueForKey:@"key"];
    NSString *dateString = [content substringToIndex:4];
    MessageModel *messageModel = [[MessageModel alloc]init];
    messageModel.fromUserName = nameOrphoneNumber;
    messageModel.dateString = dateString;
    //数组添加消息模型
    [[Manager sharedManger].array addObject:messageModel];

    //然后刷新
    [_rootView.mainTableView reloadData];
   
   // [g_App showAlert:@"您有新的通知消息"];
    
    [g_wait start:@""];
//    [g_App showAlertWithTitle:@"主标题" CancelTitle:@"取消" WithCancelHandel:^{
//        NSLog(@"取消");
//    } WithActionTitle:@"确认" WithActionHandel:^{
//        NSLog(@"取消");
//    } WithTaget:self];
    
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
    //断网以后再次回来会提示的
    NSLog(@"关闭连接");
}
-(void)DidLoginNotification{
    NSLog(@"登录成功");
    //代码只被执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"当前账号%@",[k_NSUDF objectForKey:k_currentUser]);
        [JPUSHService setTags:[NSSet set] alias:[Manager md5:@"ee"] fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
            NSLog(@"%d",iResCode);
            NSLog(@"%@ ",iTags);
            NSLog(@"%@ ",iAlias);
        }];
    });
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void) navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 如果进入的是当前视图控制器
    if (viewController == self) {
        // 背景设置为黑色
     //   self.navigationController.navigationBar. tintColor = [UIColor colorWithRed:0.500 green:0.500 blue:0.500 alpha:1.000];
        
   [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
   [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1]];
   
        // 透明度设置为0.3
        //设置到杭兰的透明度 而它上面的item不透明
        [[[self.navigationController.navigationBar subviews]objectAtIndex:0] setAlpha:0.5];
  //上面的空间都透明了
  //  self.navigationController.navigationBar.alpha = 0.3;
        // 设置为半透明
       self.navigationController.navigationBar. translucent = YES ;
    } else {
        // 进入其他视图控制器
     
        // 背景颜色设置为系统 默认颜色
        self.navigationController.navigationBar.tintColor =[UIColor whiteColor];
#pragma mark 统一设置标题的颜色
        //1
        UIColor * color = k_WhiteColor;
        //2
        NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
        //3
        self.navigationController.navigationBar.titleTextAttributes = dict;
        

          self.navigationController.navigationBar. translucent = NO;
    }
}
#pragma mark 回拨电话
-(void)backPhong:(UIButton *)sender{
    
    [g_App showAlertWithTitle:@"确定回拨" CancelTitle:@"取消" WithCancelHandel:^{
        ;
    } WithActionTitle:@"确定" WithActionHandel:^{
        MessageModel *model =[Manager sharedManger].array[sender.tag - 30000];
        NSString *telphone = [NSString stringWithFormat:@"tel://%@",model.fromUserPhone];
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telphone]];
    } WithTaget:self];
   
    
}
#pragma mark 回短息
-(void)backSMS:(UIButton *)sender{
    [g_App showAlertWithTitle:@"回消息" CancelTitle:@"取消" WithCancelHandel:^{
        ;
    } WithActionTitle:@"确认" WithActionHandel:^{
        MessageModel *model =[Manager sharedManger].array[sender.tag - 20000];
        NSString *smsString = [NSString stringWithFormat:@"sms://%@",model.fromUserPhone];
       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:smsString]];
    } WithTaget:self];
}
#pragma mark 删除消息
-(void)deleteMSM:(UIButton *)sender{
    [g_App showAlertWithTitle:@"确定删除" CancelTitle:@"取消" WithCancelHandel:^{
        ;
    } WithActionTitle:@"确认" WithActionHandel:^{
    NSLog(@"hyhyhyhy%ld",(long)sender.tag);
    MessageModel *model =[Manager sharedManger].array[sender.tag - 10000];
        //删除数据库中  model.ID 一条
        [[FMDBManager sharedFMDBManager]deleteMessageWithID:model.ID];
        //删除数组中一条
        [[Manager sharedManger].array removeObject:model];
        //然后刷新数据
        [_rootView.mainTableView reloadData];
       
    } WithTaget:self];
}
@end
