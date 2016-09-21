//
//  XHDefaultUser.m
//  XingHui
//
//  Created by wangpei on 15/8/5.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHDefaultUser.h"
#import "LKDBHelper.h"
@implementation XHDefaultUser
  static XHDefaultUser *user;
+(NSString *)getTableName
{
    return @"XHDefaultUser";
}
-(void)initUser
{
    NSDictionary *dic =[JLCommonUtil getUserInfo];
    [XHDefaultUser sharedUser].username=[dic objectForKey:@"user_name"];
    [XHDefaultUser sharedUser].tell=[dic objectForKey:@"user_mobile"];;
    [XHDefaultUser sharedUser].userpic=[NSString PicUrlString:[dic objectForKey:@"user_pic"]];;
    [XHDefaultUser sharedUser].uid=[[dic objectForKey:@"ID"] integerValue];;
    [XHDefaultUser sharedUser].job=[dic objectForKey:@"user_job"];
    [XHDefaultUser sharedUser].company=[dic objectForKey:@"user_company"];
    [XHDefaultUser sharedUser].sex=[dic objectForKey:@"user_sex"];
    [XHDefaultUser sharedUser].industry=dic[@"user_industry"];
    [XHDefaultUser sharedUser].birthday=dic[@"user_birthday"];
    [XHDefaultUser sharedUser].userRealName=dic[@"user_realname"];
    [XHDefaultUser sharedUser].workHistory=[NSMutableArray new];
    [XHDefaultUser sharedUser].studyHistory = [NSMutableArray new];;
    [XHDefaultUser sharedUser].mail = dic[@"user_mail"];
    [XHDefaultUser sharedUser].wechat = dic[@"user_wechat"];
    [XHDefaultUser sharedUser].QQ = dic[@"user_qq"];
    [XHDefaultUser sharedUser].userType = [dic[@"user_type"] integerValue];
    [XHDefaultUser sharedUser].applyStatus = [dic[@"apply_status"] integerValue];
    if (dic[@"jobhistory"]) {
        [XHDefaultUser sharedUser].workHistory=dic[@"jobhistory"];
    }
    if (dic[@"study"]) {
          [XHDefaultUser sharedUser].studyHistory=dic[@"study"];
    }
    
    if (dic[@"tag"]) {
        self.tagArr =[NSMutableArray new];
        [self.tagArr addObjectsFromArray:dic[@"tag"]];
    }
}


+ (XHDefaultUser *)sharedUser
{
    @synchronized(self)
    {
        if (!user)
        {
            user = [[XHDefaultUser alloc] init];
            [user initUser];
        }
        return user;
    }
}
+(void)clearUser
{
    user=nil;
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
}
-(void)saveDefaultUser
{
    NSMutableDictionary *userDic=[[NSMutableDictionary alloc] initWithDictionary:[JLCommonUtil getUserInfo]];
    [userDic setObject:[XHDefaultUser sharedUser].workHistory forKey:@"jobhistory"];
    [userDic setObject:[XHDefaultUser sharedUser].industry forKey:@"user_industry"];
    [userDic setObject:[XHDefaultUser sharedUser].userpic forKey:@"user_pic"];
    [userDic setObject:[XHDefaultUser sharedUser].studyHistory forKey:@"study"];
    [JLCommonUtil saveUserInfo:userDic];
}
-(void)saveUserPic:(NSString *)picUrl
{
    NSMutableDictionary *userDic=[[NSMutableDictionary alloc] initWithDictionary:[JLCommonUtil getUserInfo]];
 
    [userDic setObject:picUrl forKey:@"user_pic"];
    [JLCommonUtil saveUserInfo:userDic];

}
-(void)saveUserType:(NSInteger)userType
{
    NSMutableDictionary *userDic=[[NSMutableDictionary alloc] initWithDictionary:[JLCommonUtil getUserInfo]];
    [userDic setObject:@(userType) forKey:@"user_type"];
    [JLCommonUtil saveUserInfo:userDic];
}
-(void)saveApplyStatus:(NSInteger )applyStatus
{
    //apply_status
    NSMutableDictionary *userDic=[[NSMutableDictionary alloc] initWithDictionary:[JLCommonUtil getUserInfo]];
    [userDic setObject:@(applyStatus) forKey:@"apply_status"];
    [XHDefaultUser sharedUser].applyStatus=applyStatus;;
    [JLCommonUtil saveUserInfo:userDic];

}
-(void)saveUserTagArr
{
    NSMutableDictionary *userDic=[[NSMutableDictionary alloc] initWithDictionary:[JLCommonUtil getUserInfo]];
    [userDic setObject:[XHDefaultUser sharedUser].tagArr forKey:@"tag"];
    [JLCommonUtil saveUserInfo:userDic];
}
@end
