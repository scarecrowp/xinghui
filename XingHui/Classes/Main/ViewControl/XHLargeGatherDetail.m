//
//  XHLargeGatherDetail.m
//  XingHui
//
//  Created by wangpei on 15/8/21.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHLargeGatherDetail.h"

@interface XHLargeGatherDetail ()
{
    UIWebView *webview;
}
@end

@implementation XHLargeGatherDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_WIDTH-64-50)];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString APIURLString:@"gatherdetail.aspx"]]];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData]; //忽略本地缓存
    [webview loadRequest:request];
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
