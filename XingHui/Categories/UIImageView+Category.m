//
//  UIImageView+Category.m
//  XingHui
//
//  Created by wangpei on 15/8/5.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "UIImageView+Category.h"
#import "UIImage+Category.h"
@implementation UIImageView(Category)
-(void)setTarget:(id)target action:(SEL)action
{
    self.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:tap];
}
-(void)setImageFromString:(NSString *)str
{
    [self setImage:[UIImage imageFromString:str size:self.frame.size]];
    [self setBackgroundColor:[AciMath getColor:@"7595f1"]];
    self.contentMode=UIViewContentModeCenter;
}
-(void)setImageFromString:(NSString *)str fontsize:(float)fontsize paddintTop:(float)paddingTop
{
    if (str.length>1) {
        str=[str substringToIndex:1];
    }
    [self setImage:[UIImage imageFromString:str size:self.frame.size fontsize:fontsize top:paddingTop]];
    [self setBackgroundColor:[AciMath getColor:@"7595f1"]];
    self.contentMode=UIViewContentModeCenter;
}
@end
