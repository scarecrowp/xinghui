//
//  XHPersonDetailViewController.h
//  XingHui
//
//  Created by wangpei on 15/8/23.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XHUser;
@interface XHPersonDetailViewController : BasicViewController
@property(nonatomic,strong)XHUser *user;
-(instancetype)initWithUserID:(NSString *)userName;
@end
