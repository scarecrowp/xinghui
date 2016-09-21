//
//  GatherDetailManage.h
//  XingHui
//
//  Created by wangpei on 15/8/12.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ManageDelegate;
@interface GatherDetailManage : NSObject
@property(nonatomic,strong)id<ManageDelegate>managedelegate;
+ (GatherDetailManage *)shareManage;
-(void)getCommentList;
@end
@protocol ManageDelegate <NSObject>

-(void)didGetCommentList:(NSDictionary *)dic;

@end