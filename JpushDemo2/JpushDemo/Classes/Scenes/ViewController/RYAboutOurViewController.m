//
//  RYAboutOurViewController.m
//  JpushDemo
//
//  Created by 王树超 on 16/6/3.
//  Copyright © 2016年 王树超. All rights reserved.
//

#import "RYAboutOurViewController.h"

@interface RYAboutOurViewController ()
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *weixinNumberLabel;

- (IBAction)orderButtton:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *MainViewHeight;

@end

@implementation RYAboutOurViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
-(void)initUI{
    
    self.title = @"关于我们";

    
    self.MainViewHeight.constant= k_ScreenHeight/3;
    
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

- (IBAction)orderButtton:(id)sender {
}
@end
