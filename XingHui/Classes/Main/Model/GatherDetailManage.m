//
//  GatherDetailManage.m
//  XingHui
//
//  Created by wangpei on 15/8/12.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "GatherDetailManage.h"

@implementation GatherDetailManage
+ (GatherDetailManage *)shareManage
{
    static GatherDetailManage *manage;
    @synchronized(self) {
        if (!manage)
            manage = [[self alloc] init];
        return manage;
    }
}
-(void)getCommentList
{
    [[XHNetWork sharedNetWork] Get:[NSString APIURLString:@"commentlist.ashx"] param:nil complete:^(NSDictionary *dic){
        [_managedelegate didGetCommentList:dic];
    }];
}
@end
