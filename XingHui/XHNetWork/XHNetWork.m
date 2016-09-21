
//
//  XHNetWork.m
//  XingHui
//
//  Created by wangpei on 15/6/12.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHNetWork.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "JSONKit.h"
static AFHTTPRequestOperationManager *bClient;
static MBProgressHUD *HUD;
@implementation XHNetWork
+ (XHNetWork *)sharedNetWork
{
    static XHNetWork *theXHNetWork;
    @synchronized(self) {
        if (!theXHNetWork)
        theXHNetWork = [[self alloc] init];
        [theXHNetWork initAfnetWork];
        return theXHNetWork;
    }
}
-(void)initAfnetWork
{
    if (!bClient) {
        bClient = [AFHTTPRequestOperationManager manager];
        [bClient.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        bClient.requestSerializer.timeoutInterval = 20.f;
        [bClient.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    }
     [bClient.requestSerializer setValue:[JLCommonUtil getUserId] forHTTPHeaderField:@"token"];
}
-(void)Login:(NSString *)url param:(NSDictionary *)param complete:(void (^)(NSDictionary *arr))complete
{
   AFHTTPRequestOperationManager *bClienta = [AFHTTPRequestOperationManager manager];
    [bClienta.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    bClienta.requestSerializer.timeoutInterval = 10.f;
    [bClienta.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [bClienta GET:url parameters:param success:^(AFHTTPRequestOperation *operation,id responseObject)
     {
         NSDictionary *dic =responseObject;
         NSLog(@"%@",dic);
         if ([dic isKindOfClass:[NSDictionary class]])
         {
             
             if (dic[@"result"]) {
                 
                     complete(dic);
                  
             }
             
         }
         
     }failure:^(AFHTTPRequestOperation *operation,NSError *error){
         NSLog(@"%@",operation.responseString);
         NSLog(@"%@",operation);
         //
     }];

    
}
-(void)Get:(NSString *)url param:(NSDictionary *)param complete:(void (^)(NSDictionary *arr))complete
{
    [self Get:url param:param complete:complete errorMsg:nil];
}
-(void)Get:(NSString *)url param:(NSDictionary *)param complete:(void (^) (NSDictionary *arr))complete errorMsg:(void (^)(NSString *str)) errorMsg
{
    [bClient GET:url parameters:param success:^(AFHTTPRequestOperation *operation,id responseObject)
     {
         NSDictionary *dic =responseObject;
         NSLog(@"%@",dic);
         if ([dic isKindOfClass:[NSDictionary class]])
         {
             
             if (dic[@"result"]) {
                 if ([dic[@"result"] integerValue]==1) {
                     if (complete) {
                         complete(dic);
                     }
                     
                 }
                 else
                 {
                     if (errorMsg) {
                           errorMsg(dic[@"message"]);
                     }
                   
                 }
             }
             else
             {
                 if (errorMsg) {
                     errorMsg(@"服务器错误");
                 }
             }
             
         }
         else
         {
             
             if (errorMsg) {
                 errorMsg(@"服务器错误");
             }
         }
     }failure:^(AFHTTPRequestOperation *operation,NSError *error){
         NSLog(@"%@",operation.responseString);
         NSLog(@"%@",operation);
         
         if (error) {
             NSLog(error.description);
         }
         //
     }];
    
}
-(void)Post:(NSString *)url parameters:(NSDictionary *)parameters complete:(void (^)(NSDictionary *))complete
{
    [self Post:url parameters:parameters complete:complete errorMsg:nil];
}
-(void)Post:(NSString *)url parameters:(NSDictionary *)parameters complete:(void (^)(NSDictionary *dic))complete errorMsg:(void (^) (NSString *str))errorMsg
{
    [bClient POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation,id responseObject)
     {
         NSDictionary *dics =responseObject;
         if ([dics isKindOfClass:[NSDictionary class]])
         {
             if (dics[@"result"]) {
                 if ([dics[@"result"] isEqualToString:@"1"]) {
                     if (complete) {
                          complete(dics);
                     }
                    
                 }
                 else{
                     if (errorMsg) {
                         errorMsg(dics[@"message"]);
                     }
                     
                 }
             }
             else
             {
                 if (errorMsg) {
                      errorMsg(@"服务器错误");
                 }
                 
             }
         }
         else
         {
             if (errorMsg) {
               errorMsg(@"服务器错误");
             }
         }
         
     }failure:^(AFHTTPRequestOperation *operation,NSError *error){
         NSLog(@"%@",operation.responseString);
         //
        if (errorMsg) {
              errorMsg(@"服务器错误");
        }
         
         
     }];
    
}
-(void)PostData:(NSString *)url data:(NSData *)data parameters:(NSDictionary *)parameters complete:(void (^)(NSDictionary *))complete error:(void (^)(NSString *))errorMsg
{
    
    [bClient POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:data name:@"file" fileName:[NSString stringWithFormat:@"message_%@.jpg",@""] mimeType:@"image/jpg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dics =responseObject;
        if ([dics isKindOfClass:[NSDictionary class]])
        {
            if (dics[@"result"]) {
               
                if ([dics[@"result"] isEqualToString:@"1"]) {
                    complete(dics);
                }
                else
                {
                   errorMsg(dics[@"message"]);
                }
                
            }
            else
            {
                errorMsg(@"服务器错误!");
            }
        }
        else
        {
            errorMsg(@"服务器错误!");
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       errorMsg(error.description);
    }];
    
    
}

#pragma mark 上传当前位置到服务器
-(void)uploadLBS:(NSString *)lat lon:(NSString *)lon
{
    [[XHNetWork sharedNetWork] Get:[NSString APIURLString:@"lbs.ashx"]
                             param:@{@"lat":lat,
                                     @"lon":lon,
                                     @"uid":@([XHDefaultUser sharedUser].uid)   }
                          complete:nil];
}
@end
