//
//  XHUserTagViewController.h
//  XingHui
//
//  Created by gaoyuerui on 15/10/12.
//  Copyright © 2015年 wangpei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PassValueDelegate;
@interface XHUserTagViewController : BasicViewController
@property(nonatomic,strong)id<PassValueDelegate> passdelegate;
@property(nonatomic,strong)NSString *touid;
@end
