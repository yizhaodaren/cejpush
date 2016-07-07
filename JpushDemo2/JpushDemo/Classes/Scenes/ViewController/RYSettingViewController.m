//
//  RYSettingViewController.m
//  JpushDemo
//
//  Created by 王树超 on 16/5/15.
//  Copyright © 2016年 王树超. All rights reserved.
//

#import "RYSettingViewController.h"
#define k_cellNotmalHeight 44
#define k_cellHeight 64

@interface RYSettingViewController()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *bgView;
- (IBAction)bg1ButtonDidClicked:(id)sender;
- (IBAction)bg2ButtonDidClicked:(id)sender;

- (IBAction)bg3ButtonDidClicked:(id)sender;

- (IBAction)bg4ButtonDidClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *bg1Button;
@property (weak, nonatomic) IBOutlet UIButton *bg2Button;

@property (weak, nonatomic) IBOutlet UIButton *bg3Button;
@property (weak, nonatomic) IBOutlet UIButton *bg4Button;
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
    
    //预设置背景图片
    [self setBackGroundImageForButtonExcept:0];
    
    self.view.backgroundColor = [UIColor whiteColor];
    //隐藏back按钮
    self.navigationItem.hidesBackButton = YES;
    //自定义标题
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    title.text = @"设置";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"setting_back"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(rightItemDidClicked)];
    
    
    //table设置
    self.settingTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, k_ScreenWith, 44*3 + 64 *3) style:UITableViewStylePlain];
    
    [self.settingTableView setScrollEnabled:NO];
    
    [self.bgView addSubview:self.settingTableView];
    
}
-(void)rightItemDidClicked{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)leftItemDidClicked{

}
#pragma mark table代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"flag"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"flag"];
    }
   
    [self handelCell:cell withIndexPath:indexPath];
    
    //选中无效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row % 2 == 0) {
        return k_cellNotmalHeight;
    }
    return k_cellHeight;
}

#pragma mark cell处理
-(void)handelCell:(UITableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%lf",cell.frame.size.height);
  
    switch (indexPath.row) {
        case 0:
        {
            cell.imageView.image = [UIImage imageNamed:@"zanwei"];
            cell.textLabel.text = @"手机号:783833";
           cell.textLabel.textColor = [UIColor grayColor];
        }
            break;
         case 1:
        {
            cell.imageView.image = [UIImage imageNamed:@"zanwei"];
            cell.textLabel.text = @"    关机来电提醒";
            UISwitch *switch1 = [[UISwitch alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
            switch1.center = CGPointMake(k_ScreenWith - 40,k_cellHeight/2);
            [cell addSubview:switch1];
        }
            break;
         case 2:
        {
            cell.imageView.image = [UIImage imageNamed:@"zanwei"];
          cell.textLabel.text = @"手机号1343432443";
            cell.textLabel.textColor = [UIColor grayColor];
      
        }
            break;
        case 3:
        {
            cell.imageView.image = [UIImage imageNamed:@"zanwei"];
             cell.textLabel.text = @"    关机来电提醒";
        
            UISwitch *switch1 = [[UISwitch alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
              switch1.center = CGPointMake(k_ScreenWith - 40,k_cellHeight/2);
            [cell addSubview:switch1];
        }
            break;
        case 4:
        {
            cell.imageView.image = [UIImage imageNamed:@"zanwei"];
              cell.textLabel.text = @"手机号1343432443";
           cell.textLabel.textColor = [UIColor grayColor];
        }
            break;
        case 5:
        {
            cell.imageView.image = [UIImage imageNamed:@"zanwei"];
           cell.textLabel.text = @"    关机来电提醒";
            
            UISwitch *switch1 = [[UISwitch alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
             switch1.center = CGPointMake(k_ScreenWith - 40,k_cellHeight/2);
            [cell addSubview:switch1];
        }
            break;
        default:
            break;
    }
    
}

- (IBAction)bg1ButtonDidClicked:(id)sender {
 
    [(UIButton *)sender setBackgroundImage:[UIImage imageNamed:@"zanwei"] forState:UIControlStateNormal];
    
    [g_App.bgImgeView setImage:[UIImage imageNamed:@"h1.jpg"]];
    
    [self setBackGroundImageForButtonExcept:1];
}

- (IBAction)bg2ButtonDidClicked:(id)sender {
    [(UIButton *)sender setBackgroundImage:[UIImage imageNamed:@"zanwei"] forState:UIControlStateNormal];
    
      [g_App.bgImgeView setImage:[UIImage imageNamed:@"h4.jpg"]];
    [self setBackGroundImageForButtonExcept:2];
}

- (IBAction)bg3ButtonDidClicked:(id)sender {
 //[self.bg3Button setImage:[UIImage imageNamed:@"zanwei"] forState:UIControlStateNormal];
     [(UIButton *)sender setBackgroundImage:[UIImage imageNamed:@"zanwei"] forState:UIControlStateNormal];
    
    [g_App.bgImgeView setImage:[UIImage imageNamed:@"h2.jpg"]];
    [self setBackGroundImageForButtonExcept:3];
}

- (IBAction)bg4ButtonDidClicked:(id)sender {
    [(UIButton *)sender setBackgroundImage:[UIImage imageNamed:@"zanwei"] forState:UIControlStateNormal];
    [g_App.bgImgeView setImage:[UIImage imageNamed:@"h3.jpg"]];
    [self setBackGroundImageForButtonExcept:4];
}

-(void)setBackGroundImageForButtonExcept:(int)except{
    if (except != 1) {
           [_bg1Button setBackgroundImage:[UIImage imageNamed:@"h1.jpg"] forState:UIControlStateNormal];
    }
    if (except != 2) {
        [_bg2Button setBackgroundImage:[UIImage imageNamed:@"h2.jpg"] forState:UIControlStateNormal];
    }
    if (except != 3) {
        [_bg3Button setBackgroundImage:[UIImage imageNamed:@"h3.jpg"] forState:UIControlStateNormal];
    }
    if (except != 4) {
        [_bg4Button setBackgroundImage:[UIImage imageNamed:@"h4.jpg"] forState:UIControlStateNormal];
    }
 
}
@end
