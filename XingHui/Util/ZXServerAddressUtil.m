//
//  ZXServerAddressUtil.m
//  QiaoGu
//
//  Created by JackLiu on 14-8-20.
//  Copyright (c) 2014年 ZXInsight. All rights reserved.
//

//测试环境
#define AppServer_UAT @"http://qiaogu.sysmart.cn"
//聊天测试环境
#define AppServer_Chat_UAT @"http://dev.qg.51beta.cn:9080/qg-api"
//#define AppServer_Chat_UAT @"http://192.168.2.157:8080"


//聊天开发环境
//#define AppServer_Chat_PROD @"http://chat.715buy.com:9080/qg-api"
//#define AppServer_Chat_PROD @"http://192.168.0.211:8080/qg-api2"
#define AppServer_Chat_PROD @"http://121.40.160.251:9080/qg-api2"

#import "ZXServerAddressUtil.h"

#ifdef DEBUG
//开发环境
#define AppServer_PROD @"http://web.715buy.com"
#else
//do sth.
#define AppServer_PROD @"http://app.715buy.com"
#endif

@implementation ZXServerAddressUtil
{
}

static ZXServerAddressUtil *sharedInstance;

static NSString *serverAddress;
static NSString *serverAddress_chat;

+ (ZXServerAddressUtil *)sharedInstance
{
    @synchronized(self)
    {
        if (!sharedInstance)
        {
            sharedInstance = [[ZXServerAddressUtil alloc] init];
//#warning 因桥谷后台代码暂时没有与测试环境后台代码同步，因此这里生产环境也暂时用测试环境代替
//            serverAddress = (NSString *)AppServer_UAT;
            serverAddress = (NSString *)AppServer_PROD;
            serverAddress_chat = (NSString *)AppServer_Chat_PROD;
        }
    }
    return sharedInstance;
}

+ (id)alloc
{
    //TODO check why the following code is needed
    @synchronized(self)
    {
        sharedInstance = [super alloc];
    }
    return sharedInstance;
}

- (void)setEviromentMode:(EviromentMode)mode
{
    switch (mode) {
            
        case UAT:
            serverAddress = (NSString *)AppServer_UAT;
            serverAddress_chat = (NSString *)AppServer_Chat_UAT;
            break;

        case PROD:
            serverAddress = (NSString *)AppServer_PROD;
            serverAddress_chat = (NSString *)AppServer_Chat_PROD;
            break;
            
        default:
            break;
    }
}

 
@end
