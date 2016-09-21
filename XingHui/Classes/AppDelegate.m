//
//  AppDelegate.m
//  XingHui
//
//  Created by wangpei on 15/5/9.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "AppDelegate.h"
#import "XHBasicNavigationController.h"
#import "XHFoundViewControl.h"
#import "XHMeViewControl.h"
#import "AciMath.h"
#import "XHTabBarItem.h"
#import "XHLoginViewController.h"
#import "XHLeftViewController.h"
#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"
#import "Person.h"
#import "ChatListViewController.h"
#import "MainViewController.h"
#import "AppDelegate+EaseMob.h"
#import "UINavigationBar+BackgroundColor.h"
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "WXApi.h"
#import "WeiboSDK.h"
#import "XHStartViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
@interface AppDelegate ()
{
    BMKMapManager* _mapManager;
    XHBasicNavigationController *nav;
}
@end
@implementation AppDelegate
@synthesize tabVC;
@synthesize homeVC;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
       _connectionState = eEMConnectionConnected;

    [self easemobApplication:application didFinishLaunchingWithOptions:launchOptions];
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:@"GnX5IUPrTBreZfT92sPFrgwp"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        [self setStartVCAsRoot];
    }
    else
    {
        if ([JLCommonUtil isLogin]&&[JLCommonUtil getUserInfo]) {
            [self initMainVC];
            [XHDefaultUser sharedUser];
        }
        else
        {
            [self setLoginVCAsRoot];
        }
    }
    
    Class LSApplicationWorkspace_class = objc_getClass("LSApplicationWorkspace");
    NSObject* workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];
    NSLog(@"apps: %@", [workspace performSelector:@selector(allApplications)]);
    
    [self.window makeKeyAndVisible];
    return YES;
}
-(void)defaultWorkspace
{
    
}
-(void)allApplications
{
    
}
-(void)setStartVCAsRoot
{
    XHStartViewController *login =[[XHStartViewController alloc] init];
    nav = [[XHBasicNavigationController alloc] initWithRootViewController:login];
    self.window.rootViewController = nav;
}
-(void)setLoginVCAsRoot
{
    XHLoginViewController *login =[[XHLoginViewController alloc] init];
    nav = [[XHBasicNavigationController alloc] initWithRootViewController:login];
    self.window.rootViewController = nav;

}

-(void)initMainVC
{
    nav = nil;
    _mainController=nil;
    _mainController = [[MainViewController alloc] init];
    [_mainController networkChanged:_connectionState];
    nav = [[XHBasicNavigationController alloc] initWithRootViewController:_mainController];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    nav.navigationBarHidden = YES;
    nav.hidesBottomBarWhenPushed = YES;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0)
    {
        [[UINavigationBar appearance] xh_setBackgroundColor:[UIColor whiteColor]];
    }
    else
    {
        nav.navigationBar.barStyle = UIBarStyleDefault;
        [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"titleBar"]
                                forBarMetrics:UIBarMetricsDefault];
        [nav.navigationBar.layer setMasksToBounds:YES];
    }
   // nav = [[XHBasicNavigationController alloc] initWithRootViewController:tabVC];
    XHLeftViewController *left =[[XHLeftViewController alloc] init];
    left.delegate=_mainController;
    MMDrawerController *drawerController = [[MMDrawerController alloc]
                                            initWithCenterViewController:_mainController
                                            leftDrawerViewController:left
                                            rightDrawerViewController:nil];
    [drawerController setMaximumLeftDrawerWidth:280];
    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    drawerController.showsShadow=NO;
  
    [drawerController
     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
         MMDrawerControllerDrawerVisualStateBlock block;
         block = [MMDrawerVisualState swingingDoorVisualStateBlock];
         if(block){
             block(drawerController, drawerSide, percentVisible);
         }
     }];
    [drawerController setCenterHiddenInteractionMode:MMDrawerOpenCenterInteractionModeNavigationBarOnly];
    [self setShareSDK];
    self.window.rootViewController = drawerController;

}
-(void)setShareSDK
{
 
  
    [ShareSDK registerApp:@"b28def1e9b30"
          activePlatforms:@[@(SSDKPlatformTypeWechat)]
                 onImport:^(SSDKPlatformType platformType)
                                                         {
                 if (SSDKPlatformTypeWechat==platformType) {
                        [ShareSDKConnector connectWeChat:[WXApi class]];
                 }
         }
         onConfiguration:^(SSDKPlatformType type,NSMutableDictionary *dic){
                                                     switch (type) {
                                                         case SSDKPlatformTypeWechat:
                                                             [dic SSDKSetupWeChatByAppId:@"wx18acec0b224a248b" appSecret:@"6d9c13391a896852c6ba644bcd263039"];
                                                             break;
                                                             
                                                         default:
                                                             break;
                                                     }
     }];
                       
    
   }
//系统方法
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    //SDK方法调用
    [[EaseMob sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}
//系统方法
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    //SDK方法调用
    [[EaseMob sharedInstance] application:application didFailToRegisterForRemoteNotificationsWithError:error];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注册推送失败"
                                                    message:error.description
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}
//自定义方法
- (void)registerRemoteNotification
{
#if !TARGET_IPHONE_SIMULATOR
    UIApplication *application = [UIApplication sharedApplication];
    
    //iOS8 注册APNS
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        [application registerForRemoteNotifications];
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }else{
        UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeSound |
        UIRemoteNotificationTypeAlert;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
    }
    
#endif
}
//系统方法
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    //SDK方法调用
    [[EaseMob sharedInstance] application:application didReceiveRemoteNotification:userInfo];
}
//系统方法
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    //SDK方法调用
    [[EaseMob sharedInstance] application:application didReceiveLocalNotification:notification];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     [[EaseMob sharedInstance] applicationWillResignActive:application];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
      [[EaseMob sharedInstance] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
      [[EaseMob sharedInstance] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     [[EaseMob sharedInstance] applicationDidBecomeActive:application];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
     [[EaseMob sharedInstance] applicationWillTerminate:application];
}
@end
