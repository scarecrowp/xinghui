//
//  UserManager.m
//  XingHui
//
//  Created by wangpei on 15/8/22.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "UserManager.h"
#import "LKDBHelper.h"
#import "Versions.h"
@implementation UserManager
+ (UserManager *)share
{
    static UserManager *manage;
    @synchronized(self) {
        if (!manage)
            manage = [[self alloc] init];
        return manage;
    }
}
-(void)getOLFriendComplete:(void (^)(NSMutableArray *Arr))complete
{
    NSDictionary *par=@{@"uid":@([XHDefaultUser sharedUser].uid)};
    LKDBHelper *dbhelper=[[LKDBHelper alloc] initWithDBName:@"XINGHUI"];
    NSMutableArray *userArr=[dbhelper searchWithSQL:@"select * from @t where myfriend=1 and job<>''" toClass:[XHUser class]];
    if (userArr.count>0) {
        complete(userArr);
        //[_delegate didgetPerson:userArr];
    }
    else
    {
        [[XHNetWork sharedNetWork] Get:[NSString APIURLString:@"friend1.ashx"] param:par complete:^(NSDictionary *dic1){
            NSMutableArray *userarr=[NSMutableArray new];
            for (NSDictionary *dic in dic1[@"content"]) {
                XHUser *user=[[XHUser alloc] initWithDic:dic];
                user.myfriend=1;
                [[XHUserHelper share] insertOne:user];
                [userarr addObject:user];
            }
            complete(userArr);
            // [_delegate didgetPerson:userarr];
        }];
    }

}
-(void)getFriendWithtype:(int)friendtype complete:(void (^)(NSMutableArray *Arr))complete
{
    switch (friendtype) {
        case 1:[self getFirstFriendcomplete:complete];break;
        case 2:[self getSecondFriendComplete:complete];break;
            
        case 3:[self getNearFriendComplete:complete];break;
        case 4:[self Invitationfriend:complete];
        default:
            break;
    }
}
-(void)getFriendWithParam:(NSDictionary *)par complete:(void (^)(NSMutableArray *))complete
{
    switch ([par[@"type"] integerValue]) {
        case 1:[self getFirstFriendWithPage:[par[@"page"] intValue] complete:complete];break;
        case 2:[self getSecondFriendWithPage:[par[@"page"] intValue] complete:complete];break;
            
        case 3:[self getNearFriendComplete:complete];break;
        case 4:[self Invitationfriend:complete];
        default:
            break;
    }
}
-(void)getFirstFriendWithPage:(int)page  complete:(void (^)(NSMutableArray *Arr))complete
{
    NSDictionary *par =@{@"page":@(page),@"uid":@([XHDefaultUser sharedUser].uid)};
    [self getFirstFriendWithParam:par complete:complete];
}
-(void)getFirstFriendWithParam:(NSDictionary *)par complete:(void (^)(NSMutableArray *))complete
{
    [[XHNetWork sharedNetWork] Get:[NSString APIURLString:@"friend1.ashx"] param:par complete:^(NSDictionary *dic){
        NSMutableArray *userarr=[NSMutableArray new];
        for (NSDictionary *dics in dic[@"content"]) {
            XHUser *user=[[XHUser alloc] initWithDic:dics];
            user.myfriend=1;
            [[XHUserHelper share] insertOne:user];
            [userarr addObject:user];
        }
        complete(userarr);
    }];
}
-(void)getFirstFriendcomplete:(void (^)(NSMutableArray *Arr))complete
{
    NSDictionary *par=@{@"uid":@([XHDefaultUser sharedUser].uid)};
    [self getFirstFriendWithParam:par complete:complete];
}
-(void)searchFriend:(NSDictionary *)par complete:(void(^)(NSMutableArray *Arr))complete
{
    [[XHNetWork sharedNetWork] Get:[NSString APIURLString:@"friend.ashx"] param:par complete:^(NSDictionary *dic){
        NSMutableArray *userarr=[NSMutableArray new];
        for (NSDictionary *dics in dic[@"content"]) {
            XHUser *user=[[XHUser alloc] initWithDic:dics];
            user.myfriend=1;
            [[XHUserHelper share] insertOne:user];
            [userarr addObject:user];
        }
        complete(userarr);
        // [_delegate didgetPerson:userarr];
    }];
}
-(void)getSecondFriendComplete:(void (^)(NSMutableArray *Arr))complete
{
    LKDBHelper *dbhelper=[[LKDBHelper alloc] initWithDBName:@"XINGHUI"];
    NSMutableArray *userArr=[dbhelper searchWithSQL:@"select * from @t where myfriend=2 " toClass:[XHUser class]];
    if (userArr.count>0) {
      //  complete(userArr);
        //        [_delegate didgetPerson:userArr];
    }
    else
    {
            }
    [[XHNetWork sharedNetWork] Get:[NSString APIURLString:@"friend2.ashx"] param:nil complete:^(NSDictionary *dic){
        NSMutableArray *userarr=[NSMutableArray new];
        for (NSDictionary *dics in dic[@"content"]) {
            XHUser *user=[[XHUser alloc] initWithDic:dics];
            user.myfriend=2;
            [[XHUserHelper share] insertOne:user];
            [userarr addObject:user];
        }
        complete(userarr);
        // [_delegate didgetPerson:userarr];
    }];

}
-(void)getSecondFriendWithPage:(int)page complete:(void (^)(NSMutableArray *))complete
{
    [[XHNetWork sharedNetWork] Get:[NSString APIURLString:@"friend2.ashx"] param:@{@"page":@(page)} complete:^(NSDictionary *dic){
        NSMutableArray *userarr=[NSMutableArray new];
        for (NSDictionary *dics in dic[@"content"]) {
            XHUser *user=[[XHUser alloc] initWithDic:dics];
            user.myfriend=2;
            [[XHUserHelper share] insertOne:user];
            [userarr addObject:user];
        }
        complete(userarr);
    }];

}
-(void)Invitationfriend:(void(^)(NSMutableArray *Arr))complete
{
 
    LKDBHelper *dbhelper=[[LKDBHelper alloc] initWithDBName:@"XINGHUI"];
    NSMutableArray *userArr=[dbhelper searchWithSQL:@"select * from @t where myfriend=1 and job  = ''" toClass:[XHUser class]];
  
      complete(userArr);
}
-(void)getNearFriendComplete:(void (^)(NSMutableArray *Arr))complete
{
    NSDictionary *par=@{@"uid":@([XHDefaultUser sharedUser].uid),
                        @"lat":[NSString stringWithFormat:@"%.10f",[XHDefaultUser sharedUser].coordinate.latitude],
                        @"lon":[NSString stringWithFormat:@"%.10f",[XHDefaultUser sharedUser].coordinate.longitude]};
  //  LKDBHelper *dbhelper=[[LKDBHelper alloc] initWithDBName:@"XINGHUI"];
   // NSMutableArray *userArr=[dbhelper searchWithSQL:@"select * from @t where myfriend=2 " toClass:[XHUser class]];
 
    [[XHNetWork sharedNetWork] Get:[NSString APIURLString:@"nearfriend.ashx"] param:par complete:^(NSDictionary *dic){
        NSMutableArray *userarr=[NSMutableArray new];
        NSMutableArray *arr=dic[@"content"];
        for (NSDictionary *dics in arr) {
            XHUser *user=[[XHUser alloc] initWithDic:dics];
            
            [userarr addObject:user];
        }

            complete(userarr);
        // [_delegate didgetPerson:userarr];
    }];
    
    
}

-(void)getSecondFriend:(NSString *)uid finish:(void (^)(NSMutableArray *friends))finish
{
    NSDictionary *par=@{@"uid":uid};
    [[XHNetWork sharedNetWork] Get:[NSString APIURLString:@"friend2.ashx"] param:par complete:^(NSDictionary *dic){
        finish(dic[@"content"]);
    }];
}
-(void)getUserDetail:(int)uid finish:(void (^)(NSDictionary * dic))finish
{
    NSDictionary *par=@{@"uuid":@(uid)};
    [[XHNetWork sharedNetWork] Get:[NSString APIURLString:@"userdetail.ashx"] param:par complete:^(NSDictionary *dic){
        finish([dic[@"content"] objectAtIndex:0]);
        
    }];
}

@end
