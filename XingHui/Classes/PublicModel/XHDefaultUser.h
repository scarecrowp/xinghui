//
//  XHDefaultUser.h
//  XingHui
//
//  Created by wangpei on 15/8/5.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHUser.h"

@interface XHDefaultUser : XHUser
+ (XHDefaultUser *)sharedUser;
-(void)initUser;
+(void)clearUser;
-(void)saveDefaultUser;
-(void)saveUserPic:(NSString *)picUrl;
-(void)saveUserType:(NSInteger)userType;
-(void)saveApplyStatus:(NSInteger )applyStatus;
-(void)saveUserTagArr;
@end
