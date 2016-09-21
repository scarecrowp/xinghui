//
//  XHUser.h
//  XingHui
//
//  Created by gaoyuerui on 15/6/2.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
@interface XHUser : NSObject
@property NSInteger uid;
@property(nonatomic,strong) NSString *username;
@property(nonatomic,strong) NSString *userRealName;
@property(nonatomic,strong) NSString *userpic;

@property(nonatomic,strong) NSString *psw;
@property(nonatomic,strong) NSString *tell;
@property(nonatomic,strong) NSString *industry;
@property(nonatomic,strong) NSString *job;
@property(nonatomic,strong) NSString *company;
@property(nonatomic,strong) NSString *birthday;
@property(nonatomic,strong) NSString *sex;
@property(nonatomic,strong) NSMutableArray *gatherArr;
@property(nonatomic,strong) NSMutableArray *tagArr;
@property(nonatomic,strong) NSString *distance;
@property(nonatomic,strong) NSMutableArray *workHistory;//工作经历
@property(nonatomic,strong) NSMutableArray *studyHistory;//学历情况
@property(nonatomic,copy)   NSMutableArray *sameFriend;
@property(nonatomic,strong) NSString *mail;
@property(nonatomic,strong) NSString *wechat;
@property(nonatomic,strong) NSString *QQ;
@property NSInteger userType;//会议经理，普通用户
@property NSInteger applyStatus;
@property NSInteger is_ok;
@property CLLocationCoordinate2D coordinate;
@property int privacy;//0,只有好友可见，1，二度好友可见 2，全部可见
@property int myfriend;//一度好友：1，二度好友 2 ，其他 0
-(instancetype)initWithDic:(NSDictionary *)dic;
@end
