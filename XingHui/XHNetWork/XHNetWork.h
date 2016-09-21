//
//  XHNetWork.h
//  XingHui
//
//  Created by wangpei on 15/6/12.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface XHNetWork : NSObject


- (void) Get:(NSString *)url param:(NSDictionary *)param complete:(void (^)(NSDictionary *arr))complete;
- (void) Post:(NSString *)url parameters:(NSDictionary *)parameters complete:(void (^)(NSDictionary *dic))complete;
- (void) Login:(NSString *)url param:(NSDictionary *)param complete:(void (^)(NSDictionary *arr))complete;
-(void)Get:(NSString *)url param:(NSDictionary *)param complete:(void (^) (NSDictionary *arr))complete errorMsg:(void (^)(NSString *str)) errorMsg;
+ (XHNetWork *) sharedNetWork;
- (void) uploadLBS:(NSString *)lat lon:(NSString *)lon;
-(void)Post:(NSString *)url parameters:(NSDictionary *)parameters complete:(void (^)(NSDictionary *dic))complete errorMsg:(void (^) (NSString *str))errorMsg;
/**
 *  Post Data数据
 *
 *  @param url        url
 *  @param data       NSData数据
 *  @param parameters 其他参数
 *  @param complete   成功返回
 *  @param error      错误信息
 */
-(void)PostData:(NSString *)url data:(NSData *)data parameters:(NSDictionary *)parameters complete:(void (^)(NSDictionary *))complete error:(void (^)(NSString *))error;
@end
 