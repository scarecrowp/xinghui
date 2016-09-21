//
//  XHRegistViewController.h
//  XingHui
//
//  Created by wangpei on 15/5/28.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHRegistViewController : BasicViewController
- (IBAction)nextStep:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *tb_tell;

@end
