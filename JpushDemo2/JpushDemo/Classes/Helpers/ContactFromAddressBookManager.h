//
//  ContactFromAddressBookManager.h
//  JpushDemo
//
//  Created by 王树超 on 16/5/16.
//  Copyright © 2016年 王树超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactFromAddressBookManager : NSObject

@property(nonatomic,strong)NSMutableArray *ContactArray;

+(ContactFromAddressBookManager *)sharedCFABManger;

//获取所有联系人
-(void)fetchContact;

@end
