//
//  XHGatherWebViewController.m
//  XingHui
//
//  Created by gaoyuerui on 15/9/14.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHGatherWebViewController.h"
#import "GatherManage.h"

@interface XHGatherWebViewController ()<UIWebViewDelegate,GatherManageDelegate>
{
    MBProgressHUD *HUD;
    UIWebView *webview;
    GatherManage *gatherManage;
}
@property(nonatomic,strong)UIButton *bt_focus;
@property(nonatomic,strong)UIButton *bt_join;
@end

@implementation XHGatherWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:self.webtitle];
    gatherManage =[[GatherManage alloc] init];
    webview=[[UIWebView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:webview];
    NSString *url=[NSString BASEUrlString:[NSString stringWithFormat:@"pages/gather.aspx?id=%@",self.webUrl]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData]; //忽略本地缓存
    [webview loadRequest:request];
    webview.delegate=self;
    [self showHUD];

    UIView *bottom=[[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-64-50, SCREEN_WIDTH, 50)];
    [bottom setBackgroundColor:[UIColor whiteColor]];
    [bottom addSubview:self.bt_focus];
    [bottom addSubview:self.bt_join];
    [self.view addSubview:bottom];
    gatherManage.delegate=self;
    // Do any additional setup after loading the view.
}
-(UIButton *)bt_focus
{
    if (!_bt_focus) {
        _bt_focus =[[UIButton alloc] initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH/2-15, 40)];
        [_bt_focus setBackgroundImage:[AciMath getScImage:@"bt_focus_bg" top:0 bottom:0 left:20 right:20] forState:UIControlStateNormal];
        [_bt_focus setImage:[UIImage imageNamed:@"icon_focus@3x"] forState:UIControlStateNormal];
        _bt_focus.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 20);
        [_bt_focus setTitle:@"关注活动" forState:UIControlStateNormal];
        [_bt_focus setTitleColor:[AciMath getColor:@"ffffff"] forState:UIControlStateNormal];
        [_bt_focus addTarget:self action:@selector(focus) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bt_focus;
}
-(UIButton *)bt_join
{
    if (!_bt_join) {
        _bt_join=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+5, 5, SCREEN_WIDTH/2-15, 40)];
        [_bt_join setBackgroundImage:[AciMath getScImage:@"bt_join_bg" top:0 bottom:0 left:20 right:20] forState:UIControlStateNormal];
        [_bt_join setImage:[UIImage imageNamed:@"icon_join@3x"] forState:UIControlStateNormal];
        _bt_join.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 20);
        [_bt_join setTitle:@"报名参加" forState:UIControlStateNormal];
        [_bt_join setTitleColor:[AciMath getColor:@"ffffff"] forState:UIControlStateNormal];
        [_bt_join addTarget:self action:@selector(joinGather) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bt_join;
}
-(void)joinGather
{
    [self showHUD];
    [gatherManage join:self.webUrl];
}
-(void)focus
{
     [self showHUD];
    [gatherManage addFocus:self.webUrl];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self hideHud];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)didRequestSuccess:(NSDictionary *)obj
{
    [self showHUDin2s:@"操作成功"];
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
