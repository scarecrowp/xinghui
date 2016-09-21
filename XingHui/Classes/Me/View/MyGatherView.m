//
//  MyGatherView.m
//  XingHui
//
//  Created by wangpei on 15/8/14.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "MyGatherView.h"
#import "XHMyGatherTableViewCell.h"
#import "XHGather.h"
#import "XHEmptyView.h"
#import "XHMyGather.h"
@interface MyGatherView()
{
    UIScrollView *scroll_main;
    UITableView *tableview;
    NSInteger type;
    NSInteger currType;
}
@end

@implementation MyGatherView
-(id)initWithFrame:(CGRect)frame dataType:(NSInteger)dataType
{
    self=[super initWithFrame:frame];
    type=dataType;
    currType=1;
    UIButton *bt_left =[UIButton buttonWithType:UIButtonTypeCustom];
    
  
    [bt_left setTitleColor:[UIColor ColorWithHexString:@"3d3d3d"] forState:UIControlStateNormal];
    [bt_left setFrame:CGRectMake(0, 0, SCREEN_WIDTH/2-1, 46)];
   
    [bt_left setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:bt_left];
    
    UIButton *bt_right =[UIButton buttonWithType:UIButtonTypeCustom];
    [bt_right setBackgroundColor:[UIColor whiteColor]];
   
  
    [bt_right setTitleColor:[UIColor ColorWithHexString:@"3d3d3d"] forState:UIControlStateNormal];
    [bt_right setFrame:CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2-1, 46)];
    [self addSubview:bt_right];
 
    [bt_left setTitle:@"大型活动" forState:UIControlStateNormal];
     bt_left.tag=1;
    [bt_right setTitle:@"聚会活动" forState:UIControlStateNormal];
     bt_right.tag=2;
    
    
    UIView *view_bottom_line =[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bt_left.frame)-1, SCREEN_WIDTH, 1)];
    view_bottom_line.backgroundColor=[UIColor ColorWithHexString:@"d7d7d7"];
    [self addSubview:view_bottom_line];
    
    lb_bottom=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bt_right.frame)-2, SCREEN_WIDTH/2, 2)];
    [lb_bottom setBackgroundColor:[AciMath getColor:@"3ec07b"]];
    [self addSubview:lb_bottom];
    
    
    [bt_left addTarget:self action:@selector(tabclick:) forControlEvents:UIControlEventTouchUpInside];
    
    [bt_right addTarget:self action:@selector(tabclick:) forControlEvents:UIControlEventTouchUpInside];

    tableview =[[UITableView alloc] initWithFrame:CGRectMake(0, 46, SCREEN_WIDTH, SCREEN_HEIGHT-46-64)];
    tableview.delegate=self;
    tableview.dataSource=self;

    UIView *view =[[UIView alloc] init];
    tableview.tableFooterView =view;
    [self addSubview:tableview];
    return self;
}
-(id)initWithFrame:(CGRect)frame myFocus:(NSInteger)gatherType
{
    self=[super initWithFrame:frame];
    type=gatherType;
    UIButton *bt_left =[UIButton buttonWithType:UIButtonTypeCustom];
    [bt_left setTitle:@"大型活动" forState:UIControlStateNormal];
    [bt_left setTitleColor:[UIColor ColorWithHexString:@"3d3d3d"] forState:UIControlStateNormal];
    [bt_left setFrame:CGRectMake(0, 0, SCREEN_WIDTH/2-1, 46)];
    bt_left.tag=3;
    [bt_left setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:bt_left];
    
    UIButton *bt_right =[UIButton buttonWithType:UIButtonTypeCustom];
    [bt_right setBackgroundColor:[UIColor whiteColor]];
    bt_right.tag=4;
    [bt_right setTitle:@"聚会活动" forState:UIControlStateNormal];
    [bt_right setTitleColor:[UIColor ColorWithHexString:@"3d3d3d"] forState:UIControlStateNormal];
    [bt_right setFrame:CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2-1, 46)];
    [self addSubview:bt_right];
    
    UIView *view_bottom_line =[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bt_left.frame)-1, SCREEN_WIDTH, 1)];
    view_bottom_line.backgroundColor=[UIColor ColorWithHexString:@"d7d7d7"];
    [self addSubview:view_bottom_line];
    
    lb_bottom=[[UILabel alloc] initWithFrame:CGRectMake(gatherType%2*SCREEN_WIDTH/2, CGRectGetMaxY(bt_right.frame)-2, SCREEN_WIDTH/2, 2)];
    [lb_bottom setBackgroundColor:[AciMath getColor:@"3ec07b"]];
    [self addSubview:lb_bottom];
    
    
    [bt_left addTarget:self action:@selector(tabclick:) forControlEvents:UIControlEventTouchUpInside];
    
    [bt_right addTarget:self action:@selector(tabclick:) forControlEvents:UIControlEventTouchUpInside];
    
    tableview =[[UITableView alloc] initWithFrame:CGRectMake(0, 46, SCREEN_WIDTH, SCREEN_HEIGHT-46)];
    tableview.delegate=self;
    tableview.dataSource=self;

    UIView *view =[[UIView alloc] init];
    tableview.tableFooterView =view;
    [self addSubview:tableview];
    return self;

}
-(void)setMyData:(NSMutableArray *)arr
{

    if (currType==1) {
        _mydataArr=[NSMutableArray new];
        _mydataArr=arr;
        
    }
  else
  {
      _myJoinArr=[NSMutableArray new];
      _myJoinArr=arr;
  }
    [tableview reloadData];
    
}
-(void)tabclick:(id)sender
{
    NSInteger tag=((UIButton *)sender).tag;
    currType=tag;
    [self selectTableType:tag];
   
}
-(void)selectTableType:(NSInteger)ttype
{
    [UIView beginAnimations:nil context:nil];//动画开始
    [UIView setAnimationDuration:0.1];
    CGRect rect=lb_bottom.frame;
    rect.origin.x=(ttype-1)%2*SCREEN_WIDTH/2;
    lb_bottom.frame = rect;
    [UIView commitAnimations];
    [_delegate getMyGather:ttype];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (currType==1) {
         return _mydataArr.count;
    }
    else
    {
        return _myJoinArr.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHMyGatherTableViewCell *cell=  [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"XHMyGatherTableViewCell"]];
    XHGather *gather;
 
    if (currType==2) {
        gather=[_myJoinArr objectAtIndex:indexPath.row];
    }
    else
    {
        gather =[_mydataArr objectAtIndex:indexPath.row];
    }
    if (!cell) {
        cell =[[XHMyGatherTableViewCell alloc] initWithGather:gather];
        
    }
    return cell;
}

#pragma mark -s

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (currType==2) {
          [_delegate didSelectGather:[_myJoinArr objectAtIndex:indexPath.row]];
    }
    else
    {
         [_delegate didSelectGather:[_mydataArr objectAtIndex:indexPath.row]];
        
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    if (currType==2) {
        if (self.myJoinArr.count==0) {
            UIView *empty=[XHEmptyView new];
            return empty;
        }

    }
    else
    {
        if (self.mydataArr.count==0) {
            UIView *empty=[XHEmptyView new];
            return empty;
        }
        
    }
    
    
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (currType==2) {
    if (self.myJoinArr.count==0) {
        UIView *empty=[XHEmptyView new];
        return empty.height;
    }
    
}
else
{
    if (self.mydataArr.count==0) {
        UIView *empty=[XHEmptyView new];
        return empty.height;
    }
    
}

    return 0;
}
@end
