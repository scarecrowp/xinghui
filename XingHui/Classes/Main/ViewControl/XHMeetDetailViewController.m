//
//  XHMeetDetailViewController.m
//  XingHui
//
//  Created by wangpei on 15/6/10.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//
#import "XHMapViewController.h"
#import "XHMeetDetailViewController.h"
#import "XHSegmented.h"
#import "XHUserJoinCell.h"
#import "XHGathercell.h"
#import "XHGather.h"
#import "UIImageView+WebCache.h"
#import "XHEmptyView.h"
#import "XHWebViewController.h"
#import "XHGatherWebViewController.h"
#import "GatherManage.h"
#import "XHPersonDetailViewController.h"
#import "ChatViewController.h"
#import "GatherHead.h"

#import "XHAddFriendVC.h"
#import "UIViewController+Alert.h"
#import "UIViewController+Share.h"
@interface XHMeetDetailViewController ()<XHSegmentedDelegate,UITableViewDataSource,UITableViewDelegate,GatherManageDelegate,UserCellDelegagte,GatherHeadDelegate>
{
    UIScrollView *scrollview;
    NSInteger selectSegIndex;
    XHSegmented *seg;
    XHGather *gather;
    GatherManage *gatherManage;
    NSMutableArray *focusArr;
}
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)UIView *view_bottom;
@end

@implementation XHMeetDetailViewController
-(instancetype)initWithGather:(XHGather *)gt
{
    self=[super init];
    gather=gt;
    focusArr =[NSMutableArray new];
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self initValue];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
     gatherManage.delegate=nil;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     gatherManage.delegate=self;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initValue
{
    gatherManage = [GatherManage new];
 
    

}
-(void)rightButtonAction
{
 
    [self shareContent:gather.title
             imgUrlStr:gather.img
              shareUrl:[NSURL URLWithString:[NSString stringWithFormat:@"%@?gid=%@",WapUrl(@"gatherdetail.aspx"),gather.gid]]
                 title:gather.title];
}
#pragma mark - GatherManageDelegate
-(void)didGetComment:(NSDictionary *)dic
{
    [_tableview.mj_header endRefreshing];
    gather.joiner=dic[@"joins"];
    focusArr=dic[@"focus"];
    gather.commentArr=dic[@"comment"];
    [scrollview setContentSize:CGSizeMake(SCREEN_WIDTH, seg.maxY+ gather.joiner.count*60)];
    [_tableview reloadData];
}
#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 
    switch (selectSegIndex) {
        case 0: return gather.joiner.count;;break;
        case 1:return focusArr.count;break;
        case 2:return 0;
     }
     
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (selectSegIndex) {
        case 0:
        {
            XHUserJoinCell *cell= [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"XHUserJoinCell"]];
            if (!cell) {
                cell=[[XHUserJoinCell alloc] initWithGather:[gather.joiner objectAtIndex:indexPath.row]];
                cell.delegate=self;
            }
            return cell;

        }
            break;
           case 1:
        {
            XHUserJoinCell *cell= [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"XHUserJoinCell"]];
            if (!cell) {
                cell=[[XHUserJoinCell alloc] initWithGather:[focusArr objectAtIndex:indexPath.row]];
                cell.delegate=self;
            }
            return cell;
        };break;
            case 2:
        {
            XHGathercell *cell =[tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"XHGathercell"]];
            if (!cell) {
                cell=[[XHGathercell alloc] initWithGather:nil];
            }
            return cell;

        }
        default:
            break;
    }
    return [UITableViewCell new];
 
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  59;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    
    if (selectSegIndex==0) {
 
        if (gather.joiner.count==0) {
            UIView *empty=[[XHEmptyView alloc] init];
            return empty;
        }

    }
    if (selectSegIndex==1) {
 
        if (focusArr.count==0) {
            UIView *empty=[[XHEmptyView new] init];
            return empty;
        }

    }
    if (selectSegIndex==2) {
 
            UIView *empty=[[XHEmptyView new] init];
            return empty;
        
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
 
    
    if (selectSegIndex==0) {
        
        if (gather.joiner.count==0) {
 
            return [[XHEmptyView new] init].frame.size.height;
        }
        
    }
    if (selectSegIndex==1) {
        
        if (focusArr.count==0) {
            return [[XHEmptyView new] init].frame.size.height;
        }
        
    }
    if (selectSegIndex==2) {
        
        return [[XHEmptyView new] init].frame.size.height;
        
    }

    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (selectSegIndex==0) {
        XHPersonDetailViewController *detail=[XHPersonDetailViewController new];
        detail.user=[[XHUser alloc] initWithDic:[gather.joiner objectAtIndex:indexPath.row]];
        [self.navigationController pushViewController:detail animated:YES];
    }
    else if (selectSegIndex==1)
    {
        XHPersonDetailViewController *detail=[XHPersonDetailViewController new];
        detail.user=[[XHUser alloc] initWithDic:[focusArr objectAtIndex:indexPath.row]];
        [self.navigationController pushViewController:detail animated:YES];

    }
}
#pragma mark -

#pragma mark -  action
-(void)toCompInfo
{
    XHWebViewController *webview=[[XHWebViewController alloc] init];
    webview.webtitle=gather.creater.userRealName;
    webview.webUrl=[NSString BASEUrlString:[NSString stringWithFormat:@"pages/cominfo.aspx?id=%@",gather.creater.uid]];
    [self.navigationController pushViewController:webview animated:YES];
}
-(void)toMap
{
    XHMapViewController *map = [[XHMapViewController alloc] initWithLocation:gather.gpsCoordinate];
    [self.navigationController pushViewController:map animated:YES];
}
-(void)GETJoinFocusComment
{
    _tableview.delegate=self;
    _tableview.dataSource=self;
    [gatherManage getGatherComment:gather.gid page:1];
}
-(void)JoinIn:(NSString *)gid
{
     [self showHUD];
    [gatherManage join:gid];
}

