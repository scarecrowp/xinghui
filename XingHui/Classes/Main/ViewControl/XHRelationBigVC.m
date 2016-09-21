//
//  XHRelationBigVC.m
//  XingHui
//
//  Created by gaoyuerui on 15/10/30.
//  Copyright © 2015年 wangpei. All rights reserved.
//

#import "XHRelationBigVC.h"
#import "GatherManage.h"
#import "XHGather.h"
#import "XHEmptyView.h"
@interface XHRelationBigVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableview;
    NSMutableArray *dataArr;
    XHGather *gather;
}
@end

@implementation XHRelationBigVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"关联大型会议"];
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];

    tableview.tableFooterView =[UIView new];
    [self.view addSubview:tableview];
    
    dataArr = [NSMutableArray new];
    GatherManage *gathermanage = [[GatherManage alloc] init];
    [gathermanage getAllMyGather:^(NSMutableArray *arr){
        dataArr =arr;
        tableview.delegate = self;
        tableview.dataSource = self;
        [tableview reloadData];
    }];
 //   [gathermanage getMyCreateGather:<#(NSString *)#>]
    // Do any additional setup after loading the view.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHGather *gatherc = [dataArr objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = gatherc.title;
    
    return cell;
        
}

#pragma mark -s

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController popViewControllerAnimated:YES];
    gather =[dataArr objectAtIndex:indexPath.row];
    [_passdelegate passbackObject:gather sender:@"gather"];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    
    if (dataArr.count==0) {
        UIView *empty=[XHEmptyView new];
        return empty;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    if (dataArr.count==0) {
        UIView *empty=[XHEmptyView new];
        return empty.height;
    }
    return 0;
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
