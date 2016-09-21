//
//  NSString+Category.m
//  QiaoGu
//
//  Created by JackLiu on 14-8-27.
//  Copyright (c) 2014年 ZXInsight. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)

+ (NSString *)EncodingUTF8:(NSString *)string
{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)string, NULL, NULL,  kCFStringEncodingUTF8 ));
}

+ (NSString *) phonetic:(NSString*)sourceString {
    NSMutableString *source = [sourceString mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformStripDiacritics, NO);
    return  [source stringByReplacingOccurrencesOfString:@" " withString:@""];
}
+(NSString *)APIURLString:(NSString *)string
{
    return [NSString stringWithFormat:@"%@%@",ServerURL,string];
}

+(NSString *)BASEUrlString:(NSString *)string
{
    return [NSString stringWithFormat:@"%@%@",BaseServerURL,string];
}
+(NSString *)PicUrlString:(NSString *)string
{
    if (!string) {
        return @"";
    }
    if ([[string ToString] isEqualToString:@""]) {
        return @"";
    }
    string=[string substringFromIndex:3];
    return [NSString stringWithFormat:@"%@%@",BaseServerURL,string];
}
+(NSString *)PicUrlString2:(NSString *)string
{
    string=[string substringFromIndex:3];
    return [NSString stringWithFormat:@"%@%@",BaseServerURL,string];
}
@end
@implementation NSObject (StringCategory)
-(NSString *)ToString
{
    if (self) {
        if ([self isEqual:[NSNull null]]) {
            return @"";
        }
        return [NSString stringWithFormat:@"%@",self];
    }else{
        return @"";
    }
}
@end
