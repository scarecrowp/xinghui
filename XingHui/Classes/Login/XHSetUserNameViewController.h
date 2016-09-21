 //
//  XHSetUserNameViewController.h
//  XingHui
//
//  Created by wangpei on 15/5/29.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHSetUserNameViewController : BasicViewController<UITextFieldDelegate>
- (IBAction)sextStep:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lb_birthday;
- (IBAction)select_birthday:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *tb_name;
@property (weak, nonatomic) IBOutlet UITextField *tb_company;
@property (weak, nonatomic) IBOutlet UITextField *tb_job;
@property (weak, nonatomic) IBOutlet UITextField *tb_direct;
@property (strong, nonatomic) IBOutlet UIView *datepicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
- (IBAction)hideKeybord:(id)sender;
- (IBAction)setSex:(id)sender;
- (IBAction)cancelAction:(id)sender;
- (IBAction)doneAction:(id)sender;

- (IBAction)select_industry:(id)sender;
 
@end
