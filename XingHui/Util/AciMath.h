//
//  AciMath.h
//  car_30
//
//  Created by user on 12-4-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface AciMath : NSObject

+(UIColor *)getColor:(NSString *)hexColor;
+(NSString *)md5:(NSString *)str;
+(UIImage *)getScImage:(NSString *)imgName
                   top:(CGFloat)top bottom:(CGFloat)bottom left:(CGFloat)left right:(CGFloat)right;
+(UIButton *)getButtonWithImage:(NSString *)imagename frame:(CGRect)frame event:(SEL)action target:(id)target;
+(UIImage *)getLocationJpgImage:(NSString *)name;
+(UIImage *)getLocationPngImage:(NSString *)name;
+ (NSString *)getStringFromDate:(NSDate *)date withFormat:(NSString *)format;
+(UIToolbar *)getKeybordToolbar:(id)target action:(SEL)action;
+(UIButton *)getButtonWithScImg:(NSString *)name rect:(CGRect)rect  frame:(CGRect)frame event:(SEL)action target:(id)target;
+(NSInteger)getDateDay;
+(NSDate *)getDate:(NSString *)str;
+(int)getRandomNumber:(int)from to:(int)to;
@end