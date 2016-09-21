//
//  JLCommonUtil.h
//  EvenTouch
//
//  Created by Jack Liu on 14-6-17.
//  Copyright (c) 2014年 Jack Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
@interface JLCommonUtil : NSObject

/**
 *  获取应用的uuid并保存在钥匙串中
 */
+ (NSString *)getUUID;

/*
 检查当前网络状态
 */
+ (BOOL)currentNetworkStatus;

/*
 保存用户信息
 */
+ (void)saveUserInfo:(NSDictionary *)userInfo;

/*
 获取用户信息
 */
+ (NSDictionary *)getUserInfo;

/*
 获取用户id
 */
+ (NSString *)getUserId;

/*
 获取auto_token
 */
+ (NSString *)getAutoToken;

/*
 判断是否为登录状态
 */
+ (BOOL)isLogin;

/*
 设置登录状态
 */
+ (void)setLoginStatus:(BOOL)status;

/*
 根据Stirng获取高度
 */
+ (CGFloat)getHightWithString:(NSString *)str fontOfSize:(CGFloat)fontSize maxWidth:(CGFloat)maxWidth;

/*
 保存广告图片到userdefaults
 */
+ (void)saveMobileAds:(NSArray *)adsArray;

/*
 获取广告图片
 */
+ (NSArray *)getMobleAdsArray;
+(BOOL)isMobileNumber:(NSString *)mobileNum;
+(NSMutableArray *)getFindItemArr;
+(NSArray *)getLeftItemArr;
+(NSArray *)getMeItemArr;
+(NSArray *)getMessageArr;
+(NSMutableArray *)getGatherArr;
//计算两点距离
+ (CLLocationDistance) getCLLocationDistance:(CLLocationCoordinate2D)coordinateA TheTowCoordinate:(CLLocationCoordinate2D )coordinateB;
@end
