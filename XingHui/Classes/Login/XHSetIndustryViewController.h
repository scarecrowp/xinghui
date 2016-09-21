//
//  XHSetIndustryViewController.h
//  XingHui
//
//  Created by wangpei on 15/8/25.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PassValueDelegate;
@interface XHSetIndustryViewController : BasicViewController
@property(nonatomic,strong)id<PassValueDelegate>passdelegate;
@end
