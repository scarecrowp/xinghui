//
//  UIImageView+Category.h
//  QiaoGuShop
//
//  Created by wangpei on 15/7/15.
//  Copyright (c) 2015年 QiaoGu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage(Category)
+(UIImage *)imageFromText:(NSString *)sContent withFont:(CGFloat)fontSize withTextColor:(UIColor *)textColor withBgImage:(UIImage *)bgImage withBgColor:(UIColor *)bgColor;
+ (UIImage *)imageFromString:(NSString *)string size:(CGSize)size;
+ (UIImage *)imageFromString:(NSString *)string  size:(CGSize)size fontsize:(float)fontsize top:(float)top;
@end
