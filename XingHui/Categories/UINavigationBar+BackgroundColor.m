//
//  UINavigationBar.m
//  XingHui
//
//  Created by wangpei on 15/9/1.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "UINavigationBar+BackgroundColor.h"
static char overlayKey;
@implementation UINavigationBar(BackgroundColor)

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (UIView *)overlay
{    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIView *)overlay
{
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)xh_setBackgroundColor:(UIColor *)backgroundColor
{    if (!self.overlay) {
    [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self setShadowImage:[UIImage new]];        // insert an overlay into the view hierarchy
    self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, 64)];
    [self insertSubview:self.overlay atIndex:0];
}    self.overlay.backgroundColor = backgroundColor;
}
@end
