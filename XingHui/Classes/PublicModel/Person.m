//
//  Person.m
//  XingHui
//
//  Created by wangpei on 15/8/22.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "Person.h"

@implementation Person
+(NSString *)getTableName
{
    return @"Person";
}
-(id)initWithDic:(NSDictionary *)dic
{
    self=[super init];
    self.name=dic[@"user_realname"];
    self.tell=dic[@"user_mobile"];
    self.Company=[dic[@"user_company"] ToString];
    self.Job=[dic[@"user_job"] ToString];
    self.Pic=[NSString PicUrlString:[dic[@"user_pic"] ToString]];
    return self;
}
@end
