//
//  XHSetPassWordViewController.h
//  XingHui
//
//  Created by wangpei on 15/5/29.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHSetPassWordViewController : BasicViewController
- (IBAction)getCode:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *bt_getcode;
@property (weak, nonatomic) IBOutlet UITextField *tb_code;
@property (weak, nonatomic) IBOutlet UITextField *tb_password;
- (IBAction)nextStep:(id)sender;

@end
