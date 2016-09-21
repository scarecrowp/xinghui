//
//  XHUser.m
//  XingHui
//
//  Created by gaoyuerui on 15/6/2.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHUser.h"

@implementation XHUser
+(NSString *)getTableName
{
    return @"XHUser";
}
-(id)init
{
    self=[super init];
    
    return self;
}
-(instancetype)initWithDic:(NSDictionary *)dic
{
    self=[super init];
    self.userRealName=[dic objectForKey:@"user_realname"];
    self.username=dic[@"user_name"];
    self.tell=[dic objectForKey:@"user_mobile"];;
    self.userpic=[NSString PicUrlString:[dic objectForKey:@"user_pic"]];;
    self.uid=[[dic objectForKey:@"ID"] integerValue];
    self.job=[dic objectForKey:@"user_job"];
    self.company=[dic objectForKey:@"user_company"];
    self.sex=[dic objectForKey:@"user_sex"];
    self.industry=dic[@"user_industry"];
    self.birthday=dic[@"user_birthday"];
    self.mail = [dic[@"user_mail"] ToString];
    self.wechat = dic[@"user_wechat"];
    self.QQ = dic[@"user_qq"];
    self.workHistory =[NSMutableArray new];
    if (dic[@"job"]) {
        [self.workHistory addObjectsFromArray:dic[@"job"]];
    }
    self.studyHistory = [NSMutableArray new];
    if (dic[@"study"]) {
       
        [self.studyHistory addObjectsFromArray:dic[@"study"]];
    }
    
    if (dic[@"distance"]) {
        self.distance=[dic[@"distance"] ToString];
    }
    if (dic[@"relation"]) {
        self.myfriend=[dic[@"relation"] intValue];
    }
    self.tagArr=[NSMutableArray new];
    if (dic[@"common"]) {
          self.sameFriend=dic[@"common"];
    }
  
    if (dic[@"tag"]) {
        self.tagArr =[NSMutableArray new];
        [self.tagArr addObjectsFromArray:dic[@"tag"]];
    }
    else
    {
        self.tagArr =[NSMutableArray new];
      //  [self.tagArr addObject:@{@"tag_title":self.industry,@"tag_num":@(1)}];

    }
    if (dic[@"is_ok"] ) {
        self.is_ok = [dic[@"is_ok"] integerValue];
    }
    
    return self;
}
-(NSString *)userpic
{
    if (_userpic) {
        return _userpic;
    }
    else
    {
        return @"";
    }
}
@end
