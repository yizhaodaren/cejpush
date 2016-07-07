//
//  RYEmailViewController.m
//  JpushDemo
//
//  Created by 王树超 on 16/7/1.
//  Copyright © 2016年 王树超. All rights reserved.
//

#import "RYEmailViewController.h"

@interface RYEmailViewController ()
@property (weak, nonatomic) IBOutlet UIView *backGroundView;

@end

@implementation RYEmailViewController
-(void)awakeFromNib{
    
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self  = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _backGroundView.layer.cornerRadius = 5;
    _backGroundView.clipsToBounds = YES;
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
