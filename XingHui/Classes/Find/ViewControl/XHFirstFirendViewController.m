	//
//  XHFirstFirendViewController.m
//  XingHui
//
//  Created by wangpei on 15/6/1.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHFirstFirendViewController.h"
#import "ChineseToPinyin.h"
#import "LKDBHelper.h"
#import "Person.h"
#import "OneFriendCell.h"
#import "ChatViewController.h"
#import "UserManager.h"
#import "XHPersonDetailViewController.h"
#import "XHInvitationViewController.h"
@interface XHFirstFirendViewController ()

@end

@implementation XHFirstFirendViewController

- (void)viewDidLoad {
    self.friendType = kFirstFriend;
    [super viewDidLoad];
    [self setTitle:@"一度好友管理"];
    
    UIView *bottom_view=[[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-55-64, SCREEN_WIDTH, 55)];
    UIButton *bt_addFriend=[[UIButton alloc] initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH-20, 45)];
    [bt_addFriend setBackgroundColor:[AciMath getColor:@"2ebe00"]];
    [bt_addFriend setTitle:@"邀请好友" forState:UIControlStateNormal];
    [bt_addFriend addTarget:self action:@selector(addFriend)];
    [bottom_view addSubview:bt_addFriend];  
}

- (void)addFriend
{
    XHInvitationViewController *invitation = [[XHInvitationViewController alloc] init];
    [self.navigationController pushViewController:invitation animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
