//
//  WSCAFNManager.h
//  JpushDemo
//
//  Created by 王树超 on 16/5/11.
//  Copyright © 2016年 王树超. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface WSCAFNManager : AFHTTPSessionManager
- (void)getFriendListWithcomplited:(void (^)(BOOL isSuccess))complitedCallback;


//登录
-(void)LoginWithAccount:(NSString *)account WithPassword:(NSString *)password Withcomplited:(void(^)(NSDictionary *compliteDictionary))complitedCallback;


@end
