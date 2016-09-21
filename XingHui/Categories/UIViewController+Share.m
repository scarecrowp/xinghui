//
//  UIViewController+Share.m
//  XingHui
//
//  Created by gaoyuerui on 15/12/1.
//  Copyright © 2015年 wangpei. All rights reserved.
//

#import "UIViewController+Share.h"
#import "UIViewController+Alert.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
@interface UIViewController()

@end

@implementation UIViewController(Share)

-(void)shareContent:(NSString *)content imgUrlStr:(NSString *)imgUrl shareUrl:(NSURL *)shareUrl title:(NSString *)title
{
    NSMutableDictionary *shareParams=[NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:content
                                     images:imgUrl
                                        url:shareUrl
                                      title:title
                                       type:SSDKContentTypeAuto];
    [ShareSDK showShareActionSheet:nil
                             items:nil
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   
                   switch (state) {
                       case SSDKResponseStateSuccess:
                       {
                           [self showDoneAlertWithTitle:@"分享成功" msg:@"" done: nil cancel:nil];
                           break;
                           
                           
                       }
                       case SSDKResponseStateFail:
                       {
                           [self showDoneAlertWithTitle:@"分享失败"
                                                    msg:[NSString stringWithFormat:@"%@",error]
                                                   done:nil
                                                 cancel:nil];
                           break;
                       }
                       default:
                           break;
                   }
                   
               }];

}
@end
