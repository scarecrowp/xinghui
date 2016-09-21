//
//  XHSetUserNameViewController.m
//  XingHui
//
//  Created by wangpei on 15/5/29.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHSetUserNameViewController.h"
#import "XHUploadPhonebookViewController.h"
#import "XHSetIndustryViewController.h"
@interface XHSetUserNameViewController ()<UITextFieldDelegate,PassValueDelegate>
{
    NSString *sex;
 
}
@end

@implementation XHSetUserNameViewController
@synthesize datePicker;
- (void)viewDidLoad {
    [super viewDidLoad];
    sex=@"1";
    [self.view setBackgroundColor:[AciMath getColor:@"F0F0F0"]];
    [self setTitle:@"个人资料"];
    _tb_direct.delegate=self;
    _tb_job.delegate=self;
    [_lb_birthday addTarget:self action:@selector(setBrithday)];
 
    [_datepicker setFrame:CGRectMake(0, SCREEN_HEIGHT-162-64-44, SCREEN_WIDTH, 162+44)];
    datePicker.backgroundColor = Color(@"ffffff");
    [datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    [datePicker setDate:[AciMath getDate:@"1986/01/01 00:00:00"]];
    _datepicker.hidden=YES;
    NSDate* minDate = [AciMath getDate:@"1900/01/01 00:00:00"];
    
    NSDate* maxDate = [AciMath getDate:@"2015/01/01 00:00:00"];;
    
    datePicker.minimumDate = minDate;
    
    datePicker.maximumDate = maxDate;
    [self.view addSubview:_datepicker];
    UIToolbar *toolsbar =[AciMath getKeybordToolbar:self action:@selector(hideKeybord:)];
    _tb_name.inputAccessoryView = toolsbar;
    _tb_company.inputAccessoryView = toolsbar;
    _tb_job.inputAccessoryView =toolsbar;
    // Do any additional setup after loading the view from its nib.
}
-(void)setBrithday
{
   }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 
-(void)hideDelayed
{
    XHSetIndustryViewController *ind = [[XHSetIndustryViewController alloc] init];
    ind.passdelegate=self;
    [self.navigationController pushViewController:ind animated:YES];

}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
 
    if (textField ==_tb_direct) {
          [self hideKeybord:nil];
        [self hideDelayed];
        return YES;
    }
    
    if (self.view.frame.origin.x<0) {
        return YES;
    }
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0,-200+64,self.view.frame.size.width,self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
  
    return YES;
}
//-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
//{
//    
////    NSTimeInterval animationDuration = 0.30f;
////    //[UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
////    [UIView setAnimationDuration:animationDuration];
////    
////    CGRect rect = CGRectMake(0.0,64,self.view.frame.size.width,self.view.frame.size.height);
////    self.view.frame =rect;
////    [UIView commitAnimations];return YES;
//}
- (IBAction)sextStep:(id)sender {
    XHUploadPhonebookViewController *upload =[[XHUploadPhonebookViewController alloc] init];
    [XHDefaultUser sharedUser].industry=_tb_direct.text;
    [XHDefaultUser sharedUser].job=_tb_job.text;
    [XHDefaultUser sharedUser].username=_tb_name.text;
    [XHDefaultUser sharedUser].company=_tb_company.text;
    [XHDefaultUser sharedUser].birthday=_lb_birthday.text;
    [XHDefaultUser sharedUser].sex=sex;
    [self.navigationController pushViewController:upload animated:YES];
}
- (IBAction)select_birthday:(id)sender {
    _datepicker.hidden=NO;

}
- (IBAction)hideKeybord:(id)sender {
    if (self.view.frame.origin.y<0) {
        NSTimeInterval animationDuration = 0.30f;
        //[UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationDuration:animationDuration];
    
        CGRect rect = CGRectMake(0.0,64,self.view.frame.size.width,self.view.frame.size.height);
        self.view.frame =rect;
        
        [UIView commitAnimations];
    }
    [_tb_company resignFirstResponder];
    [_tb_direct resignFirstResponder];
    [_tb_job resignFirstResponder];
    [_tb_name resignFirstResponder];
}

- (IBAction)setSex:(id)sender {
    UIButton *bt=(UIButton *)sender;
    sex=[NSString stringWithFormat:@"%ld",(long)bt.tag];
    [bt setImage:[UIImage imageNamed:@"sex_select@3x"] forState:UIControlStateNormal];
    UIButton *bt_o=(UIButton *)[self.view viewWithTag:(3-bt.tag)];
    [bt_o setImage:[UIImage imageNamed:@"sex_unselect@3x"] forState:UIControlStateNormal];

}

- (IBAction)cancelAction:(id)sender {
     _datepicker.hidden=YES;
}

- (IBAction)doneAction:(id)sender {
    NSDate *select = [datePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateAndTime =  [dateFormatter stringFromDate:select];
    _lb_birthday.text = dateAndTime;
     _datepicker.hidden=YES;
}
-(void)passbackObject:(id)object sender:(NSString *)sender
{
    NSDictionary *dic=object;
    _tb_direct.text=[NSString stringWithFormat:@"%@ %@",dic[@"name1"],dic[@"name2"]];
}

- (IBAction)select_industry:(id)sender {
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self hideKeybord:nil];
}
@end
