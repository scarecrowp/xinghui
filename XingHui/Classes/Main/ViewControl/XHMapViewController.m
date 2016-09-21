//
//  XHMapViewController.m
//  XingHui
//
//  Created by gaoyuerui on 15/11/17.
//  Copyright © 2015年 wangpei. All rights reserved.
//

#import "XHMapViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#define BaiduMapKey @"tarXZ0MdsCZqIsalbw8N1Tzm"
#import "XHWebViewController.h"
@interface XHMapViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate>
{
    BMKMapView *_mapView;
    BMKLocationService *_locService;
    BMKAnnotationView *newAnnotation;
    CLLocationCoordinate2D _currentSelectCoordinate;
    BMKMapManager* _mapManager;
    BOOL alreadyZoom;
}
@end

@implementation XHMapViewController
-(instancetype)initWithLocation:(CLLocationCoordinate2D)location
{
    self = [super init];
    if (self) {
        _currentSelectCoordinate = location;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"地图"];
    [self.rightButton setTitle:@"导航" forState:UIControlStateNormal];
    
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:BaiduMapKey generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    [self.leftButton setImage:[UIImage imageNamed:@"ios_back_btn_click"] forState:UIControlStateHighlighted];
    [self.rightButton setImage:[UIImage imageNamed:@"gps_btn"] forState:UIControlStateNormal];
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT)];
    self.view =_mapView;
    _mapView.delegate =self;
    UIButton *bt=[UIButton buttonWithType:UIButtonTypeCustom];
    [bt setImage:[UIImage imageNamed:@"定位"] forState:UIControlStateNormal];
    [bt setFrame:CGRectMake(250, SCREEN_HEIGHT-120, 50, 50)];
    
    [bt addTarget:self action:@selector(changeMode) forControlEvents:UIControlEventTouchUpInside];
    //指定最小距离更新(米)，默认：kCLDistanceFilterNone
    // [BMKLocationServicesetLocationDistanceFilter:100.f];
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    [_locService startUserLocationService];
  
    [self.view addSubview:bt];
 
    _locService.delegate = self;
    [_mapView setZoomLevel:19];//设置地图缩放级别

}
-(void)viewDidAppear:(BOOL)animated
{
    
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    annotation.coordinate = _currentSelectCoordinate;
    annotation.title = self.titleLabel.text;
    [_mapView addAnnotation:annotation];
}
- (void)onGetNetworkState:(int)iError
{
    if (0 == iError)
    {
        NSLog(@"联网成功");
    }
    else
    {
        NSLog(@"onGetNetworkState %d",iError);
    }
}

-(void)changeMode
{
 
    [self setMapRegionWithCoordinate:_currentSelectCoordinate];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    [self addPointAnnotation:_currentSelectCoordinate];
}
#pragma mark - BaiduMapAPI callback

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError)
    {
        NSLog(@"授权成功");
    }
    else
    {
        NSLog(@"onGetPermissionState %d",iError);
    }
}

- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate
{
    NSLog(@"onClickedMapBlank-latitude==%f,longitude==%f",coordinate.latitude,coordinate.longitude);
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:NO];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    
    [_locService stopUserLocationService];
    _locService.delegate = nil;
}

#pragma mark -

#pragma mark - Override BasicViewController

- (void)leftButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -

/**
 *  根据提供的经纬度为中心原点 以动画的形式移动到
 */
- (void)setMapRegionWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    BMKCoordinateRegion region;
    region = BMKCoordinateRegionMake(coordinate, BMKCoordinateSpanMake(0.05, 0.05));//越小地图显示越详细
    [_mapView setRegion:region animated:YES];//执行设定显示范围
    _currentSelectCoordinate = coordinate;
    [_mapView setCenterCoordinate:coordinate animated:YES];//根据提供的经纬度为中心原点 以动画的形式移动到该区域
}
/**
 *  添加标注
 */
- (void)addPointAnnotation:(CLLocationCoordinate2D )dictionary
{
    BMKPointAnnotation *pointAnnotation = [[BMKPointAnnotation alloc]init];
     pointAnnotation.coordinate = dictionary;
    pointAnnotation.title =@"";
 
    [_mapView addAnnotation:pointAnnotation];
    
    //设置为中心点
    [_mapView setCenterCoordinate:dictionary];
}


#pragma mark - BMKMapViewDelegate

/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)mapViewWillStartLocatingUser:(BMKMapView *)mapView
{
    NSLog(@"start locate");
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    
    NSLog(@"urlxxx===  %@",url);
    
    if([[url scheme] isEqualToString:@"baidumap"])
    {
        [application setApplicationIconBadgeNumber:10];
        return YES;
    }
    return NO;
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)mapViewDidStopLocatingUser:(BMKMapView *)mapView
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    return YES;
}
// 根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    NSString *AnnotationViewID = @"renameMark";
    NSLog(@"4");
    if (newAnnotation == nil) {
        newAnnotation = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        // 设置颜色
        ((BMKPinAnnotationView*)newAnnotation).pinColor = BMKPinAnnotationColorPurple;
        // 从天上掉下效果
        ((BMKPinAnnotationView*)newAnnotation).animatesDrop = YES;
        // 设置可拖拽
        ((BMKPinAnnotationView*)newAnnotation).draggable = NO;
        
        [(BMKPinAnnotationView*)newAnnotation setSelected:YES animated:YES];//让标注处于弹出气泡框的状态
    }
    return newAnnotation;
}

// 当点击annotation view弹出的泡泡时，调用此接口
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view;
{
    NSLog(@"paopaoclick");
}

- (void)rightButtonAction
{
    

    NSString *surl=[NSString stringWithFormat:@"http://api.map.baidu.com/direction?origin=latlng:%f,%f|name:我的位置&destination=latlng:%f,%f|name=%@&mode=walking&region=上海&output=html",[XHDefaultUser sharedUser].coordinate.latitude, [XHDefaultUser sharedUser].coordinate.longitude,_currentSelectCoordinate.latitude,_currentSelectCoordinate.longitude,@""];
    NSString *  urlString = [surl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    XHWebViewController *webview=[[XHWebViewController alloc] init];
 
    webview.webUrl=urlString;
    webview.webtitle=@"导航";
   
    //	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    [self.navigationController pushViewController:webview animated:YES];
    // baidumap://map/direction?origin=34.264642646862,108.95108518068&destination=40.007623,116.360582&mode=driving&src=yourCompanyName|yourAppName
    //  [self startNavi];
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
