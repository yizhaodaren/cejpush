//
//  RYOpinionViewController.m
//  JpushDemo
//
//  Created by 王树超 on 16/6/3.
//  Copyright © 2016年 王树超. All rights reserved.
//

#import "RYOpinionViewController.h"

@interface RYOpinionViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *MainView;
@property (weak, nonatomic) IBOutlet UITextView *OpinionTV;
- (IBAction)OpinioButton:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ViewHeight;

@end

@implementation RYOpinionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    // Do any additional setup after loading the view from its nib.
}
-(void)initUI{
    self.title = @"意见反馈";
    
    self.MainView.layer.cornerRadius = 10;
    self.MainView.clipsToBounds = YES;
    self.ViewHeight.constant = k_ScreenHeight/3;
    self.OpinionTV.text = @"请输入您的宝贵意见!";
    self.OpinionTV.textColor = [UIColor lightGrayColor];
    self.OpinionTV.delegate = self;
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"请输入您的宝贵意见!"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
   
    return YES;
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"请输入您的宝贵意见!";
        textView.textColor =[UIColor lightGrayColor];
    }
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.OpinionTV endEditing:YES];
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

- (IBAction)OpinioButton:(id)sender {
}
@end
