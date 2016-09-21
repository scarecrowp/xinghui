//
//  XHSetUpViewController.h
//  XingHui
//
//  Created by wangpei on 15/6/5.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHSetPicViewController.h"
@interface XHSetUpViewController : XHSetPicViewController
@property (strong, nonatomic) IBOutlet UIView *view_base;
@property (strong, nonatomic) IBOutlet UIView *view_other;
@property (strong, nonatomic) IBOutlet UIView *view_connect;
@property (weak, nonatomic) IBOutlet UIImageView *img_head;
@property (weak, nonatomic) IBOutlet UITextField *lb_name;
@property (weak, nonatomic) IBOutlet UILabel *lb_sex;
@property (weak, nonatomic) IBOutlet UILabel *lb_industry;
- (IBAction)HIDDENKEYBOARD:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *lb_com;
@property (weak, nonatomic) IBOutlet UITextField *lb_job;
@property (weak, nonatomic) IBOutlet UILabel *lb_jobhistory;
@property (weak, nonatomic) IBOutlet UILabel *lb_tag;
@property (weak, nonatomic) IBOutlet UILabel *lb_study;
@property (weak, nonatomic) IBOutlet UITextField *tb_mail;
@property (weak, nonatomic) IBOutlet UITextField *tb_wechat;
@property (weak, nonatomic) IBOutlet UITextField *tb_QQ;

@end
