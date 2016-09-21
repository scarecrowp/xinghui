//
//  UserManager.h
//  XingHui
//
//  Created by wangpei on 15/8/22.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface UserManager : NSObject
+ (UserManager *)share;
//-(void)getFirstFriend:(NSString *)uid;
-(void)getFirstFriendcomplete:(void (^)(NSMutableArray *Arr))complete;//一度好友
-(void)getSecondFriendComplete:(void (^)(NSMutableArray *Arr))complete;//二度好友
-(void)getNearFriendComplete:(void (^)(NSMutableArray *Arr))complete;//附近的好友
-(void)getOLFriendComplete:(void (^)(NSMutableArray *Arr))complete;
-(void)searchFriend:(NSDictionary *)par complete:(void(^)(NSMutableArray *Arr))complete;//根据关键词搜索好友
-(void)Invitationfriend:(void(^)(NSMutableArray *Arr))complete;//查找未注册好友
-(void)getUserDetail:(int)uid finish:(void (^)(NSDictionary * dic))finish;
-(void)getFriendWithtype:(int)friendtype complete:(void (^)(NSMutableArray *Arr))complete;
/**
 *  查询一度好友
 *
 *  @param page     页数，0代表第一页
 *  @param complete 获取完成之后的操作
 */
-(void)getFriendWithParam:(NSDictionary *)par complete:(void (^)(NSMutableArray *))complete;
@end