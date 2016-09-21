//
//  AciMath.m
//  car_30
//
//  Created by user on 12-4-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AciMath.h"
#import <CommonCrypto/CommonDigest.h>
@implementation AciMath

+(UIColor *)getColor:(NSString *)hexColor
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
+(NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
+(UIImage *)getScImage:(NSString *)imgName
                   top:(CGFloat)top bottom:(CGFloat)bottom left:(CGFloat)left right:(CGFloat)right{
    UIImage *image2 = [UIImage imageNamed:imgName];
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    image2 = [image2 resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeTile];
    return image2;
}
+(UIButton *)getButtonWithImage:(NSString *)imagename frame:(CGRect)frame event:(SEL)action target:(id)target
{
    UIButton *bt =  [UIButton buttonWithType:UIButtonTypeCustom];
    [bt setFrame:frame];
    if (![imagename isEqualToString:@""]) {
        // [bt setBackgroundImage:[UIImage imageNamed:] forState:UIControlStateNormal];
        NSString *path3 = [[NSBundle mainBundle] pathForResource:imagename ofType:@"png"];
        // UIImageView *img3 =[[UIImageView alloc ]initWithImage:[UIImage imageWithContentsOfFile:path3]];Refresh_btn
        
        [bt setImage:[UIImage imageWithContentsOfFile:path3] forState:UIControlStateNormal];
        
    }
    
    [bt addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return bt;
}
+(UIButton *)getButtonWithScImg:(NSString *)name rect:(CGRect)rect  frame:(CGRect)frame event:(SEL)action target:(id)target
{
    UIButton *bt =  [UIButton buttonWithType:UIButtonTypeCustom];
    [bt setFrame:frame];
    if (![name isEqualToString:@""]) {
        [bt setBackgroundImage:[AciMath getScImage:name top:rect.origin.x bottom:rect.origin.y left:rect.size.width right:rect.size.height] forState:UIControlStateSelected];
        [bt setBackgroundImage:[AciMath getScImage:name top:rect.origin.x bottom:rect.origin.y left:rect.size.width right:rect.size.height] forState:UIControlStateNormal];
        
    }
    
    [bt addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return bt;
}
+(UIImage *)getLocationJpgImage:(NSString *)name
{
    return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:@"jpg"]];
}
+(UIToolbar *)getKeybordToolbar:(id)target action:(SEL)action
{
    UIToolbar * topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    [topView setBarStyle:UIBarStyleDefault];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:target action:action];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace, doneButton, nil];
    
    [topView setItems:buttonsArray];
    return topView;
}
+(UIToolbar *)getKeybordTextFeilToolbar:(id)target action:(SEL)action
{
    UIToolbar * topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    [topView setBarStyle:UIBarStyleDefault];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:target action:action];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace, doneButton, nil];
    
    [topView setItems:buttonsArray];
    return topView;
}
+(UIImage *)getLocationPngImage:(NSString *)name
{
    return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:@"png"]];
}
+ (NSString *)getStringFromDate:(NSDate *)date withFormat:(NSString *)format
{
    //yyyy-MM-dd HH:mm:ss
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}
+(NSInteger)getDateDay
{
    NSDate *date=[NSDate new];
    NSCalendar*calendar = [NSCalendar currentCalendar];
    NSDateComponents*comps;
    
    // 年月日获得
    comps =[calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |NSDayCalendarUnit)
                       fromDate:date];
    return comps.day;
}
+(NSDate *)getDate:(NSString *)str
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init] ;
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    return [dateFormat dateFromString:str];
}
+(int)getRandomNumber:(int)from to:(int)to

{
    
    return (int)(from + (arc4random() % (to-from+ 1)));
    
}
@end
