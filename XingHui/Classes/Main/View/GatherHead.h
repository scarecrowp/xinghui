//
//  GatherHead.h
//  XingHui
//
//  Created by gaoyuerui on 15/10/8.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XHGather;
@protocol GatherHeadDelegate;
@interface GatherHead : UIView
-(instancetype)initWithGather:(XHGather *)gather;
@property(nonatomic,weak)id<GatherHeadDelegate>delegate;
@property(nonatomic,strong)XHGather *gather;
@end
@protocol GatherHeadDelegate <NSObject>

-(void)Addfocus:(NSString *)gid;
-(void)JoinIn:(NSString *)gid;
-(void)toMap;
@end