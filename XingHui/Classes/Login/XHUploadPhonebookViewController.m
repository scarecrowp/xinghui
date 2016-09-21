//
//  XHUploadPhonebookViewController.m
//  XingHui
//
//  Created by wangpei on 15/5/29.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHUploadPhonebookViewController.h"
#import <AddressBook/AddressBook.h>
#import "JSONKit.h"
#import "EaseMob.h"
#import "LKDBHelper.h"
#import "Person.h"
@interface XHUploadPhonebookViewController ()

@end

@implementation XHUploadPhonebookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_bt_upload setBackgroundImage:[AciMath getScImage:@"bt_submit" top:20 bottom:20 left:21 right:21] forState:UIControlStateNormal];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)leftReturn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)upload:(id)sender {
 
    NSString *url = [NSString stringWithFormat:@"%@uploadAddress.ashx",ServerURL];
 //   NSData *jsonStr=[[self getAddressList] JSONString];
    NSString *jsonStr = [[self getAddressList] JSONString];
 
    NSMutableDictionary *mdic = [[NSMutableDictionary alloc] init];
    NSDictionary *par = @{@"data":jsonStr,
                         @"user_realname":[XHDefaultUser sharedUser].username,
                         @"user_psw":[XHDefaultUser sharedUser].psw,
                         @"user_mobile":[XHDefaultUser sharedUser].tell,
                         @"user_sex":[XHDefaultUser sharedUser].sex,
                         @"user_company":[XHDefaultUser sharedUser].company,
                         @"user_industry":[XHDefaultUser sharedUser].industry,
                         @"user_job":[XHDefaultUser sharedUser].job,
                        @"user_birthday":[XHDefaultUser sharedUser].birthday};
    mdic = [NSMutableDictionary dictionaryWithDictionary:par];
    [self showHUD];
  
    
    [[XHNetWork sharedNetWork] Post:url parameters:par complete:^(NSDictionary *dic)
     {
        

         [JLCommonUtil setLoginStatus:YES];
         [JLCommonUtil saveUserInfo:[[dic objectForKey:@"content"] objectAtIndex:0]];
         [[XHDefaultUser sharedUser] initUser];
         [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:[XHDefaultUser sharedUser].tell
                                                             password:@"111111"
                                                           completion:^(NSDictionary *loginInfo, EMError *error1) {
             if (!error1) {
                 // 设置自动登录
                 [self showHUDin2s:@"登陆成功"];
                 [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
              
             }
             else
             {
                    [self showHUDin2s:error1.description];
                 
             }
            [self.appdelegate initMainVC];
         } onQueue:nil];
     } errorMsg:^(NSString *msg){
           [self showHUDin2s:msg];
     }];
    
}
-(NSMutableArray *)getAddressList
{
    NSMutableArray *addressBookTemp = [NSMutableArray new];
    ABAddressBookRef addressBooks = nil;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)
    {
        addressBooks =  ABAddressBookCreateWithOptions(NULL, NULL);
        
        //获取通讯录权限
        
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        
        ABAddressBookRequestAccessWithCompletion(addressBooks, ^(bool granted, CFErrorRef error){dispatch_semaphore_signal(sema);});
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        
    }
    
    else
        
    {
        addressBooks = ABAddressBookCreate();
        
    }
    
    //获取通讯录中的所有人
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBooks);
    //通讯录中人数
    CFIndex nPeople = ABAddressBookGetPersonCount(addressBooks);
    
    //循环，获取每个人的个人信息
    for (NSInteger i = 0; i < nPeople; i++)
    {
        //新建一个addressBook model类
        NSMutableDictionary *address = [[NSMutableDictionary alloc] init];
        //获取个人
        ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
        //获取个人名字
        CFTypeRef abName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
        CFTypeRef abLastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
        CFStringRef abFullName = ABRecordCopyCompositeName(person);
        NSString *nameString = (__bridge NSString *)abName;
        NSString *lastNameString = (__bridge NSString *)abLastName;
        
        if ((__bridge id)abFullName != nil) {
            nameString = (__bridge NSString *)abFullName;
        } else {
            if ((__bridge id)abLastName != nil)
            {
                nameString = [NSString stringWithFormat:@"%@ %@", nameString, lastNameString];
            }
        }
        if (nameString) {
               [address setObject:nameString forKey:@"name"];
        }
        else
        {
               [address setObject:@"无名" forKey:@"name"];
        }
     
        
        
        
        ABPropertyID multiProperties[] = {
            kABPersonPhoneProperty,
            kABPersonEmailProperty
        };
        NSInteger multiPropertiesTotal = sizeof(multiProperties) / sizeof(ABPropertyID);
        for (NSInteger j = 0; j < multiPropertiesTotal; j++) {
            ABPropertyID property = multiProperties[j];
            ABMultiValueRef valuesRef = ABRecordCopyValue(person, property);
            NSInteger valuesCount = 0;
            if (valuesRef != nil) valuesCount = ABMultiValueGetCount(valuesRef);
            
            if (valuesCount == 0) {
                CFRelease(valuesRef);
                continue;
            }
            //获取电话号码和email
            for (NSInteger k = 0; k < valuesCount; k++) {
                CFTypeRef value = ABMultiValueCopyValueAtIndex(valuesRef, k);
                switch (j) {
                    case 0: {// Phone number
                        
                        [address setObject:(__bridge NSString*)value forKey:@"tel"];
                        break;
                    }
                    case 1: {// Email
                        [address setObject:(__bridge NSString*)value forKey:@"email"];
                        break;
                    }
                }
                CFRelease(value);
            }
            CFRelease(valuesRef);
        }
        //将个人信息添加到数组中，循环完成后addressBookTemp中包含所有联系人的信息
        [addressBookTemp addObject:address];
        
        if (abName) CFRelease(abName);
        if (abLastName) CFRelease(abLastName);
        if (abFullName) CFRelease(abFullName);
    }
    return addressBookTemp;
}
@end
