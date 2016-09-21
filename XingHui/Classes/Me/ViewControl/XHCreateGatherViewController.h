//
//  XHCreateGatherViewController.h
//  XingHui
//
//  Created by gaoyuerui on 15/6/7.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XHSetPicViewController.h"
@interface XHCreateGatherViewController : XHSetPicViewController<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *baseview;
- (IBAction)selectBeginTime:(id)sender;
- (IBAction)selectEndTime:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lb_begintime;
@property (weak, nonatomic) IBOutlet UILabel *lb_endtime;
@property (weak, nonatomic) IBOutlet UILabel *lb_paytype;
@property (weak, nonatomic) IBOutlet UILabel *lb_tips;
- (IBAction)selectPic:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lb_personnum;

- (IBAction)selectGatherType:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lb_gatherType;
@property (weak, nonatomic) IBOutlet UILabel *lb_biggather;
- (IBAction)chosePayType:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *tb_personNum;
- (IBAction)chosePlace:(id)sender;
- (IBAction)selectGather:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lb_place;
@property (weak, nonatomic) IBOutlet UITextView *tb_info;
@property (weak, nonatomic) IBOutlet UISwitch *sw_open;
- (IBAction)swChangeValue:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *sw_friendOnly;
- (IBAction)HiddenKeyBoard:(id)sender;
- (IBAction)submit:(id)sender;
@end
