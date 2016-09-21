//
//  AppDelegate.h
//  XingHui
//
//  Created by wangpei on 15/5/9.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMNetworkMonitorDefs.h"
#import "ApplyViewController.h"
#import "MainViewController.h"
@class XHHomeViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
     EMConnectionState _connectionState;
}
@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong)UITabBarController *tabVC;
@property(nonatomic,strong)XHHomeViewController *homeVC;
@property (strong, nonatomic)MainViewController *mainController;
-(void)setLoginVCAsRoot;
-(void)initMainVC;
@end

