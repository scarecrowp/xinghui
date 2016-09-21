//
//  XHCreateJobHistory.h
//  XingHui
//
//  Created by wangpei on 15/8/24.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHCreateJobHistory : BasicViewController
@property (weak, nonatomic) IBOutlet UITextView *lb_job_not;
@property (weak, nonatomic) IBOutlet UITextView *txt_bg;
@property (weak, nonatomic) IBOutlet UITextField *tb_comName;
@property (weak, nonatomic) IBOutlet UITextField *tb_position;
@property (weak, nonatomic) IBOutlet UIButton *bt_jobTime;
@property (nonatomic,strong) NSDictionary *jobDic;
@property(nonatomic,strong)id<PassValueDelegate>passdelegate;
- (IBAction)editJObTime:(id)sender;
- (IBAction)DidSave:(id)sender;

@end
