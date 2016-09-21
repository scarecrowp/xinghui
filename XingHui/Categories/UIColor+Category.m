//
//  UIColor+JLColorUtil.m
//  EvenTouch
//
//  Created by Jack Liu on 14-5-14.
//  Copyright (c) 2014年 Jack Liu. All rights reserved.
//

#import "UIColor+Category.h"

@implementation UIColor (Category)

+(UIColor *)ColorWithHexString:(NSString *)hexColor
{
    unsigned int red, green, blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:1.0f];
}

@end
