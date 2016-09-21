//
//  XHMyFocusGather.h
//  XingHui
//
//  Created by gaoyuerui on 15/10/30.
//  Copyright © 2015年 wangpei. All rights reserved.
//

#import "XHGather.h"

@interface XHMyGather : NSObject
@property NSInteger dataType;
-(id)initWithDic:(NSDictionary *)dic;
@property(nonatomic,strong)NSString *gid;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *note;

@property(nonatomic,strong)NSString *img;
@property(nonatomic,strong)NSString *distance;
@property(nonatomic,strong)NSString *time;
@property(nonatomic,strong)NSString *place;
@property(nonatomic,strong)NSString *location;
@property CLLocationCoordinate2D gpsCoordinate;
@property NSInteger createrID;
@property(nonatomic,strong)NSString *paytype;
@property(nonatomic,strong)NSString *createrName;//创建人的姓名
@property(nonatomic,strong)NSMutableArray *joiner;//参加的人
@property(nonatomic,strong)XHUser *creater;
@property NSInteger focuserNum;//关注的人
@property(nonatomic,strong)NSMutableArray *commentArr;
@property NSInteger type;//1:大型会议
@property(nonatomic,strong)NSString *lat;
@property(nonatomic,strong)NSString *lon;
@end
