//
//  RYSettingViewController.m
//  JpushDemo
//
//  Created by 王树超 on 16/5/15.
//  Copyright © 2016年 王树超. All rights reserved.
//

#import "RYSettingViewController.h"

@interface RYSettingViewController()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *settingTableView;

@end

@implementation RYSettingViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
    
    //设置代理
    self.settingTableView.delegate = self;
    self.settingTableView.dataSource = self;

}
-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    //隐藏back按钮
    self.navigationItem.hidesBackButton = YES;
    //自定义标题
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    title.text = @"设置";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"zanwei"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(rightItemDidClicked)];
    
    
    //table设置
    self.settingTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, k_ScreenWith, 300) style:UITableViewStylePlain];
    [self.view addSubview:self.settingTableView];
    
}
-(void)rightItemDidClicked{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)leftItemDidClicked{

}
#pragma mark table代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"flag"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"flag"];
    }
   
    [self handelCell:cell withIndexPath:indexPath];
    
    
    
    return cell;
}

#pragma mark cell处理
-(void)handelCell:(UITableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath{
  
    switch (indexPath.row) {
        case 0:
        {
            cell.imageView.image = [UIImage imageNamed:@"zanwei"];
            cell.textLabel.text = @"手机号:783833";
        }
            break;
         case 1:
        {
            cell.imageView.image = [UIImage imageNamed:@"zanwei"];
            cell.textLabel.text = @"关机来电提醒";
        }
            break;
         case 2:
        {
            cell.imageView.image = [UIImage imageNamed:@"zanwei"];
            cell.textLabel.text = @"拒接/占线来电提醒";
        }
            break;
        case 3:
        {
            cell.imageView.image = [UIImage imageNamed:@"zanwei"];
            cell.textLabel.text = @"无人接听提醒";
        }
            break;
        default:
            break;
    }
    
}
@end
