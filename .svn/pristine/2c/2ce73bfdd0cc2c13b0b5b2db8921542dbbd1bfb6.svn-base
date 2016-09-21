//
//  AppContext.h
//  EvenTouch
//
//  Created by Jack Liu on 14-5-9.
//  Copyright (c) 2014年 Jack Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IOSVersion [[UIDevice currentDevice]systemVersion].floatValue

#define SCREEN_RECT [[UIScreen mainScreen]bounds]

#define SCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width

#define SCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height
#define IS_IPHONE_5 [[UIScreen mainScreen ]bounds].size.height == 568
#define IS_IPHONE_4 [[UIScreen mainScreen ]bounds].size.height == 480

//#define KEYWINDOW [UIApplication sharedApplication].keyWindow
#define KEYWINDOW [[[UIApplication sharedApplication]windows]objectAtIndex:0]
#define IOS7 [[[UIDevice currentDevice] systemVersion]floatValue]>=7


@interface JLAppContext : NSObject

+ (void)initialize;

/*
 根据key取接口地址
 */
+ (NSString *) getServiceUrl:(NSString *) serviceKey;

@end
