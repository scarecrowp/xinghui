//
//  XHLoginViewController.m
//  XingHui
//
//  Created by wangpei on 15/5/26.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHLoginViewController.h"
#import "XHRegistViewController.h"
#import "XHForgetPswViewController.h"
#import "XHLeftViewController.h"
#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"
#import "UIViewController+MMDrawerController.h"
#import "XHNetWork.h"
#import "EaseMob.h"
@interface XHLoginViewController ()
{
    UITextField *tb_username;
    UITextField *tb_psw;
}
@end

@implementation XHLoginViewController
 
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *login_background=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [login_background setImage:[AciMath getLocationJpgImage:@"login_bg"]];
    [self.view addSubview:login_background];
    UITapGestureRecognizer *gest=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKayBoard)];
    [login_background addGestureRecognizer:gest];
    login_background.userInteractionEnabled=YES;
    UIImageView *logo =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo@3x"]];
    [logo setFrame:CGRectMake(0, 0, SCREEN_WIDTH*0.22, SCREEN_WIDTH*0.22)];
 
    logo.center=CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/5);
    [self.view addSubview:logo];
    UILabel *lb=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(logo.frame)+10, SCREEN_WIDTH, 50)];
    lb.text=@"严肃的高端商务社交平台";
    lb.textAlignment=NSTextAlignmentCenter;
    lb.textColor=[UIColor whiteColor];
    [self.view addSubview:lb];
    //用户名
    UIImageView *img_username=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/8+10, CGRectGetMaxY(lb.frame)+20, 23.33,23.33)];
    [img_username setImage:[UIImage imageNamed:@"username"]];
     tb_username =[[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(img_username.frame)+20, img_username.frame.origin.y-5, SCREEN_WIDTH*3/4-CGRectGetMaxX(img_username.frame)+20, 30)];

    tb_username.placeholder=@"请输入手机号";
    tb_username.keyboardType = UIKeyboardTypePhonePad;
    [tb_username setTextColor:[UIColor whiteColor]];
     [tb_username setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:img_username];
    [self.view addSubview:tb_username];
    UIImageView *img_line =[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/8, CGRectGetMaxY(tb_username.frame), SCREEN_WIDTH*3/4, 7)];
    [img_line setImage:[AciMath getScImage:@"login_line" top:0 bottom:0 left:4 right:4]];
    [self.view addSubview:img_line];
    
    //密码
    UIImageView *img_psw=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/8+10, CGRectGetMaxY(img_line.frame)+10, 23.33,23.33)];
    [img_psw setImage:[UIImage imageNamed:@"icon_password@3x"]];
     tb_psw =[[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(img_psw.frame)+20, img_psw.frame.origin.y-5, SCREEN_WIDTH*3/4-CGRectGetMaxX(img_psw.frame)+20, 30)];
    
    tb_psw.placeholder=@"请输入密码";
    [tb_psw setTextColor:[UIColor whiteColor]];
    tb_psw.secureTextEntry=YES;
    [tb_psw setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:img_psw];
    [self.view addSubview:tb_psw];
    UIImageView *img_line2 =[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/8, CGRectGetMaxY(tb_psw.frame), SCREEN_WIDTH*3/4, 7)];
    [img_line2 setImage:[AciMath getScImage:@"login_line" top:0 bottom:0 left:4 right:4]];
    [self.view addSubview:img_line2];
    UIButton *bt_submit=[AciMath getButtonWithScImg:@"bt_submit" rect:CGRectMake(20, 20, 24, 24) frame:CGRectMake(SCREEN_WIDTH/4, CGRectGetMaxY(img_line2.frame)+25, SCREEN_WIDTH/2, 40) event:@selector(login) target:self];
    [self.view addSubview:bt_submit];
    [bt_submit setTitle:@"登 陆" forState:UIControlStateNormal];
    
    UIButton *bt =[UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame =CGRectMake(SCREEN_WIDTH/2-60, SCREEN_HEIGHT-80, 60, 30);
    [bt.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bt setTitle:@"注册" forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(UserRegist) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *bt_findpsw =[UIButton buttonWithType:UIButtonTypeCustom];
    bt_findpsw.frame =CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT-80, 80, 30);
    [bt_findpsw.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [bt_findpsw setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bt_findpsw setTitle:@"找回密码" forState:UIControlStateNormal];
    [bt_findpsw addTarget:self action:@selector(findpsw) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bt];
    [self.view addSubview:bt_findpsw];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

-(void)login
{
    WS(ws);
    [self showHUD:@"正在登录"];
     NSString *url =[NSString stringWithFormat:@"%@login.ashx?name=%@&psw=%@",ServerURL,tb_username.text,tb_psw.text];
     XHNetWork *login =[[XHNetWork alloc] init];

    [login Login:url param:nil complete:^(NSDictionary *dic){
      
        if ([dic[@"result"] integerValue]==1) {
            [self hideHud];
            [JLCommonUtil saveUserInfo:[[dic objectForKey:@"content"] objectAtIndex:0]];
            [JLCommonUtil setLoginStatus:YES];
            [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:tb_username.text password:@"111111" completion:^(NSDictionary *loginInfo, EMError *error) {
                if (!error) {
                                          // 设置自动登录
                       [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
                }
             
                [ws.appdelegate initMainVC];

            } onQueue:nil];
        }
       else
       {
           
           [self showHUDin2s:dic[@"message"]];
       }
        //[self.navigationController popToRootViewControllerAnimated:YES];
    }];
}


-(void)findpsw
{
    XHForgetPswViewController *forget =[[XHForgetPswViewController alloc] init];
    [self.navigationController pushViewController:forget animated:YES];
}
-(void)UserRegist
{
    XHRegistViewController *rg=[[XHRegistViewController alloc] init];
    [self.navigationController pushViewController:rg animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end