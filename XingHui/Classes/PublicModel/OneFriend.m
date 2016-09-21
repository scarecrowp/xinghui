//
//  OneFriend.m
//  XingHui
//
//  Created by wangpei on 15/8/17.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "OneFriend.h"

@implementation OneFriend
+(NSString *)getTableName
{
    return @"Person";
}
-(id)initWithDic:(NSDictionary *)dic
{
    self=[super init];
    self.name=dic[@"user_realname"];
    self.tell=dic[@"user_mobile"];
    self.Company=dic[@"user_company"];
    self.Job=dic[@"user_job"];
    self.relationType=1;
    return self;
}
@end
