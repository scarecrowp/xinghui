//
//  XHSelectAtVC.h
//  XingHui
//
//  Created by gaoyuerui on 15/11/10.
//  Copyright © 2015年 wangpei. All rights reserved.
//

#import "BasicViewController.h"

@interface XHSelectAtVC : BasicViewController
@property (nonatomic, strong) id<PassValueDelegate> passdelegate;
- (instancetype)initWithGroupId:(NSString *)chatGroupId;
@end
