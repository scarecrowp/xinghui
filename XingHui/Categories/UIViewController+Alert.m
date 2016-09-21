//
//  UIViewController+Alert.m
//  XingHui
//
//  Created by gaoyuerui on 15/11/30.
//  Copyright © 2015年 wangpei. All rights reserved.
//

#import "UIViewController+Alert.h"

@interface UIViewController ()

@end

@implementation UIViewController(Alert)
static char doneblockkey;
static char cancelblockkey;
-(void)setDoneblock:(DoneBlock)doneblock
{
     objc_setAssociatedObject(self, &doneblockkey, doneblock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (DoneBlock) getDoneblock
{
    return objc_getAssociatedObject(self, &doneblockkey);
}
- (void)setCancelblock:(CancelBlock)cancelblock
{
    objc_setAssociatedObject(self, &cancelblockkey, cancelblock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CancelBlock) getCancelblock
{
    return objc_getAssociatedObject(self, &cancelblockkey);
}

- (void)showDoneAlertWithTitle:(NSString *)title msg:(NSString *)msg done:(DoneBlock)done cancel:(CancelBlock)cancel
{
    [self setDoneblock:done];
    [self setCancelblock:cancel];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
    [alertView show];
}
- (void)showAlertWithTitle:(NSString *)title msg:(NSString *)msg done:(DoneBlock)done cancel:(CancelBlock)cancel
{
    [self setDoneblock:done];
    [self setCancelblock:cancel];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:@"取消",nil];
    [alertView show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        DoneBlock done = [self getDoneblock];
        if (done) {
             done();
        }
       
    }
    else
    {
        CancelBlock cancel =[self getCancelblock];
        if (cancel) {
            cancel();
        }
    }
 
}

@end
