//
//  XHNearGatheringViewController.m
//  XingHui
//
//  Created by wangpei on 15/6/1.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHNearGatheringViewController.h"
#import "XHHomeTableView.h"
#import "GatherManage.h"
#import "XHGather.h"
#import "XHMeetDetailViewController.h"
#import "XHGatherDetailViewController.h"
@interface XHNearGatheringViewController ()<GatherManageDelegate,XHHomeTableViewDelegate>
{
    XHHomeTableView *homeTable;
    int page;
    GatherManage *gatherManage;
}
@end

@implementation XHNearGatheringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"附近的聚会"];
    gatherManage = [[GatherManage alloc] init];
    homeTable =[[XHHomeTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    homeTable.homedelegate=self;
    [self.view addSubview:homeTable];
    homeTable.mj_header=[MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)] ;
    
    homeTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getGather)];
    gatherManage.delegate=self;
    [self getGather];
}
-(void)refreshData
{
    page=1;
    [gatherManage getNearGather:page];
}
-(void)getGather
{
    page++;
    [gatherManage getNearGather:page];
}
#pragma mark gathermanageDelegate
-(void)didGetDather:(NSMutableArray *)gatherarr
{
    
    [homeTable.mj_header endRefreshing];
    if ([gatherarr count]<20) {
        [homeTable setMj_footer:nil];
    }
    [homeTable storeArr:gatherarr ];
    [homeTable reloadData];
}
-(void)seletegather:(NSDictionary *)gatherDic
{
    
    XHGather *gather=[[XHGather alloc] initWithDic:gatherDic];
    if (gather.type!=2) {
        XHMeetDetailViewController *detail=[[XHMeetDetailViewController alloc] initWithGather:gather];
        
        detail.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:detail animated:YES];
    }
    else
    {
        XHGatherDetailViewController *detail=[[XHGatherDetailViewController alloc] init];
        detail.gather=gather;
        detail.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:detail animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
