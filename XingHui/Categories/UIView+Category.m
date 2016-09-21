//
//  UIView+Category.m
//  XingHui
//
//  Created by wangpei on 15/7/23.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//
#import "UIView+Category.h"
static char XHVIEW_HEIGHT;
static char XHVIEW_maxX;
static char XHVIEW_maxY;

@implementation UIView(Category)

-(float)minY
{//you hen duo de sha bi .zuii da de shi wo zijzi
    /*
        laoban shi shiab ,zenmen ban ,ta jiushi sha bi chun shabi yige 
     what can i du
     */
     return self.frame.origin.y;
}
-(void)setMaxY:(float)maxY
{
    objc_setAssociatedObject(self, &XHVIEW_maxY,@(maxY), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(float)maxY
{
    
    float hei=[objc_getAssociatedObject(self, &XHVIEW_maxY) floatValue];
    if (hei) {
        
        return hei;
    }
    else
    {
        return  CGRectGetMaxY(self.frame);
    }
}

-(float)minX
{
    return CGRectGetMidX(self.frame);
}
//-(float)maxX
//{
//    return CGRectGetMaxX(self.frame);
//}
-(void)setMaxX:(float)maxX
{
     objc_setAssociatedObject(self, &XHVIEW_maxX,@(maxX), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(float)maxX
{
    float hei=[objc_getAssociatedObject(self, &XHVIEW_maxX) floatValue];
    if (hei) {
        return hei;
    }
    else
    {
        return  CGRectGetMaxX(self.frame);
    }

}
#pragma 属性
-(void)setHeight:(float)height
{
   
    objc_setAssociatedObject(self, &XHVIEW_HEIGHT,@(height), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    CGRect rect=self.frame;
    rect.size.height=height;
    [self setFrame:rect];
}
-(float)height
{
    float hei=[objc_getAssociatedObject(self, &XHVIEW_HEIGHT) floatValue];
    if (hei) {
        return hei;
    }
    else
    {
        return self.frame.size.height;
    }
}
-(void)addTarget:(id)target action:(SEL)action
{
    self.userInteractionEnabled=YES;
    UITapGestureRecognizer *gest =[[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:gest];
}
@end

