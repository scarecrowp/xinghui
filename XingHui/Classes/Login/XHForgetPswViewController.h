//
//  XHForgetPswViewController.h
//  XingHui
//
//  Created by wangpei on 15/6/5.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHForgetPswViewController : BasicViewController
@property (weak, nonatomic) IBOutlet UITextField *tb_tell;
@property (weak, nonatomic) IBOutlet UITextField *tb_code;
@property (weak, nonatomic) IBOutlet UITextField *tb_newpsw;
@property (weak, nonatomic) IBOutlet UIButton *bt_sendCode;
- (IBAction)SendCode:(id)sender;
- (IBAction)submit:(id)sender;
@end
