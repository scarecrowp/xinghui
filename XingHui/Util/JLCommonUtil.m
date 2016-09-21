//
//  JLCommonUtil.m
//  EvenTouch
//
//  Created by Jack Liu on 14-6-17.
//  Copyright (c) 2014年 Jack Liu. All rights reserved.
//

#import "JLCommonUtil.h"
#import <unistd.h>
#import "Reachability.h"
//#import "SSKeychain.h"
#import "XHFirstFirendViewController.h"
#import "XHSecondFirendViewController.h"
#import "XHNearFirendViewController.h"
#import "XHNearGatheringViewController.h"
#import "XHCreateGatherViewController.h"
#import "XHSystemSetViewController.h"
#import "XHMessage.h"
#import "XHMyGatherViewController.h"
#import "XHGather.h"
#import <MapKit/MapKit.h>
 
#import "CreatGroupTalkVC.h"
#import "GroupListViewController.h"
#import "XHRequestMMViewController.h"
@implementation JLCommonUtil

/*
 检查当前网络状态
 */
+ (BOOL)currentNetworkStatus
{
    Reachability *r = [Reachability reachabilityForInternetConnection];
    
    if ([r currentReachabilityStatus] == NotReachable)
    {
//        UIWindow *window = [[[UIApplication sharedApplication]windows]objectAtIndex:0];
      //  UIWindow *window = [[UIApplication sharedApplication]keyWindow];
              
        return NO;
    }
    else
    {
        return YES;
    }
}

/*
 保存用户信息
 */
+ (void)saveUserInfo:(NSDictionary *)userInfo
{
    [[NSUserDefaults standardUserDefaults]setObject:userInfo forKey:@"userInfo"];
    [[XHDefaultUser sharedUser] initUser];
}

/*
 获取用户信息
 */
