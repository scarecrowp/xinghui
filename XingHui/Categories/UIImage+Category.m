//
//  UIImageView+Category.m
//  QiaoGuShop
//
//  Created by wangpei on 15/7/15.
//  Copyright (c) 2015年 QiaoGu. All rights reserved.
//
#define CONTENT_MAX_WIDTH   300.0f
#import "UIImage+Category.h"

@implementation UIImage(Category)
+(UIImage *)imageFromText:(NSString *)sContent withFont:(CGFloat)fontSize withTextColor:(UIColor *)textColor withBgImage:(UIImage *)bgImage withBgColor:(UIColor *)bgColor
{
    // set the font type and size
    
    UIFont *font = [UIFont boldSystemFontOfSize:fontSize];
 
    
    CGFloat fHeight = 0.0f;
    CGSize stringSize= [sContent boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
  //  CGSize stringSize = [sContent sizeWithFont:font constrainedToSize:CGSizeMake(CONTENT_MAX_WIDTH, 10000) lineBreakMode:NSLineBreakByWordWrapping];
 
    
    fHeight = stringSize.height;
    
    
    CGSize newSize = CGSizeMake(CONTENT_MAX_WIDTH+20, fHeight+50);
    
    
    // Create a stretchable image for the top of the background and draw it
    UIGraphicsBeginImageContextWithOptions(newSize,NO,0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    
    //如果设置了背景图片
    if(bgImage)
    {
        UIImage* stretchedTopImage = [bgImage stretchableImageWithLeftCapWidth:0 topCapHeight:0];
        [stretchedTopImage drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    }else
    {
        if(bgColor)
        {
            //填充背景颜色
            [bgColor set];
            UIRectFill(CGRectMake(0, 0, newSize.width, newSize.height));
        }
    }
    
    CGContextSetCharacterSpacing(ctx, 10);
    CGContextSetTextDrawingMode (ctx, kCGTextFill);
    [textColor set];
 
    CGFloat fPosY = 20.0f;
    CGRect rect = CGRectMake(10, fPosY, CONTENT_MAX_WIDTH , fHeight);
    [sContent drawInRect:rect withAttributes:[self setAttributesWithFontSize:30 WithTextColor:[UIColor grayColor] WithAlignment:NSTextAlignmentCenter]];
 
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
}
+ (UIImage *)imageFromString:(NSString *)string  size:(CGSize)size fontsize:(float)fontsize top:(float)top
{
    // };
    if (string.length>1) {
        string=[string substringToIndex:1];
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    /// Set line break mode
    paragraphStyle.lineBreakMode = NSLineBreakByClipping;
    /// Set text alignment
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont boldSystemFontOfSize:fontsize],
                                  NSParagraphStyleAttributeName: paragraphStyle,
                                  NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width, size.height), NO, 0);
    [string drawInRect:CGRectMake(0, top,size.width,size.height) withAttributes:attributes];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;

}
+ (UIImage *)imageFromString:(NSString *)string  size:(CGSize)size
{
    return  [UIImage imageFromString:string size:size fontsize:20 top:5];
   
}
+(NSDictionary *)setAttributesWithFontSize:(NSInteger)size WithTextColor:(UIColor *)color WithAlignment:(NSTextAlignment)alignment
{
    NSMutableParagraphStyle *paragraphStyle= [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = alignment;
    NSDictionary *attributes= [NSDictionary dictionaryWithObjectsAndKeys:
                               [UIFont systemFontOfSize:size], NSFontAttributeName,
                               paragraphStyle,NSParagraphStyleAttributeName,color,NSForegroundColorAttributeName,[UIColor blackColor],NSStrokeColorAttributeName,[NSNumber numberWithFloat:2.0],NSStrokeWidthAttributeName,nil];
    return attributes;
}

@end
