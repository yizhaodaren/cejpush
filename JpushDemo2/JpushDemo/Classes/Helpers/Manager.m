//
//  Manager.m
//  JpushDemo
//
//  Created by 王树超 on 16/5/5.
//  Copyright © 2016年 王树超. All rights reserved.
//

#import "Manager.h"
#import "MessageModel.h"
#import <CommonCrypto/CommonDigest.h>
@implementation Manager
+(Manager *)sharedManger
{
   static Manager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [Manager new];
    });
    return manager;
}
//懒加载
-(NSMutableArray *)array{
    if (_array == nil) {
        _array = [NSMutableArray array];
        //当 _array第一次被使用的时候重本地获取数据
        
    }
    return _array;
}

-(NSMutableData *)messageData{
    if (_messageData == nil) {
        _messageData = [NSMutableData data];
    }
    return _messageData;
}
//md5加密  需要导入<CommonCrypto/CommonDigest.h>
+(NSString *)md5:(NSString *)str{
    
    
    //创建结果数组
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    //加密
    CC_MD5([str UTF8String],(CC_LONG)str.length, result);
    
    //拼接结果
    NSMutableString *resultString = [[NSMutableString alloc]initWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (int i = 0; i <CC_MD5_DIGEST_LENGTH; i ++) {
        [resultString appendFormat:@"%02X",result[i]];
    }
    
    return resultString;
    
}
//归档
-(void)addMessage:(MessageModel *)model{
   // self.messageData;
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:self.messageData];
    [archiver encodeObject:model forKey:[NSString stringWithFormat:@"message%lu",(unsigned long)self.array.count]];
    [archiver finishEncoding];
    
    
    //本地保存
    [k_NSUDF setObject:self.messageData forKey:@"messageData"];
    [k_NSUDF setInteger:self.array.count forKey:@"messageDataNumber"];

}
//反归档
-(NSMutableArray *)arrayFromLocation{
    
    NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:self.messageData];
    
    NSMutableArray *array = [NSMutableArray array];
    NSInteger count = [k_NSUDF integerForKey:@"messageDataNumber"];
    for (int i = 1; i ++;i <= count) {
        MessageModel *model = [unArchiver decodeObjectForKey:[NSString stringWithFormat:@"message%d",i]];
        [array addObject:model];
        
    }
    return array;
}

@end
