/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import "UIViewController+HUD.h"
#import "MBProgressHUD.h"
#import <objc/runtime.h>

static const void *HttpRequestHUDKey = &HttpRequestHUDKey;

@implementation UIViewController (HUD)

- (MBProgressHUD *)HUD{
    return objc_getAssociatedObject(self, HttpRequestHUDKey);
}

- (void)setHUD:(MBProgressHUD *)HUD{
    objc_setAssociatedObject(self, HttpRequestHUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showHudInView:(UIView *)view hint:(NSString *)hint{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.labelText = hint;
    [view addSubview:HUD];
    [HUD show:YES];
    [self setHUD:HUD];
}

-(void)showHUD
{
    [self showHUD:@"加载中..."];
}
- (void)showHUDin2s:(NSString *)title
{
    [self showHint:title];
}
- (void)showHUD:(NSString *)title
{
    //  [self showHint:@"加载中..."];
    UIView *view = [[UIApplication sharedApplication].delegate window];
    if (![self HUD]) {
        [self setHUD:[[MBProgressHUD alloc] initWithView:view]];
    }
    [self HUD].labelText = title;
    [view addSubview:[self HUD]];
    [[self HUD] show:YES];
}
 
-(void)showHUDWithTitle:(NSString *)title
{
    
}
-(void)showHUDin2s:(NSString *)msg complete:(SEL)complete
{
    MBProgressHUD *HUD = [self HUD];
    if (HUD) {
        if (HUD.hidden) {
            HUD =[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        }
    }
    else
    {
        HUD =[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    HUD.labelText =msg;
    HUD.mode = MBProgressHUDModeCustomView;
    [HUD hide:YES afterDelay:2];
    [self performSelector:complete withObject:nil afterDelay:2];

}
- (void)showHint:(NSString *)hint
{
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud;
    if (![self HUD]) {
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        [self setHUD:hud];
    }
    else
    {
        hud =[self HUD];
    }
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.margin = 10.f;
    hud.yOffset = IS_IPHONE_5?200.f:150.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}
void RunBlockAfterDelay(NSTimeInterval delay, void (^block)(void))
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC*delay),
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0), block);
}

- (void)showHint:(NSString *)hint yOffset:(float)yOffset {
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.margin = 10.f;
    hud.yOffset = IS_IPHONE_5?200.f:150.f;
    hud.yOffset += yOffset;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
 
                    
}

- (void)hideHud{
    [[self HUD] hide:YES];
}

@end
