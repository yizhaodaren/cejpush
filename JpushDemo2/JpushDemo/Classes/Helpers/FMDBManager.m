//
//  FMDBManager.m
//  JpushDemo
//
//  Created by 王树超 on 16/5/23.
//  Copyright © 2016年 王树超. All rights reserved.
//

#import "FMDBManager.h"
#import <FMDatabase.h>
#import "MessageModel.h"
#import "Manager.h"
#import "Contact.h"
@implementation FMDBManager

//单例
+(instancetype)sharedFMDBManager{
    static FMDBManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [FMDBManager new];
    });
    return manager;
}
//懒加载
-(FMDatabase *)db{
    if (_db == nil) {
        _db = [FMDatabase databaseWithPath:[self dataBaseFilePath]];
    }
    return _db;
}
//存储路径
-(NSString *)dataBaseFilePath{
    NSString * documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    //为你将要存储的数据库起一个文件名字 这里使用的是stringByAppendingPathComponent 他是用来拼接路径的所以在拼接的时候会自动的给你交上(斜杠) / ;
    NSString *dbFilePath = [documentPath stringByAppendingPathComponent:@"db.sqlite"];
    NSLog(@"%@ ",dbFilePath);
    return dbFilePath;
}
//创建表格
-(BOOL)createTable{
    if ([self.db open]) {
      //数据库打开成功，开始创建表格
          NSLog(@"数据库打开成功");
        NSString *createTableStr = [NSString stringWithFormat:@"create table if not exists message(id integer primary key autoincrement,phoneNumber text not null,dateString text not null)"];
        BOOL result = [self.db executeUpdate:createTableStr];
        if (result) {
            NSLog(@"表格创建成功");
            return YES;
        }else{
            //如果创建失败及得关闭数据库
             NSLog(@"表格创建失败");
            [self.db close];
            return NO;
        }
    }else{
        //数据库打开失败
  NSLog(@"数据库打开失败");
        return NO;
    }
}
//添加数据根据通知
-(BOOL)insertToMessageWith:(NSString *)phoneNumber And:(NSString *)dateString{
    
    if ([self createTable]) {
        //如果表格创建成功
        NSString *insertString = [NSString stringWithFormat:@"insert into message(phoneNumber,dateString) values('%@','%@')",phoneNumber,dateString];
        BOOL result = [self.db executeUpdate:insertString];
        //关闭数据库
        [self.db close];
        
        if (result) {
            NSLog(@"插入成功");
            return  YES;
        }else{
            NSLog(@"插入失败");
            return NO;
        }
        
    }else{
        //表格创建失败
        return NO;
    }
    
}
-(BOOL)search{
    if ([self.db open]) {
        FMResultSet *result = [self.db executeQuery:@"select *from message"];
        NSMutableArray *tempArray = [NSMutableArray array];
        while ([result next]) {
            NSString *phoneNumber = [result stringForColumn:@"phoneNumber"];
            NSString *dateString = [result stringForColumn:@"DateString"];
            int ID = [result intForColumn:@"id"];
            
            MessageModel *model = [[MessageModel alloc]init];
            model.fromUserPhone = phoneNumber;
            model.dateString = dateString;
            model.ID = ID;
            model.fromUserName = NULL;
#pragma mark 把手机号替换成名字
      for (Contact *contact in [ContactFromAddressBookManager sharedCFABManger].ContactArray) {
                if ([phoneNumber isEqualToString:contact.ContactPhoneNumber]) {
                    
                    model.fromUserName = contact.ContactName;
                }
            }
            
          
            [tempArray addObject:model];
            NSLog(@"ID是%d",ID);
            NSLog(@"电话%@ ",phoneNumber);
            NSLog(@"姓名%@ ",model.fromUserName);
            NSLog(@"日期%@ ",dateString);
        }
        //关闭数据库
        [self.db close];
        
        //循环添加array
        while (tempArray.count > 0) {
            [[Manager sharedManger].array addObject:tempArray.lastObject];
            [tempArray removeLastObject];
        }
//        MessageModel *model = [[MessageModel alloc]init];
//        model.fromUserName = @"fdfd";
//        model.dateString = @"fdf";
//        [[Manager sharedManger].array insertObject:model atIndex:0];
        
        
        return YES;
        
    }
    return NO;
}
//根据ID删除
-(BOOL)deleteMessageWithID:(int)ID{
    if ([self.db open]) {
        NSString *deletString = [NSString stringWithFormat:@"delete from message where ID = %d",ID];
        BOOL result = [self.db executeUpdate:deletString];
          //关闭数据库
        [self.db close];
        
        if (result) {
            return YES;
        }else{
            return NO;
        }
    }else{
    return NO ;
    }
}
@end
