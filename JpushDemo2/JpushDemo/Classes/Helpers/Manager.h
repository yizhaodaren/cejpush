//
//  Manager.h
//  JpushDemo
//
//  Created by 王树超 on 16/5/5.
//  Copyright © 2016年 王树超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Manager : NSObject
@property(nonatomic,strong)id ManagerString;


//将要展示的消息数组
@property(nonatomic,strong)NSMutableArray *array;

//保存极光本地消息的array
@property(nonatomic,strong)NSMutableArray *receiveMessageArray;
@property(nonatomic,strong)NSMutableData *messageData;


+(Manager *)sharedManger;
+(NSString *)md5:(NSString *)str;
@end
