//
//  XHHomeViewController.m
//  XingHui
//
//  Created by wangpei on 15/5/9.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHHomeViewController.h"
#import "XHHomeTableView.h"
#import "XHLeftViewController.h"
#import "MMDrawerController.h"
#import "XHSetUpViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "XHMeetDetailViewController.h"
#import "XHGather.h"
#import <BaiduMapAPI_Location/BMKLocationComponent.h>

#import "XHGatherDetailViewController.h"
#import "GatherManage.h"
#import "XHGatherSearchVC.h"
#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>

@interface XHHomeViewController ()<ZXRightDelegate,BMKLocationServiceDelegate,XHHomeTableViewDelegate,BMKGeneralDelegate,BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate,GatherManageDelegate>
{
    XHHomeTableView *homeTable;
    BOOL isFirstLoadMap;
    BMKUserLocation *location;
    BMKLocationService *locService;
    BMKMapManager* _mapManager;
    CLLocationCoordinate2D _coordinate2D;
    NSString * _currentLocationName;    //当前位置
    UIButton * _locationButton; //当前地址
    BMKGeoCodeSearch * _searcher;  //反地理编码
    int page;
    MMDrawerController *drawerCV;
    GatherManage *gatherManage;
}

@end

@implementation XHHomeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"幸会"];
    gatherManage=[GatherManage new];
    [self.rightButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    
    locService = [[BMKLocationService alloc] init];
    
    [locService setDelegate:self];
    [self.leftButton setImage:[UIImage imageNamed:@"home_left_menu"] forState:UIControlStateNormal];
    homeTable =[[XHHomeTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-49)];
    homeTable.homedelegate=self;
    [self.view addSubview:homeTable];
    homeTable.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)] ;
 
    homeTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getGather)];
    isFirstLoadMap=YES;
   
     drawerCV=self.tabBarController.mm_drawerController;
 
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [locService startUserLocationService];
     gatherManage.delegate=self;
    [homeTable.mj_header beginRefreshing];
    [drawerCV setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    gatherManage.delegate=nil;
     [drawerCV setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
}
-(void)rightButtonAction
{
    XHGatherSearchVC *gatherVC = [[XHGatherSearchVC alloc] init];
    gatherVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:gatherVC animated:YES];
}
-(void)refreshData
{
    page=0;
    [gatherManage getTotalGather:page];
}
-(void)getGather
{
    page++;
    [gatherManage getTotalGather:page];
}
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
   
     if (isFirstLoadMap) {
        [XHDefaultUser sharedUser].coordinate=userLocation.location.coordinate;
         [self reverseGeocode:location.location.coordinate];
         location =userLocation;
         [homeTable reloadData];
         //上传当前位置到服务器
         [[XHNetWork sharedNetWork] uploadLBS:[NSString stringWithFormat:@"%.14f",location.location.coordinate.latitude ]
                                          lon:[NSString stringWithFormat:@"%.14f",location.location.coordinate.longitude]];
        isFirstLoadMap=NO;
    }
    
}

- (void)updateLocationFailWithError:(NSError *)error
{
 
  //  [self hideHud];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)leftButtonAction
{
  
   
    XHLeftViewController *left=(XHLeftViewController *)drawerCV.leftDrawerViewController;
    
    [left reloadData];
    [drawerCV toggleDrawerSide:MMDrawerSideLeft animated:YES completion:^(BOOL isfinis){
        if (isfinis) {
            
            //  [self.rightButton setImage:[UIImage imageNamed:@"get_out-640p"] forState:UIControlStateNormal];
            //  [self.rightButton setImage:[UIImage imageNamed:@"get_out_dark-640p"] forState:UIControlStateHighlighted];
        }
    }];
}
-(void)didViewControlTransfor:(UIViewController *)controll
{
    controll.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:controll animated:YES];
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
#pragma mark -
#pragma mark BMKLocationServiceDelegate
 
#pragma mark -反地理位置信息
- (void)reverseGeocode:(CLLocationCoordinate2D)coordinate
{
    //发起反向地理编码检索
    _searcher =[[BMKGeoCodeSearch alloc]init];
    _searcher.delegate = self;
    CLLocationCoordinate2D pt = coordinate;
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_searcher reverseGeoCode:reverseGeoCodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
}

- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    NSMutableDictionary *addressDictionary = [NSMutableDictionary new];
    
    [addressDictionary setObject:[NSString stringWithFormat:@"%f",result.location.latitude] forKey:@"latitude"];
    [addressDictionary setObject:[NSString stringWithFormat:@"%f",result.location.longitude] forKey:@"longitude"];
    
    NSString *address = result.address;
    NSLog(@"%@",address);
    
    [[NSUserDefaults standardUserDefaults] setValue:address forKey:@"current_location"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [_locationButton setTitle:address forState:UIControlStateNormal];
}

@end
