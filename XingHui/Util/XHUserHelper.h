//
//  XHUserHelper.h
//  XingHui
//
//  Created by wangpei on 15/8/31.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKDBHelper.h"
@interface XHUserHelper : NSObject
{
}
+(XHUserHelper *)share;
-(NSString *)getUserRealnameFromTell:(NSString *)tell;
-(void)insertUser:(NSMutableArray *)userArr;
-(void)getUserFromTell:(NSString *)tell complete:(void (^)(XHUser *user))complete;
-(void)insertOne:(XHUser *)user;
@end
