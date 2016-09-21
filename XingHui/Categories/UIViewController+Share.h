//
//  UIViewController+Share.h
//  XingHui
//
//  Created by gaoyuerui on 15/12/1.
//  Copyright © 2015年 wangpei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController(Share)
-(void)shareContent:(NSString *)content imgUrlStr:(NSString *)imgUrl shareUrl:(NSURL *)shareUrl title:(NSString *)title;
@end
