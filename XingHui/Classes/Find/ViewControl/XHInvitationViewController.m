//
//  XHInvitationViewController.m
//  XingHui
//
//  Created by gaoyuerui on 15/9/28.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHInvitationViewController.h"
#import "UserManager.h"
@interface XHInvitationViewController ()

@end

@implementation XHInvitationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"邀请好友"];
    self.VcType=4;
    [[UserManager share] Invitationfriend:^(NSMutableArray *arr){
        self.friendArr=arr;
        // friendArr=  [self sortDataArray:friendArr];
        [self tableReload];
    }];
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
