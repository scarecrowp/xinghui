	//
//  XHFriendViewController.m
//  XingHui
//
//  Created by gaoyuerui on 15/9/17.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHFriendViewController.h"
#import "UserManager.h"
#import "OneFriendCell.h"
#import "XHPersonDetailViewController.h"
#import "XHEmptyView.h"
#import "RealtimeSearchUtil.h"
#import "EMSearchDisplayController.h"
#import "EMSearchBar.h"
#import "XHSearchViewController.h"
#import "JKAlertDialog.h"
#import "CYLTableViewPlaceHolder.h"
@interface XHFriendViewController ()<UITableViewDataSource,UITableViewDelegate,OneFriendDelegate>
{
   
    //LKDBHelper *dbhelper;
    //Class *cellclass;
    int page;
    
}
@property (strong, nonatomic) EMSearchDisplayController *searchController;
@property(nonatomic,strong) UISearchBar *searchbar;
@end

@implementation XHFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:Color(@"F0F0F0")];
    [self.rightButton setImage:[UIImage imageNamed:@"bt_search"] forState:UIControlStateNormal];
    self.tableview =[[UITableView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshAction)] ;
    [self.tableview.mj_header beginRefreshing];
    
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    [self.view addSubview:self.tableview];
    self.tableview.tableFooterView=[UIView new];
    self.friendArr =[NSMutableArray new];
    [self showHUD:@"初始化好友"];
    [self.tableview.mj_header beginRefreshing];
//    
 

}

- (void)rightButtonAction
{
    XHSearchViewController *searVC = [[XHSearchViewController alloc] init];
    [self.navigationController pushViewController:searVC animated:YES];
}
-(void)refreshAction
{
    
   [[UserManager share] getFriendWithParam:@{@"page":@(page),@"type":@(_friendType)}  complete:^(NSMutableArray *arr){
        self.friendArr=arr;
      
        [self tableReload];
 
        [self hideHud];
       
       if (arr.count<20) {
           [self.tableview.mj_footer endRefreshingWithNoMoreData];
       }
       else
       {
             page++;
       }
        [self.tableview.mj_header endRefreshing];
    }];
}
-(void)loadMore
{
    [[UserManager share] getFriendWithParam:@{@"page":@(page),@"type":@(_friendType)}  complete:^(NSMutableArray *arr){
       
        [self.friendArr addObjectsFromArray:arr];
        [self tableReload];
        if (arr.count<20) {
            [self.tableview.mj_footer endRefreshingWithNoMoreData];
        }
        else
        {
             page++;
             [self.tableview.mj_footer endRefreshing];
        }
       
        // [self.tableview.mj_footer endRefreshingWithNoMoreData];
    }];
    
}
-(void)invited:(NSString *)username tell:(NSString *)tell
{
    JKAlertDialog *alert = [[JKAlertDialog alloc]initWithTitle:@"邀请好友" message:@""];
    UITextView *tv_invited = [[UITextView alloc] initWithFrame:CGRectMake(5, 5, alert.frame.size.width-10, 100)];
    NSString *msg =[NSString stringWithFormat:@"%@:您的好友%@邀请您加入幸会，快来看看有什么好玩的吧！http://fir.im/xinghui 进入下载",username, [XHDefaultUser sharedUser].userRealName];
    tv_invited.text=msg;
    alert.contentView =  tv_invited;
    [alert addButtonWithTitle:@"取消"];
    
    [alert addButton:Button_OTHER withTitle:@"发送" handler:^(JKAlertDialogItem *item) {
        [[XHNetWork sharedNetWork] Post:[NSString APIURLString:@"invited.ashx"] parameters:@{@"msg":msg,@"tell":tell} complete:^(NSDictionary *dic){
            [self showHUDin2s:@"发生成功"];
        }];
        
    }];;
    
    [alert show];

}
- (NSString *)showName
{
    return @"aa";
}
- (void)tableReload
{
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    [self.tableview reloadData];
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 74;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.friendArr.count;
}
///
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    OneFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[OneFriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    XHUser *person =[self.friendArr objectAtIndex:indexPath.row];
    switch (_friendType) {
        case kFirstFriend:{
            [cell setData:person];
            cell.delegate=self;
            break;
        }
        case kSecondFriend:[cell setSecondData:person];break;
        case kNearFriend:[cell setNearData:person];break;
        case kInvitationFriend:[cell setInvitionData:person];break;
            
        default:
        {[cell setData:person];
            cell.delegate=self;}
            break;
    }
    return cell;
}
///
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return  1;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.friendArr.count==0) {
        UIView *empty=[[XHEmptyView alloc] init];
        return empty;
    }
    
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.friendArr.count==0) {
        return [[XHEmptyView alloc] init].frame.size.height;
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    //        EMBuddy *buddy = [[friendArr objectAtIndex:(indexPath.section - 1)] objectAtIndex:indexPath.row];
    //        NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
    //        NSString *loginUsername = [loginInfo objectForKey:kSDKUsername];
    //        if (loginUsername && loginUsername.length > 0) {
    //            if ([loginUsername isEqualToString:buddy.username]) {
    //                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"friend.notChatSelf", @"can't talk to yourself") delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
    //                [alertView show];
    //
    //                return;
    //            }
    //        }
    //
    //        ChatViewController *chatVC = [[ChatViewController alloc] initWithChatter:buddy.username isGroup:NO];
    //        chatVC.title = buddy.username;
    //        [self.navigationController pushViewController:chatVC animated:YES];
    XHPersonDetailViewController *detail=[[XHPersonDetailViewController alloc] init];
    detail.user=[self.friendArr objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
    
    
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
