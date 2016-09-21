//
//  MyGatherManage.m
//  XingHui
//
//  Created by wangpei on 15/8/13.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//
#define  gatherUrl [NSString APIURLString:@"gatherlist.ashx"]
#import "GatherManage.h"
#import "XHGather.h"
#import "AFNetworking.h"
#import "XHMyGather.h"
@implementation GatherManage

-(void)getMyGather: (NSInteger )type currtype:(NSInteger)currtype uid:(int)uid
{
    
    if (type==1) {
        [self getMyCreateGather:currtype uid:uid];
    }
    else if (type==2)
    {
        [self getMyjoinGather:currtype uid:uid];
    }
    else if (type>2)
    {
        [self getMyFoucsgather:uid type:currtype];
    }
}
-(void)getMyCreateGather:(NSInteger)currType uid:(int)uid
{
    if (!_dbhelper) {
        _dbhelper = [[LKDBHelper alloc] initWithDBName:@"XINGHUI"];
    }
   
    NSString *sql =[NSString stringWithFormat:@"datatype=%d and type=%ld and createrID=%d",1,(long)currType,uid];
    NSMutableArray *arr = [_dbhelper search:[XHMyGather class] where:sql orderBy:@"" offset:0 count:20];
    if (arr.count>0) {
         [_delegate didGetDather:arr];
    }
    else
    {
        NSDictionary *par=@{@"ctype":@(currType),@"creater":@(uid)};
        [self getGatherWithParam:par finish:^(NSMutableArray *dic){
            NSMutableArray *darr =[NSMutableArray new];
        
            for (NSDictionary *dica in dic) {
                XHMyGather *gather =[[XHMyGather alloc] initWithDic:dica];
                gather.dataType = 1;
              
                [_dbhelper insertToDB:gather];
                [darr addObject:gather];
            }
            [_delegate didGetDather:darr];
        }];
    }
  
}
-(void)getMyjoinGather:(NSInteger)currType uid:(int)uid
{
    if (!_dbhelper) {
        _dbhelper = [[LKDBHelper alloc] initWithDBName:@"XINGHUI"];
    }
    NSString *sql =[NSString stringWithFormat:@"datatype=2 and type=%ld and createrID=%d",(long)currType,uid];
    NSMutableArray *arr = [_dbhelper search:[XHMyGather class] where:sql orderBy:@"" offset:0 count:20];
    if (arr.count>0) {
        [_delegate didGetDather:arr];
    }
    else
    {
        NSDictionary *par=@{@"ctype":@(currType),@"juid":@(uid)};
        [self getGatherWithParam:par finish:^(NSMutableArray *dic){
            NSMutableArray *darr =[NSMutableArray new];
            for (NSDictionary *dica in dic) {
                XHMyGather *gather =[[XHMyGather alloc] initWithDic:dica];
                gather.dataType = 2;
                [_dbhelper insertToDB:gather];
                [darr addObject:gather];
            }
            [_delegate didGetDather:darr];
        }];
    }
    
  }
-(void)getGatherWithParam:(NSDictionary *)par
{
    [[XHNetWork sharedNetWork] Get:[NSString APIURLString:@"gatherlist.ashx"] param:par complete:^(NSDictionary *dic){
    
        [_delegate didGetDather:dic[@"content"]];
    }];
}
-(void)getGatherWithParam:(NSDictionary *)par finish:(void (^)(NSMutableArray *dic)) finish
{
    [[XHNetWork sharedNetWork] Get:[NSString APIURLString:@"gatherlist.ashx"] param:par complete:^(NSDictionary *dic){
        if (finish) {
             finish(dic[@"content"]);
        }
        else
        {
            [_delegate didGetDather:dic[@"content"]];
        }
    }];
}
-(void)getTotalGather:(int)page
{
    [[XHNetWork sharedNetWork] Get:gatherUrl param:@{@"page":@(page)} complete:^(NSDictionary *dic){
        [_delegate didGetDather:dic[@"content"]];
    }];
}
-(void)getNearGather:(int)page
{
    [[XHNetWork sharedNetWork] Get:gatherUrl param:@{@"page":@(page),@"lat":[NSString stringWithFormat:@"%.14f",[XHDefaultUser sharedUser].coordinate.latitude],@"lon":[NSString stringWithFormat:@"%.14f",[XHDefaultUser sharedUser].coordinate.longitude]} complete:^(NSDictionary *dic){
        [_delegate didGetDather:dic[@"content"]];
    }];
}
-(void)getMyFoucsgather:(int)uid type:(NSInteger)type
{
 
 

        NSDictionary *par=@{@"fuid":@(uid),@"ctype":@(type)};
        [self getGatherWithParam:par finish:^(NSMutableArray *dic){
            NSMutableArray *darr =[NSMutableArray new];
            for (NSDictionary *dica in dic) {
                XHMyGather *gather =[[XHMyGather alloc] initWithDic:dica];
                gather.dataType = 3;
                [_dbhelper insertToDB:gather];
                [darr addObject:gather];
            }
            [_delegate didGetDather:darr];
        }];
    
}
-(void)getGatherComment:(NSString *)gatherId page:(int)page
{
    [[XHNetWork sharedNetWork] Get:[NSString stringWithFormat:@"%@comment.ashx",ServerURL]
                             param:@{@"page":@(page),@"gid":gatherId}
                          complete:^(NSDictionary *dic){
        [_delegate didGetComment:dic[@"content"]];
    }];
}

