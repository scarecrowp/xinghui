//
//  UIDevice+Category.m
//  QiaoGu
//
//  Created by JackLiu on 14-8-7.
//  Copyright (c) 2014年 ZXInsight. All rights reserved.
//

#import "UIDevice+Category.h"

@implementation UIDevice (Category)

+ (BOOL)isIOS7
{
    CGFloat version = [[[UIDevice currentDevice]systemVersion]intValue];
    
    if (version>=7)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (BOOL)isIphone5Or5s
{
    CGFloat version = [[[UIDevice currentDevice]systemVersion]intValue];
    CGFloat screenHeight = [[UIScreen mainScreen]bounds].size.height;
    
    if (version>=7 && screenHeight==568)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (BOOL)isIphone4Or4s
{
    CGFloat version = [[[UIDevice currentDevice]systemVersion]intValue];
    CGFloat screenHeight = [[UIScreen mainScreen]bounds].size.height;
    
    if (version<7 && screenHeight==480)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

@end
