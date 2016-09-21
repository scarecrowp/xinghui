//
//  XHGather.m
//  XingHui
//
//  Created by wangpei on 15/6/9.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHGather.h"
#import <CoreLocation/CoreLocation.h>
@implementation XHGather
-(id)initWithDic:(NSDictionary *)dic
{
    self=[super init];
    self.gid=[dic[@"ID"] ToString];
    self.title=[dic[@"mt_title"] ToString];
    self.note=[[dic[@"mt_info"] ToString] isEqualToString:@""]?@"暂无介绍":[dic[@"mt_info"] ToString];
    self.time=[dic[@"mt_begintime"] ToString];
    self.location=[dic[@"mt_location"] ToString];
    self.place=[dic[@"mt_address"] ToString];
    self.img=[NSString PicUrlString:[dic[@"mt_picture"] ToString]];
    self.gpsCoordinate = CLLocationCoordinate2DMake([[dic objectForKey:@"mt_lat"]floatValue], [[dic objectForKey:@"mt_lon"]floatValue]);
    self.type=[dic[@"mt_type"] intValue];
    self.createrName=[dic[@"user_realname"] ToString];
    if ([[dic[@"joins"] ToString] isEqualToString:@""]) {
        self.joiner=[NSMutableArray new];
    }
    else
    {
        self.joiner=dic[@"joins"];
    }
  
    self.createrID =[dic[@"uid"] integerValue];
 
    self.focuserNum=[dic[@"focusNum"] integerValue];
  
    self.lat=dic[@"mt_lat"];
    self.lon=dic[@"mt_lon"];
    self.commentArr=dic[@"comment"];
    XHUser *user =[[XHUser alloc] init];
    user.uid=dic[@"uid"];
    user.userRealName=dic[@"user_realname"];
    user.tell=dic[@"user_mobile"];
    user.job=dic[@"user_job"];
    user.userpic=[NSString PicUrlString:dic[@"user_pic"]];
    user.industry=dic[@"user_industry"];
    user.myfriend = [dic[@"relation"] intValue];
    self.paytype=dic[@"mt_paytype"];
    CLLocationCoordinate2D a=[XHDefaultUser sharedUser].coordinate;
    if ([XHDefaultUser sharedUser].coordinate.latitude>1) {
        CLLocationCoordinate2D b=CLLocationCoordinate2DMake([self.lat floatValue],[self.lon floatValue]);
        CLLocationDistance d2=	[JLCommonUtil getCLLocationDistance:a TheTowCoordinate:b];
        
        self.distance=[NSString stringWithFormat:@"%.2f km",d2/1000];//[XHDefaultUser sharedUser].coordinate
    }
    else
    {
        self.distance=@"正在计算距离";
    }
    self.creater =user;
    
  //  self  = [XHGather yy_modelWithDictionary:dic];
    return self;
}
//+ (NSDictionary *)modelCustomPropertyMapper {
//    return @{@"gid" : @"ID",
//             @"title" : @"mt_title",
//             @"note" : @"mt_info",
//              @"time" : @"mt_begintime",
//              @"location" : @"mt_location",
//              @"place" : @"mt_address",
//              @"img" : @"mt_picture",
//              @"place" : @"mt_address",
//              @"type" : @"mt_type",
//              @"createrName" : @"user_realname",
//              @"joiner" : @"joins",
//              @"createrID" : @"uid",//
//              @"place" : @"mt_address",
//              @"place" : @"mt_address",
//              @"place" : @"mt_address",
//              @"place" : @"mt_address",
//             };
//}
@end
