//
//  XHSetPassWordViewController.m
//  XingHui
//
//  Created by wangpei on 15/5/29.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHSetPassWordViewController.h"
#import "XHSetUserNameViewController.h"
@interface XHSetPassWordViewController ()
{
    NSString *sCode;
}
@end

@implementation XHSetPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"设置密码"];
    [self.view setBackgroundColor:[AciMath getColor:@"F0F0F0"]];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getCode:(id)sender {
    sCode =[NSString stringWithFormat:@"%d",[AciMath getRandomNumber:1000 to:9999]];
    NSLog(sCode);
    NSString *strMsg = [NSString stringWithFormat:@"您的验证码是：%@",sCode];
    NSDictionary *dic = @{@"account":@"VIP_ymxx",
                            @"pswd":@"Yuemia703",
                          @"mobile":[XHDefaultUser sharedUser].username,
                             @"msg":strMsg};
    [[XHNetWork sharedNetWork] Post:@"http://222.73.117.158:80/msg/HttpBatchSendSM"
                             parameters:dic
                          complete:^(NSDictionary *dic){
                              [self setTime:60];
                          } errorMsg:^(NSString *are){
                             [self setTime:60];
                          }];
 
}
-(void)setTime:(int)ti
{
    [_bt_getcode setBackgroundColor:[UIColor lightGrayColor]];
    if (ti!=0) {
        [_bt_getcode setUserInteractionEnabled:NO];
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
                    [self bottomInit];
                });
            }else{
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    [_bt_getcode setTitle:[NSString stringWithFormat:@"%d",timeout] forState:UIControlStateNormal];
                    [_bt_getcode setBackgroundColor:[AciMath getColor:@"cccccc"]];
                });
                timeout--;
                
            }
        });
        dispatch_resume(_timer);
    }
    
}
-(void)bottomInit
{
    [_bt_getcode setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_bt_getcode setBackgroundColor:Color(@"51AF0D")];
    [_bt_getcode setUserInteractionEnabled:YES];
    
}
- (IBAction)nextStep:(id)sender {
  
   
        if (_tb_code.text.length==0) {
            [self showHUDin2s:@"请输入短信验证码"];
            return;
        }
        else
        {
            if (![sCode isEqualToString:_tb_code.text]) {
                [self showHUDin2s:@"验证码错误"];
                return;
            }
            
        }
        if (_tb_password.text.length==0) {
            [self showHUDin2s:@"请输入密码"];
            return;
        }

    
    
    XHSetUserNameViewController *vc=[[XHSetUserNameViewController alloc] init];
    [XHDefaultUser sharedUser].psw=_tb_password.text;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
