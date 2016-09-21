//
//  UIImageView+Category.h
//  XingHui
//
//  Created by wangpei on 15/8/5.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImageView(Category)
-(void)setTarget:(id)target action:(SEL)action;
-(void)setImageFromString:(NSString *)str;
-(void)setImageFromString:(NSString *)str fontsize:(float)fontsize paddintTop:(float)paddingTop;
@end
