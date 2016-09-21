//
//  XHTabBarItem.m
//  XingHui
//
//  Created by wangpei on 15/5/25.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHTabBarItem.h"

@implementation XHTabBarItem
-(id)initWithTitle:(NSString *)title image:(NSString *)image tag:(NSInteger)tag selectImg:(NSString *)selectImg
{
    self=[super initWithTitle:title image:[UIImage imageNamed:image] tag:tag];
    if (self) {
        UIImage *imageIcon = [[UIImage imageNamed: selectImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor ColorWithHexString:@"1573ff"],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
        self.selectedImage =imageIcon;

    }
    return self;
}
@end