-(void)join:(NSString *)gid
{
    [[XHNetWork sharedNetWork] Post:[NSString stringWithFormat:@"%@join.ashx",ServerURL]
                         parameters:@{@"uid":@([XHDefaultUser sharedUser].uid),
                                      @"gid":gid}
                           complete:^(NSDictionary *dic){
                               [_delegate didRequestSuccess:dic];
                           }];
   
}
-(void)addFocus:(NSString *)gid
{
    [[XHNetWork sharedNetWork] Post:[NSString stringWithFormat:@"%@addfocus.ashx",ServerURL]
                         parameters:@{@"uid":@([XHDefaultUser sharedUser].uid),
                                      @"gid":gid}
                           complete:^(NSDictionary *dic){
                               [_delegate didRequestSuccess:dic];
                           }];

}
-(void)createGather:(NSDictionary *)gather gatherPicData:(NSData *)gatherPicData finish:(void (^) (void)) finish
{
 
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:[NSString APIURLString:@"creatgather.ashx"] parameters:gather constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:gatherPicData name:@"file" fileName:[NSString stringWithFormat:@"message_%@.jpg",@""] mimeType:@"image/jpg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
  
        finish();
        NSLog(@"Success: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_delegate CreateFail:error.description];
        NSLog(@"Error: %@", error);
       
    }];

   
}
-(void)searChGather:(NSDictionary *)param finish:(void (^) (NSDictionary *dic)) finish
{
    [[XHNetWork sharedNetWork] Get:[NSString APIURLString:@"gatherList.ashx"] param:param complete:^(NSDictionary *dic){
        
    } ];
}
-(void)getBigGather:(void (^)(NSMutableArray *arr))finish
{
    NSMutableArray *arr =[_dbhelper search:[XHMyGather class] where:@"type=1" orderBy:@"" offset:0 count:0];
    if (arr.count>0) {
        finish(arr);
    }
    else
    {
        [[XHNetWork sharedNetWork] Get:[NSString APIURLString:@"getmygather.ashx"] param:@{@"type":@(1)} complete:^(NSDictionary *dic){
            NSMutableArray *darr =[NSMutableArray new];
            for (NSDictionary *dica in dic[@"content"]) {
                XHMyGather *gather =[[XHMyGather alloc] initWithDic:dica];
                gather.dataType = 3;
                [_dbhelper insertToDB:gather];
                [darr addObject:gather];
            }
            
            finish(darr);
        }];
    }

}
-(void)getAllMyGather:(void (^)(NSMutableArray *arr))finish
{
 
    NSMutableArray *arr =[_dbhelper search:[XHMyGather class] where:@"" orderBy:@"" offset:0 count:0];
    if (arr.count>0) {
        finish(arr);
    }
    else
    {
        [[XHNetWork sharedNetWork] Get:[NSString APIURLString:@"getmygather.ashx"] param:nil complete:^(NSDictionary *dic){
            NSMutableArray *darr =[NSMutableArray new];
            for (NSDictionary *dica in dic[@"content"]) {
                XHMyGather *gather =[[XHMyGather alloc] initWithDic:dica];
                gather.dataType = 3;
                [_dbhelper insertToDB:gather];
                [darr addObject:gather];
            }
     
            finish(darr);
        }];
    }
}
@end