-(void)Addfocus:(NSString *)gid
{
    [self showHUD];
    [[XHNetWork sharedNetWork] Post:[NSString stringWithFormat:@"%@addfocus.ashx",ServerURL]
                         parameters:@{@"gid":gather.gid}
                           complete:^(NSDictionary *dic){
                               [self showHint:dic[@"message"]];
                               
                               [seg setSelectSeg:1];
                               selectSegIndex =1;
                               focusArr=dic[@"focus"];
                               gather.joiner=dic[@"join"];
                               [_tableview reloadData];
                           } errorMsg:^(NSString *msg){
                               [self showHint:@"关注失败"];
                           }];

}
#pragma mark -
#pragma mark - GatherManageDelegate
-(void)didRequestSuccess:(NSDictionary *)obj
{
    [self showHint:@"操作成功"];
    gather.joiner=obj[@"join"];
    focusArr = obj[@"focus"];
    [seg setSelectSeg:0];
      selectSegIndex=0;
    [_tableview.mj_header endRefreshing];
    [_tableview reloadData];
 
}
-(void)ToUserDetail:(XHUser *)user
{
    XHPersonDetailViewController *detail =[[XHPersonDetailViewController alloc] init];
    detail.user=user;
    [self.navigationController pushViewController:detail animated:YES];
}
-(void)ChatWithUser:(XHUser *)user
{
    ChatViewController *chatVC = [[ChatViewController alloc] initWithChatter:user.tell isGroup:NO];
    [chatVC setRealName:user.userRealName];
    [self.navigationController pushViewController:chatVC animated:YES];
}
-(void)addFriend:(NSString *)username realName:(NSString *)realName
{
    XHAddFriendVC *Addfriend = [[XHAddFriendVC alloc] init];
    Addfriend.username =username;
    Addfriend.userRealname = realName;
    [self.navigationController pushViewController:Addfriend animated:YES];
//    NSString *buddyName =username;
//    if (buddyName && buddyName.length > 0) {
//        [self showHudInView:self.view hint:NSLocalizedString(@"friend.sendApply", @"sending application...")];
//        EMError *error;
//        [[EaseMob sharedInstance].chatManager addBuddy:buddyName message:msg error:&error];
//        [self hideHud];
//        if (error) {
//            [self showHint:NSLocalizedString(@"friend.sendApplyFail", @"send application fails, please operate again")];
//        }
//        else{
//            [self showHint:NSLocalizedString(@"friend.sendApplySuccess", @"send successfully")];
//          //  [self.navigationController popViewControllerAnimated:YES];
//        }
//    }

}
-(void)SegmentClickDelegateWithIndex:(NSInteger)index
{
    selectSegIndex=index;
    [self.tableview reloadData];
}
-(void)EnterMeeting
{
    XHGatherWebViewController   *webview=[[XHGatherWebViewController alloc] init];
    webview.webUrl=gather.gid;
    webview.webtitle=gather.title;
    [self.navigationController pushViewController:webview animated:YES];
}
#pragma mark -

#pragma  mark-  get set
-(void)initView
{
    [self setTitle:@"活动详情"];
    [self.view setBackgroundColor:Color(@"FFFFFF")];
    [self.rightButton setImage:[UIImage imageNamed:@"gather_right_bt"] forState:UIControlStateNormal];
    scrollview= [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
 
 
 
    GatherHead *ghead=[[GatherHead alloc] initWithGather:gather];
    ghead.delegate=self;
 //   [ghead addTarget:self action:@selector(toCompInfo)];
    
    [scrollview addSubview:ghead];
    seg =[[XHSegmented alloc] initWithTitle:[NSArray arrayWithObjects:@"参与的用户",@"关注的用户",@"相关的聚会", nil]];
    seg.delegate=self;
    CGRect rect=seg.frame;
    rect.origin.y=ghead.maxY;
    seg.frame=rect;
    [scrollview addSubview:seg];
    [scrollview addSubview:self.tableview];
    [scrollview setContentSize:CGSizeMake(SCREEN_WIDTH, seg.maxY+_tableview.contentSize.height)];
    [self.view addSubview:scrollview];
    //  [self.view addSubview:self.tableview];
    [self.view addSubview:self.view_bottom];
}
-(UITableView *)tableview
{
    if (!_tableview) {
        _tableview=[[UITableView alloc] initWithFrame:CGRectMake(0,seg.maxY, SCREEN_WIDTH, SCREEN_HEIGHT-seg.maxY) style:UITableViewStylePlain];
      //  _tableview.tableHeaderView =self.tableHeadView;
 
        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
        _tableview.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(GETJoinFocusComment)];
        _tableview.delegate=self;
        _tableview.dataSource=self;
      [_tableview.header beginRefreshing];
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        _tableview.tableFooterView=view;

    }
    return _tableview;

}
-(UIView *)view_bottom
{
    if (!_view_bottom) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];   //保存
        _view_bottom=[[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50-64, SCREEN_WIDTH, 50)];
        [button setBackgroundColor:[UIColor whiteColor]];
        button.frame = CGRectMake(7, 0,SCREEN_WIDTH-14, 43);
        [button setTitle:@"进入活动" forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor ColorWithHexString:@"2ebe00"]];
        
        [button addTarget:self action:@selector(EnterMeeting) forControlEvents:UIControlEventTouchUpInside];
        [_view_bottom addSubview:button];

    }
    return _view_bottom;
}

@end
