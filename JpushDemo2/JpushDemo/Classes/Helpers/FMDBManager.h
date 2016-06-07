//
//  FMDBManager.h
//  JpushDemo
//
//  Created by 王树超 on 16/5/23.
//  Copyright © 2016年 王树超. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMDatabase;
@interface FMDBManager : NSObject

@property(nonatomic,strong)FMDatabase *db;

+(instancetype)sharedFMDBManager;
//路径
-(NSString *)dataBaseFilePath;
//创建表格
-(BOOL)createTable;
//添加数据根据通知
-(BOOL)insertToMessageWith:(NSString *)phoneNumber And:(NSString *)dateString;
-(BOOL)search;
@end
