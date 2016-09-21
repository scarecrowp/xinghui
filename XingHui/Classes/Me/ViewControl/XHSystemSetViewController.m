//
//  XHSystemSetViewController.m
//  XingHui
//
//  Created by wangpei on 15/8/26.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHSystemSetViewController.h"
#import "XHLoginViewController.h"
#import "ApplyViewController.h"
@interface XHSystemSetViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation XHSystemSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"系统设置"];
   // [self.view setBackgroundColor:[UIColor whiteColor]];
    UITableView *tableview=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    tableview.delegate=self;
    UIView *view=[UIView new];
 
    tableview.tableFooterView=view;
    tableview.dataSource=self;
    [self.view addSubview:tableview];
    if(self.navigationController.navigationBarHidden)
    {
        [self.navigationController setNavigationBarHidden:NO];
    }
    // Do any additional setup after loading the view from its nib.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0: return 4; break;
        case 1: return 2; break;
        case 2: return 1; break;
        default: break;
    }
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                {
                    cell.textLabel.text=@"新消息通知";
                    UISwitch *swich1=[[UISwitch alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-80, 5, 80, 35)];
                    [cell addSubview:swich1];
                    break;
                }
                case 1:
                {
                    cell.textLabel.text=@"声音";
                    UISwitch *swich1=[[UISwitch alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-80, 5, 80, 35)];
                    [cell addSubview:swich1];
                    break;
                }
                case 2:
                {
                    cell.textLabel.text=@"震动";
                    UISwitch *swich1=[[UISwitch alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-80, 5, 80, 35)];
                    [cell addSubview:swich1];
                    break;
                }
                    case 3:
                {
                    cell.textLabel.text=@"夜间免打扰";
                    break;
                }
                default:
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                {
                    cell.textLabel.text=@"字体大小";
                    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                    break;
                }
                    case 1:
                {
                    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                    cell.textLabel.text=@"关于我们";
                    break;
                }
                default:
                    break;
            }
            break;
        case 2:
            cell.textLabel.text=@"退出登陆";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            break;
        default:
            break;
    }
    return cell;
    
}

#pragma mark -s

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.section) {
        case 2:
        {
             [self showHudInView:self.view hint:NSLocalizedString(@"setting.logoutOngoing", @"loging out...")];
             __weak XHSystemSetViewController *weakSelf = self;
            [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
                [weakSelf hideHud];
                if (error && error.errorCode != EMErrorServerNotLogin) {
                    [weakSelf showHint:error.description];
                }
                else{
                    [[ApplyViewController shareController] clear];
                    [XHDefaultUser clearUser];
                    XHLoginViewController *login=[[XHLoginViewController alloc] init];
                    
                    self.view.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:login];
                  //  [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
                }
            } onQueue:nil];
           
            break;
        }
        default:
            break;
    }
}

-(double)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 10;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
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
