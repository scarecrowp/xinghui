//
//  XHSearchPlaceViewController.m
//  XingHui
//
//  Created by wangpei on 15/6/17.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHSearchPlaceViewController.h"
#import "XHPlaceCell.h"
#import "AFNetworking.h"
#import "JSONKit.h"
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
@interface XHSearchPlaceViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,BMKPoiSearchDelegate>
{
    UISearchBar *searchBar;
    UITableView *tableview;
    NSMutableArray *dataArr;
    BMKPoiSearch *_searcher;
}
@end

@implementation XHSearchPlaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"选择聚会地点"];
    searchBar= [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    searchBar.tintColor=[UIColor blueColor];
    searchBar.delegate=self;
    searchBar.showsCancelButton=NO;
    searchBar.placeholder=@"搜索";
    tableview =[[UITableView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, SCREEN_HEIGHT-50)];
    tableview.dataSource=self;
    tableview.delegate=self;
    dataArr =[NSMutableArray new];
    [self.view addSubview:tableview];
    [self.view addSubview:searchBar];
    [self getDefaultDataArr];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
  
//    _searcher.delegate = self;
//    //发起检索
//    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
//    option.pageIndex = 1;
//    option.pageCapacity = 20;
// 
//    option.location=CLLocationCoordinate2DMake([XHDefaultUser sharedUser].coordinate.location.coordinate.latitude, [XHDefaultUser sharedUser].coordinate.location.coordinate.longitude);
//    option.keyword = @"餐厅";
//    BOOL flag = [_searcher poiSearchNearBy:option];
}
//实现PoiSearchDeleage处理回调结果
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResultList errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        dataArr =[[NSMutableArray alloc] initWithArray:poiResultList.poiInfoList];
        [tableview reloadData];
    }
    else if (error == BMK_SEARCH_AMBIGUOUS_KEYWORD){
        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
        // result.cityList;
        NSLog(@"起始点有歧义");
    } else {
        NSLog(@"抱歉，未找到结果");
    }
}
-(void)getDefaultDataArr
{
    [self getDataArr:@"餐馆"];
}
-(void)getDataArr:(NSString *)key
{
    AFHTTPRequestOperationManager *bClient = [AFHTTPRequestOperationManager manager];
    bClient.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *dic =@{@"key":key,
                         @"location":[NSString stringWithFormat:@"%f,%f",[XHDefaultUser sharedUser].coordinate.latitude,[XHDefaultUser sharedUser].coordinate.longitude]
                         };
    [bClient GET:[NSString APIURLString:@"bdpoi.ashx"] parameters:dic success:^(AFHTTPRequestOperation *operation,id responseObject)
     {
         
         NSDictionary *dic =[responseObject objectFromJSONData];
         if ([dic isKindOfClass:[NSDictionary class]])
         {
             
             if (dic[@"results"]) {
                 if ([dic[@"status"] intValue]==0) {
                     dataArr =dic[@"results"];
                     [tableview reloadData];
                 }
                 else
                 {
                     
                 }
                 
             }
             else
             {
                 
             }
         }
         
     }failure:^(AFHTTPRequestOperation *operation,NSError *error){
         //
         //  [control HideHUDAfter2S:error.description];
     }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)_searchBar
{
    [self getDataArr:_searchBar.text];
    [searchBar resignFirstResponder];
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)_searchBar
{
    [searchBar resignFirstResponder];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return dataArr.count;;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHPlaceCell *cell=  [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"XHPlaceCell"]];
    if (!cell) {
        cell =[[XHPlaceCell alloc] initWithdic:[dataArr objectAtIndex:indexPath.row]];
        
    }
    return cell;}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 62;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_passvalue passbackObject:[dataArr objectAtIndex:indexPath.row] sender:@""];
    [self.navigationController popViewControllerAnimated:YES];
    // [_homedelegate seleteCellIndex:indexPath.row];
}

@end
