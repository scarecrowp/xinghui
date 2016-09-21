//
//  XHUrl.m
//  XingHui
//
//  Created by wangpei on 15/9/8.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHUrl.h"
static XHUrl *sharedInstance;
@implementation XHUrl
+(XHUrl *)sharedInstance
{
    @synchronized(self)
    {
        if (!sharedInstance)
        {
            sharedInstance = [[XHUrl alloc] init];
            //#warning 因桥谷后台代码暂时没有与测试环境后台代码同步，因此这里生产环境也暂时用测试环境代替
            //            serverAddress = (NSString *)AppServer_UAT;
          //  serverAddress = (NSString *)AppServer_PROD;
           // serverAddress_chat = (NSString *)AppServer_Chat_PROD;
        }
    }
    return sharedInstance;
}
+(id)alloc
{
    //TODO check why the following code is needed
    @synchronized(self)
    {
        sharedInstance = [super alloc];
    }
    return sharedInstance;
}

@end
