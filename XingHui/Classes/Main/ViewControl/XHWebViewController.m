//
//  XHWebViewController.m
//  XingHui
//
//  Created by wangpei on 15/8/26.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHWebViewController.h"

@interface XHWebViewController ()<UIWebViewDelegate>
{
    MBProgressHUD *HUD;
    UIWebView *webview;
//    NSString *webtitle;
}

@end

@implementation XHWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:self.webtitle];
    webview=[[UIWebView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:webview];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData]; //忽略本地缓存
    [webview loadRequest:request];
    webview.delegate=self;
    [self showHUD];
    //HUD=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // Do any additional setup after loading the view.
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self hideHud];
    if ([self.webtitle isEqualToString:@""]) {
        NSString *theTitle=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
        [self setTitle:theTitle];
    }
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
