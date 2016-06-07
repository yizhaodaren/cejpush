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

#define cellHight 40

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
   
   UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 100)];
    headerView.backgroundColor = [UIColor blackColor];
    table.tableHeaderView = headerView;
    
    
    
    
    
    UIView *footerView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, k_ScreenHeight - 100 - 8 * cellHight)];
    footerView.backgroundColor = [UIColor blackColor];
    
    table.tableFooterView = footerView;
 
    table.separatorColor = [UIColor redColor];
    
    //table.separatorInset = UIEdgeInsetsMake(0,80, 0, 80); // 设置端距，这里表示separator离左边和右边均80像素
    table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:table];
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TableView代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
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
    cell.textLabel.text = @"fffff";
    cell.textLabel.textColor = [UIColor whiteColor];
    UIImage *image =[UIImage imageNamed:@"zanwei"];

    cell.imageView.image = image;

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
            //关闭抽屉
            [g_App.leftSlideVC closeLeftView];
            
            RYOpinionViewController *vc = [[RYOpinionViewController alloc]initWithNibName:@"RYOpinionViewController" bundle:nil];
            
            [(UINavigationController *)g_App.leftSlideVC.mainVC pushViewController:vc animated:YES];

        }
            break;
        case 3:
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




@end
