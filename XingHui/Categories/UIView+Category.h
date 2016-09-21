//
//  UIView+Category.h
//  XingHui
//
//  Created by wangpei on 15/7/23.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIView(Category)
-(float)minX;
-(float)maxX;
-(float)minY;
-(float)maxY;
@property float minX;
@property float minY;
@property float maxX;
@property float maxY;
@property float height;
-(void)addTarget:(id)target action:(SEL)action;
@end
