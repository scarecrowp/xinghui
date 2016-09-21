//
//  XHFoundViewControl.m
//  XingHui
//
//  Created by wangpei on 15/5/18.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//
#import "XHFoundViewControl.h"
#import "XHFindItemTableViewCell.h"
@interface XHFoundViewControl ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableview;
    NSMutableArray *dataArr;
}
@end

@implementation XHFoundViewControl
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"发现"];
   // [self.rightButton setImage:[UIImage imageNamed:@"bt_search"] forState:UIControlStateNormal];
    [self.leftButton setHidden:YES];
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    tableview.delegate=self;
    tableview.dataSource=self;
    tableview.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    UIView *view=[UIView new];
    tableview.tableFooterView=view;
    [self.view addSubview:tableview];
    dataArr =[JLCommonUtil getFindItemArr];
    // Do any additional setup after loading the view from its nib.
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHFindItemTableViewCell *item =[[XHFindItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XHFindItemTableViewCell" data:[dataArr objectAtIndex:(indexPath.section*2+indexPath.row)] xibfile:@"XHFindItemTableViewCell"];
    item.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    return item;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==2) {
        return 1;
    }
    return 2;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  3;
}
-(double)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 11;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *control=  [[NSClassFromString([[dataArr objectAtIndex:indexPath.section*2+indexPath.row] objectForKey:@"page"]) alloc] init];
    control.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:control animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end