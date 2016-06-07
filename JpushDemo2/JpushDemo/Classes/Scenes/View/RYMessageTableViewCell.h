//
//  RYMessageTableViewCell.h
//  JpushDemo
//
//  Created by 王树超 on 16/6/2.
//  Copyright © 2016年 王树超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RYMessageTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@property (weak, nonatomic) IBOutlet UIButton *backPhoneButton;
@property (weak, nonatomic) IBOutlet UIButton *backMessageButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteCellButton;

@end
