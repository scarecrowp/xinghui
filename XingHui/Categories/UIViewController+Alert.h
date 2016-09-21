//
//  UIViewController+Alert.h
//  XingHui
//
//  Created by gaoyuerui on 15/11/30.
//  Copyright © 2015年 wangpei. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^DoneBlock)();
typedef void (^CancelBlock)();
@interface UIViewController(Alert)
-(void)showAlertWithTitle:(NSString *)title
                      msg:(NSString *)msg
                     done:(DoneBlock)done
                   cancel:(CancelBlock)cancel;
- (void)showDoneAlertWithTitle:(NSString *)title
                           msg:(NSString *)msg
                          done:(DoneBlock)done
                        cancel:(CancelBlock)cancel;
-(DoneBlock)getDoneblock;
-(void)setDoneblock:(DoneBlock)doneblock;
@end
