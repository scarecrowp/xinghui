//
//  GatherDetailBottom.h
//  XingHui
//
//  Created by wangpei on 15/8/18.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BottomDelegate;
@interface GatherDetailBottom : UIView
-(void)setJoinStatus:(BOOL)isJoin isFocus:(BOOL)isFocus;
-(void)setHasJoin:(BOOL)isJoin;
-(void)setHasFocus:(BOOL)isfocus;
@property BOOL isFocus;
@property BOOL isJoin;
@property(nonatomic,weak) id<BottomDelegate>delegate;

@end
@protocol BottomDelegate <NSObject>

-(void)didcomment;
-(void)didfocus;
-(void)didJoin;
@end