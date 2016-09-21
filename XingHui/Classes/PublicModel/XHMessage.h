//
//  XHMessage.h
//  XingHui
//
//  Created by wangpei on 15/6/9.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHMessage : NSObject
@property(nonatomic,strong)NSString *userHead;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *time;
@property(nonatomic,strong)NSString *msgInfo;
@property int messageTpe;
@end
