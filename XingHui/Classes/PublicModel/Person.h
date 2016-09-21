//
//  Person.h
//  XingHui
//
//  Created by wangpei on 15/8/22.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *tell;
@property(nonatomic,strong)NSString *Pic;
@property(nonatomic,strong)NSString *Company;
@property(nonatomic,strong)NSString *Job;
@property int relationType;//1,一度好友，2，二度好友
-(id)initWithDic:(NSDictionary *)dic;
@end
