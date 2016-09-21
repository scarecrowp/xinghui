//
//  XHUserHelper.m
//  XingHui
//
//  Created by wangpei on 15/8/31.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHUserHelper.h"
#import "LKDBHelper.h"
@implementation XHUserHelper
static LKDBHelper *dbhelper;
+(XHUserHelper *)share
{
    static XHUserHelper *helper;
    
    @synchronized(self) {
        if (!helper)
            helper=[[self alloc] init];
            dbhelper = [[LKDBHelper alloc] initWithDBName:@"XINGHUI"];
        return helper;
    }

}
-(void)insertUser:(NSMutableArray *)userArr
{
    for (NSDictionary *dic in userArr) {
        XHUser *user=[[XHUser alloc] initWithDic:dic];
        if ([dbhelper isExistsClass:[XHUser class] where:[NSString stringWithFormat:@"tell='%@'",user.tell]]) {
            [dbhelper updateToDB:user where:[NSString stringWithFormat:@"tell='%@'",user.tell]];
        }
        else
        {
            [dbhelper insertToDB:user];
        }
    }
    
}
-(void)insertOne:(XHUser *)user
{
    NSString *sql =[NSString stringWithFormat:@" uid =%ld",user.uid];
    if ([dbhelper isExistsClass:[XHUser class] where:sql]) {
        [dbhelper updateToDB:user where:sql];
    }
    else
    {
        [dbhelper insertToDB:user];
    }

}
-(void)updateOne:(XHUser *)user
{
    
}
-(void)getUserFromTell:(NSString *)tell complete:(void (^)(XHUser *user))complete
{
    if (tell.length>11||tell.length==0) {
        complete(nil);
        return;
    }
   __block XHUser *user=[dbhelper searchSingle:[XHUser class] where:[NSString stringWithFormat:@"tell='%@'",tell] orderBy:@""];

    if (!user) {
        
        [[XHNetWork sharedNetWork] Get:[NSString APIURLString:@"getuserfromtell.ashx"] param:@{@"tell":tell} complete:^(NSDictionary *dic){
            user=[[XHUser alloc] initWithDic:[dic[@"content"] objectAtIndex:0]];
            [dbhelper insertToDB:user];
            complete(user);
        }];
    }
    else
    {
            complete(user);
    }
}
-(NSString *)getUserRealnameFromTell:(NSString *)tell
{
    XHUser *user=[dbhelper searchSingle:[XHUser class] where:[NSString stringWithFormat:@"tell='%@'",tell] orderBy:@""];
    
    return user.username;
}
@end
