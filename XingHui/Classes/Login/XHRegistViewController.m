//
//  XHRegistViewController.m
//  XingHui
//
//  Created by wangpei on 15/5/28.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHRegistViewController.h"
#import "XHSetPassWordViewController.h"
@interface XHRegistViewController ()

@end

@implementation XHRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[AciMath getColor:@"F0F0F0"]];
    [self.navigationController setNavigationBarHidden:NO];
    [self setTitle:@"注册新用户"];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)nextStep:(id)sender {
    if(_tb_tell.text.length!=11)
    {
        [self showHUDin2s:@"手机号码格式不正确"];
        return;
    }
    XHSetPassWordViewController *setpass = [[XHSetPassWordViewController alloc] init];
    [XHDefaultUser sharedUser].tell = _tb_tell.text;
    [XHDefaultUser sharedUser].username = _tb_tell.text;
    [self.navigationController pushViewController:setpass animated:YES];
}
@end