+ (NSDictionary *)getUserInfo
{
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"])
    {
        return [[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"];
    }
    
    return nil;
}

/*
 获取用户id
 */
+ (NSString *)getUserId
{
    //如果没有登陆的情况下返回uuid做为用户id
    if (![JLCommonUtil isLogin])
    {
        return @"";
    }
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"])
    {
        return [[[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"]objectForKey:@"ID"];
    }
    
    return nil;
}

/*
 获取auto_token
 */
+ (NSString *)getAutoToken
{
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"])
    {
        return [[[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"]objectForKey:@"auto_token"];
    }
    return nil;
}

/*
 判断是否为登录状态
 */
+ (BOOL)isLogin
{
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"loginStatus"])
    {
        return [[NSUserDefaults standardUserDefaults]boolForKey:@"loginStatus"];
    }
    else
    {
        return NO;
    }
}

/*
 设置登录状态
 */
+ (void)setLoginStatus:(BOOL)status
{
    [[NSUserDefaults standardUserDefaults]setBool:status forKey:@"loginStatus"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/*
 根据Stirng获取高度
 */
+ (CGFloat)getHightWithString:(NSString *)str fontOfSize:(CGFloat)fontSize maxWidth:(CGFloat)maxWidth
{
    
    CGSize constraint = CGSizeMake(maxWidth, 20000.0f);
    
    //CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    CGSize size = [str boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
    
    return size.height;
}



#pragma mark-
#pragma mark- 正则判断手机号码地址格式
+(BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[0-9])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[0-9]|7[0-9])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
+(NSMutableArray *)getFindItemArr
{
    NSMutableArray *dataArr = [[NSMutableArray alloc] init];
    //一度好友
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:3];
    [dic setObject:@"一度好友管理" forKey:@"title"];
    [dic setObject:@"icon_1st" forKey:@"icon"];
   
    [dic setObject:@"XHFirstFirendViewController" forKey:@"page"];
    [dataArr addObject:dic];
    //优惠券
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithCapacity:3];
    [dic1 setObject:@"发现二度好友" forKey:@"title"];
    [dic1 setObject:@"icon_2nd" forKey:@"icon"];
 
    [dic1 setObject:@"XHSecondFirendViewController" forKey:@"page"];
    [dataArr addObject:dic1];
    //我的收藏
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionaryWithCapacity:3];
    [dic2 setObject:@"附近的好友" forKey:@"title"];
    [dic2 setObject:@"icon_nearf" forKey:@"icon"];
    
    [dic2 setObject:@"XHNearFirendViewController" forKey:@"page"];
    [dataArr addObject:dic2];
    
    NSMutableDictionary *dic3 = [NSMutableDictionary dictionaryWithCapacity:3];
    [dic3 setObject:@"附近的活动" forKey:@"title"];
    [dic3 setObject:@"icon_nearg" forKey:@"icon"];
    
    [dic3 setObject:@"XHNearGatheringViewController" forKey:@"page"];
    [dataArr addObject:dic3];
    
    NSMutableDictionary *dic4 = [NSMutableDictionary dictionaryWithCapacity:3];
    [dic4 setObject:@"我的社交图谱" forKey:@"title"];
    [dic4 setObject:@"socialMap" forKey:@"icon"];
    [dic4 setObject:@"XHNearGatheringViewController" forKey:@"page"];
    [dataArr addObject:dic4];
 
    return dataArr;
    
}
+(NSArray *)getLeftItemArr
{
    NSArray *dataArr = [[NSArray alloc] init];
    //一度好友
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:3];
    [dic setObject:@"我的活动" forKey:@"title"];
    [dic setObject:@"icon_person" forKey:@"icon"];
 
    [dic setObject:@"XHMyGatherViewController" forKey:@"page"];
   
    //优惠券
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithCapacity:3];
    [dic1 setObject:@"我的群聊" forKey:@"title"];
    [dic1 setObject:@"icon_chat" forKey:@"icon"];
   // GroupListViewController *indentC1 = [[GroupListViewController alloc] init];
    [dic1 setObject:@"GroupListViewController" forKey:@"page"];
 
    //我的收藏
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionaryWithCapacity:3];
    [dic2 setObject:@"创建群聊" forKey:@"title"];
    [dic2 setObject:@"icon_creatchat" forKey:@"icon"];
   // CreatGroupTalkVC *collectionC = [[CreatGroupTalkVC alloc]init];
    [dic2 setObject:@"CreateGroupViewController" forKey:@"page"];
  
    
    NSMutableDictionary *dic3 = [NSMutableDictionary dictionaryWithCapacity:3];
    [dic3 setObject:@"创建聚会" forKey:@"title"];
    [dic3 setObject:@"icon_creatgather" forKey:@"icon"];
 //   XHCreateGatherViewController *controller = [[XHCreateGatherViewController alloc] init];
    [dic3 setObject:@"XHCreateGatherViewController" forKey:@"page"];
 
//    NSMutableDictionary *dic4 = [NSMutableDictionary dictionaryWithCapacity:3];
//    [dic4 setObject:@"加好友" forKey:@"title"];
//    [dic4 setObject:@"icon_addfriend" forKey:@"icon"];
//  //  XHNearGatheringViewController *c4 = [[XHNearGatheringViewController alloc] init];
//    [dic4 setObject:@"XHNearGatheringViewController" forKey:@"page"];
    
    NSMutableDictionary *dic5 = [NSMutableDictionary dictionaryWithCapacity:3];
    [dic5 setObject:@"我参加的活动" forKey:@"title"];
    [dic5 setObject:@"icon_star" forKey:@"icon"];
    //XHNearGatheringViewController *c5 = [[XHNearGatheringViewController alloc] init];
    [dic5 setObject:@"XHMyGatherViewController" forKey:@"page"];

    
    NSMutableDictionary *dic6 = [NSMutableDictionary dictionaryWithCapacity:3];
    [dic6 setObject:@"我的关注" forKey:@"title"];
    [dic6 setObject:@"icon_favourite" forKey:@"icon"];
   // XHNearGatheringViewController *c6 = [[XHNearGatheringViewController alloc] init];
    [dic6 setObject:@"XHMyGatherViewController" forKey:@"page"];
    
    dataArr =[NSArray arrayWithObjects:dic,dic1,dic2,dic3,dic5,dic6, nil];;
    return dataArr;
    
}
+(NSArray *)getMeItemArr
{
    NSArray *dataArr = [[NSArray alloc] init];
    //一度好友
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:3];
    [dic setObject:@"我的活动" forKey:@"title"];
    [dic setObject:@"icon_person" forKey:@"icon"];
  
    [dic setObject:@"XHMyGatherViewController" forKey:@"page"];
    
    //优惠券
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithCapacity:3];
    [dic1 setObject:@"我的关注" forKey:@"title"];
    [dic1 setObject:@"icon_colect" forKey:@"icon"];
   
    [dic1 setObject:@"XHMyGatherViewController" forKey:@"page"];
    
    //我的收藏
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionaryWithCapacity:3];
    [dic2 setObject:@"申请成为大型会议经理" forKey:@"title"];
    [dic2 setObject:@"icon_note" forKey:@"icon"];
   
    [dic2 setObject:@"XHRequestMMViewController" forKey:@"page"];
    
    
    NSMutableDictionary *dic3 = [NSMutableDictionary dictionaryWithCapacity:3];
    [dic3 setObject:@"账号信息" forKey:@"title"];
    [dic3 setObject:@"icon_account" forKey:@"icon"];
   
    [dic3 setObject:@"XHSetUpViewController" forKey:@"page"];
    
    NSMutableDictionary *dic4 = [NSMutableDictionary dictionaryWithCapacity:3];
    [dic4 setObject:@"我的隐私设置" forKey:@"title"];
    [dic4 setObject:@"icon_secret" forKey:@"icon"];
    
    [dic4 setObject:@"XHNearGatheringViewController" forKey:@"page"];
    
    NSMutableDictionary *dic5 = [NSMutableDictionary dictionaryWithCapacity:3];
    [dic5 setObject:@"系统设置" forKey:@"title"];
    [dic5 setObject:@"icon_system" forKey:@"icon"];
  
    [dic5 setObject:@"XHSystemSetViewController" forKey:@"page"];
    
    
    
    dataArr =[NSArray arrayWithObjects:dic,dic1,dic2,dic3,dic4,dic5, nil];;
    return dataArr;
    
}
+(NSArray *)getMessageArr
{
    NSArray *arr=[[NSArray alloc] init];
    XHMessage *message1=[[XHMessage alloc] init];
    message1.userHead=@"icon_star";
    message1.title=@"待处理事项";
    message1.msgInfo=@"6个请求待处理";
    message1.time=@"4-13";
    message1.messageTpe=1;
    
    XHMessage *message2=[[XHMessage alloc] init];
    message2.userHead=@"icon_chat";
    message2.title=@"我的群组消息";
    message2.msgInfo=@"6外滩创业，今晚约玩德州";
    message2.time=@"4-13";
    message2.messageTpe=2;
    
    XHMessage *message3=[[XHMessage alloc] init];
    message3.userHead=@"icon_gather";
    message3.title=@"聚会信息";
    message3.msgInfo=@"您有一个新的聚会信息";
    message3.time=@"4-13";
    message3.messageTpe=3;
    arr =[NSArray arrayWithObjects:message1,message2,message3, nil];;
    return arr;
}
+(NSMutableArray *)getGatherArr
{
    NSMutableArray *arr =[NSMutableArray new];
    XHGather *gather =[[XHGather alloc] init];
    gather.img=@"gather";
    gather.title=@"2015京东移动技术峰会";
    gather.location=@"上海虹桥国家会展中心2F场馆";
    gather.time=@"2015-05-18 10:30:00";
    
    XHGather *gather2 =[[XHGather alloc] init];
    gather2.img=@"gather";
    gather2.title=@"互联网＋金融改变世界";
    gather2.location=@"上海虹桥国家会展中心2F场馆";
    gather2.time=@"2015-03-11 11:12:00";

    arr=[[NSMutableArray alloc] initWithObjects:gather,gather2, nil];
    return arr;
}
-(void)clearAllUserDefault
{
    NSDictionary *defaultsDictionary = [[NSUserDefaults standardUserDefaults]dictionaryRepresentation];
    for (NSString *key in [defaultsDictionary allKeys])
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (CLLocationDistance) getCLLocationDistance:(CLLocationCoordinate2D)coordinateA TheTowCoordinate:(CLLocationCoordinate2D )coordinateB
{
    CLLocationDistance dis;
    dis = BMKMetersBetweenMapPoints(BMKMapPointForCoordinate(coordinateA), BMKMapPointForCoordinate(coordinateB)) ;
    return dis;
    
}
@end