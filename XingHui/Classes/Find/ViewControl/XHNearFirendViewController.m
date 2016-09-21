//
//  XHNearFirendViewController.m
//  XingHui
//
//  Created by wangpei on 15/6/1.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHNearFirendViewController.h"
#import "UserManager.h"
@interface XHNearFirendViewController ()

@end

@implementation XHNearFirendViewController

- (void)viewDidLoad {
    self.friendType = kNearFriend;
    [super viewDidLoad];
    [self setTitle:@"附近的好友"];
 
    // Do any additional setup after loading the view.
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
