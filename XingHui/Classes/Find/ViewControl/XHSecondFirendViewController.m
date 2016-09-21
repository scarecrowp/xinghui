//
//  XHSecondFirendViewController.m
//  XingHui
//
//  Created by wangpei on 15/6/1.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHSecondFirendViewController.h"
#import "UserManager.h"
@interface XHSecondFirendViewController ()

@end

@implementation XHSecondFirendViewController

- (void)viewDidLoad {
    self.friendType = kSecondFriend;
    [super viewDidLoad];
    
    [self setTitle:@"二度好友"];
    self.VcType=2;

   
   
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
