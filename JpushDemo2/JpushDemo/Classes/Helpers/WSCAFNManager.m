//
//  WSCAFNManager.m
//  JpushDemo
//
//  Created by 王树超 on 16/5/11.
//  Copyright © 2016年 王树超. All rights reserved.
//

#import "WSCAFNManager.h"
#import <CommonCrypto/CommonDigest.h>

@implementation WSCAFNManager
- (void)getFriendListWithcomplited:(void (^)(BOOL isSuccess))complitedCallback {
    //NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    
    NSDictionary *parament = @{@"access_token":
                                   @"pageIndex",
                               @"pageSize":@5000,
                          
                               };
    
    
    [manager POST:@"http://218.241.17.167:8092/friends/list" parameters:parament progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        if (complitedCallback) {
            complitedCallback(YES);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error----%@", error);
    }];
}
//登录
-(void)LoginWithAccount:(NSString *)account WithPassword:(NSString *)password Withcomplited:(void(^)(NSDictionary *compliteDictionary))complitedCallback{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *parament = @{@"access_token":
                                   @"pageIndex",
                               @"pageSize":@5000,
                               
                               };
    [manager POST:@"hh" parameters:parament progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = responseObject;
        complitedCallback(dict);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ;
    }];
    
}
//md5加密  需要导入<CommonCrypto/CommonDigest.h>
-(NSString *)md5:(NSString *)str{
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

@end
