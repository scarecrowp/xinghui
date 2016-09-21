//
//  XHForgetPswViewController.m
//  XingHui
//
//  Created by wangpei on 15/6/5.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHForgetPswViewController.h"

@interface XHForgetPswViewController ()
{
    NSString *sCode;
}
@end

@implementation XHForgetPswViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"重置密码"];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)SendCode:(id)sender {
    if (_tb_tell.text.length==0) {
        [self showHUDin2s:@"请输入手机号"];
        return;
    }
    else
    {
        if (_tb_tell.text.length!=11) {
            [self showHUDin2s:@"手机号格式不正确"];
            return;
        }
    }
    [[XHNetWork sharedNetWork] Get:[NSString APIURLString:@"sendmsg.ashx"] param:@{@"tell":_tb_tell.text} complete:^(NSDictionary *dic){
        sCode=dic[@"code"];
        [self setTime:60];
    }];

}
-(void)setTime:(int)ti
{
    [_bt_sendCode setBackgroundColor:[UIColor lightGrayColor]];
    if (ti!=0) {
        [_bt_sendCode setUserInteractionEnabled:NO];
        __block int timeout=ti;
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            if(timeout<=0){ //倒计时结束，关闭
                dispatch_source_cancel(_timer);
                // dispatch_release(_timer);
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    [_bt_sendCode setTitle:@"获取验证码" forState:UIControlStateNormal];
                    [_bt_sendCode setUserInteractionEnabled:YES];
                });
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    [_bt_sendCode setTitle:[NSString stringWithFormat:@"%d",timeout] forState:UIControlStateNormal];
                    [_bt_sendCode setBackgroundColor:[AciMath getColor:@"51AF0D"]];
                });
                timeout--;
                
            }
        });
        dispatch_resume(_timer);
    }
    
}

- (IBAction)submit:(id)sender {
    [self hideKayBoard];
    if ([_tb_code.text isEqualToString:sCode]) {
        [[XHNetWork sharedNetWork] Get:[NSString APIURLString:@"resetpsw.ashx"] param:@{@"psw":_tb_newpsw.text,@"tell":_tb_tell.text} complete:^(NSDictionary *dic){
//            [self showHUDin2s:@"重置成功" complete:^(void){
//              //[self.appdelegate setLoginVCAsRoot];
//            }];
            [self showHUDin2s:@"重置成功" complete:@selector(leftButtonAction)];
           // [self.appdelegate setLoginVCAsRoot];
        }];
    }
    else
    {
        [self showHUDin2s:@"验证码错误"];
    }
  
}
@end
