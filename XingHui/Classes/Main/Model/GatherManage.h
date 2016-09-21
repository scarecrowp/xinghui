//
//  MyGatherManage.h
//  XingHui
//
//  Created by wangpei on 15/8/13.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol GatherManageDelegate;
@interface GatherManage : NSObject
-(void)getMyGather: (NSInteger )type currtype:(NSInteger)currtype uid:(int)uid;
-(void)getTotalGather:(int)page;
-(void)getGatherWithParam:(NSDictionary *)par;
-(void)getNearGather:(int)page;
-(void)getGatherComment:(NSString *)gatherId page:(int)page;
-(void)getGatherWithParam:(NSDictionary *)par finish:(void (^)(NSMutableArray *dic)) finish;
-(void)createGather:(NSDictionary *)gather gatherPicData:(NSData *)gatherPicData finish:(void (^) (void)) finish;
-(void)getAllMyGather:(void (^)(NSMutableArray *arr))finish;
@property(nonatomic,strong)id<GatherManageDelegate>delegate;
@property (nonatomic, strong) LKDBHelper *dbhelper;
-(void)addFocus:(NSString *)gid;
-(void)join:(NSString *)join;
@end
@protocol GatherManageDelegate <NSObject>
@optional
-(void)didGetDather:(NSMutableArray *)gatherarr;
-(void)didGetComment:(NSDictionary *)dic;
-(void)didRequestSuccess:(NSDictionary *)obj;
-(void)CreateSuccess;
-(void)CreateFail:(NSString *)failReason;
@end