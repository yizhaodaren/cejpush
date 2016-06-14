//
//  ContactFromAddressBookManager.m
//  JpushDemo
//  Created by 王树超 on 16/5/16.
//  Copyright © 2016年 王树超. All rights reserved.
//

#import "ContactFromAddressBookManager.h"
#import <Contacts/Contacts.h>
#import <AddressBook/AddressBook.h>
#import "Contact.h"

@implementation ContactFromAddressBookManager

#pragma mark 懒加载
-(NSMutableArray *)ContactArray{
    if (_ContactArray == nil) {
        _ContactArray = [NSMutableArray array];
    }
    return _ContactArray;
}

+(ContactFromAddressBookManager *)sharedCFABManger{
   static ContactFromAddressBookManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ContactFromAddressBookManager alloc]init];
    });
    return manager;
}


//获取所有联系人
-(void)fetchContact{
    //获取设备版本号
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
      if (version<9) {
        //ios 9以前的方式
        [self fetchAddressBookBeforeIOS9];
    }else{
        //iOS 9以后的方式
        [self fetchAddressBookOnIOS9AndLater];
    }

}

#pragma markiOS9以前获取通讯录
//1. iOS 9.0之前获取通讯录的方法
-(void)fetchAddressBookBeforeIOS9{
    ABAddressBookRef addressBook = ABAddressBookCreate();
    //首次访问需用户授权
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined)
    {
        //首次访问通讯录
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            if (!error) {
            if (granted) {
            //允许 NSLog(@"已授权访问通讯录");
            self.ContactArray = [self fetchContactWithAddressBook:addressBook];
            dispatch_async(dispatch_get_main_queue(), ^{
                //----------------主线程 更新 UI-----------------
                NSLog(@"contacts:%@",self.ContactArray); }); }
            else{
                    //拒绝
                NSLog(@"拒绝访问通讯录"); } }
            else{
                NSLog(@"发生错误!"); } }); }
    
    else{
  //非首次访问通讯录
        self.ContactArray = [self fetchContactWithAddressBook:addressBook];
        dispatch_async(dispatch_get_main_queue(), ^{
                            //----------------主线程 更新 UI-----------------
                            NSLog(@"contacts:%@", self.ContactArray);
                        });
                    }
}
- (NSMutableArray *)fetchContactWithAddressBook:(ABAddressBookRef)addressBook{
    
    //有权限访问
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {
        //获取联系人数组
        NSArray *array = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
        NSMutableArray *contacts = [NSMutableArray array];
        for (int i = 0; i < array.count; i++) {
            //获取联系人
            ABRecordRef people = CFArrayGetValueAtIndex((__bridge ABRecordRef)array, i);
            //获取联系人详细信息,如:姓名,电话,住址等信息
            NSString *firstName = (__bridge NSString *)ABRecordCopyValue(people, kABPersonFirstNameProperty);
            NSString *lastName = (__bridge NSString *)ABRecordCopyValue(people, kABPersonLastNameProperty);
            ABMutableMultiValueRef *phoneNumRef = ABRecordCopyValue(people, kABPersonPhoneProperty);
            NSString *phoneNumber = ((__bridge NSArray *)ABMultiValueCopyArrayOfAllValues(phoneNumRef)).lastObject;
            
            
            //创建联系人对象，并添加数据
            Contact *contact = [[Contact alloc]init];
            contact.ContactName = [firstName stringByAppendingString:lastName];
            contact.ContactPhoneNumber = phoneNumber;
            [contacts addObject:contact];
            
        } return contacts;
    }else{
                //无权限访问
                NSLog(@"无权限访问通讯录");
                return nil;
            }
}
#pragma mark iOS9以后获取通讯录联系人
//iOS9以后获取通讯录联系人
-(void)fetchAddressBookOnIOS9AndLater{
    //创建CNContactStore对象
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    //首次访问需用户授权
    if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusNotDetermined) {
        //首次访问通讯录
        [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (!error){
                if (granted) {
                    //允许
                    NSLog(@"已授权访问通讯录"); NSArray *contacts = [self fetchContactWithContactStore:contactStore];
                    //访问通讯录
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //----------------主线程 更新 UI-----------------
                        
                        NSLog(@"contacts:%@", contacts); }); }
                else
                        {
                            
                            //拒绝
                            NSLog(@"拒绝访问通讯录"); } }
            else{ NSLog(@"发生错误!"); } }]; }
    else{
        //非首次访问通讯录
       self.ContactArray = [self fetchContactWithContactStore:contactStore];
        //访问通讯录
        dispatch_async(dispatch_get_main_queue(), ^{
            //----------------主线程 更新UI-----------------
            NSLog(@"contacts:%@",self.ContactArray); }); }
}
-(NSMutableArray *)fetchContactWithContactStore:(CNContactStore *)contactStore{
    //判断访问权限
    if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusAuthorized) {
        //有权限访问
        NSError *error = nil;
        //创建数组,必须遵守CNKeyDescriptor协议,放入相应的字符串常量来获取对应的联系人信息
        
        NSArray <id<CNKeyDescriptor>> *keysToFetch = @[CNContactFamilyNameKey, CNContactGivenNameKey, CNContactPhoneNumbersKey];
        //获取通讯录数组
        NSArray<CNContact*> *arr = [contactStore unifiedContactsMatchingPredicate:nil keysToFetch:keysToFetch error:&error];
        if (!error) {
            NSMutableArray *contacts = [NSMutableArray array];
            
            for (int i = 0; i < arr.count; i++) { CNContact *contact = arr[i];
                NSString *givenName = contact.givenName;
                NSLog(@"%@ ",givenName);
                NSString *familyName = contact.familyName;
                NSString *phoneNumber = ((CNPhoneNumber *)(contact.phoneNumbers.lastObject.value)).stringValue;
#warning 如果电话为空赋值一个符号防止崩溃
                if (phoneNumber == NULL) {
                    phoneNumber = @"000";
                }
                
                Contact *contactModel = [[Contact alloc]init];
                contactModel.ContactName = [givenName stringByAppendingString:familyName];
                contactModel.ContactPhoneNumber = phoneNumber;
                [contacts addObject:contactModel];
                
            }
            return contacts;
        }
        else {
            return nil;
        }
    }else{
        //无权限访问
        NSLog(@"无权限访问通讯录"); return nil;
    }
}
@end
