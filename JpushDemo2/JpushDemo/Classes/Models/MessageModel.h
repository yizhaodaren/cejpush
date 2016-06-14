//
//  MessageModel.h
//  JpushDemo
//
//  Created by 王树超 on 16/5/16.
//  Copyright © 2016年 王树超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject
//未接来电的号码
@property(nonatomic,copy)NSString *fromUserPhone;
//未接来电的姓名
@property(nonatomic,copy)NSString *fromUserName;
//未接来电的日期
@property(nonatomic,copy)NSString *dateString;
//在本地数据库中存储的ID号
@property(nonatomic,assign)int ID;
@end
