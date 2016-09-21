//
//  XHSecretSetView.m
//  XingHui
//
//  Created by gaoyuerui on 15/9/23.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHSecretSetView.h"
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
@implementation XHSecretSetView
-(instancetype)initWithFrame:(CGRect)frame select:(int)select
{
    self=[super initWithFrame:frame];
    if (self) {
        self.selectedIndexPath=select;
       // self.tableFooterView=self.foot;
       // self.tableHeaderView=self.head;
        self.delegate=self;
        self.dataSource=self;
        self.arr=[[NSArray alloc] initWithObjects:@"仅好友",@"好友的好友",@"全部", nil];
     //   NSIndexPath *path=[[NSIndexPath alloc] initWithIndex:0];
      //  [self tableView:self didSelectRowAtIndexPath:path];
    }
    return self;
}
#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}
#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"UITableViewCellIdentifierKey1";
    UITableViewCell *cell;
    cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        UILabel *lb_right=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 11, 11)];
        lb_right.layer.masksToBounds=YES;
        lb_right.layer.cornerRadius=5.5;
        cell.accessoryView=lb_right;
        cell.accessoryView.tag=indexPath.row;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        [cell.textLabel setTextColor:[AciMath getColor:@"a1a1a1"]];
    }
    if (_selectedIndexPath==indexPath.row) {
        [cell.accessoryView setBackgroundColor:[AciMath getColor:@"39cb00"]];
    }
    else
    {
         [cell.accessoryView setBackgroundColor:[AciMath getColor:@"e6e6e6"]];
    }
    cell.textLabel.text=[self.arr objectAtIndex:indexPath.row];
    return cell;
}
#pragma mark 设置每行高度（每行高度可以不一样）
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(UILabel *)head
{
    if (!_head) {
        _head =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 52)];
        _head.text=@"   谁可以看我的资料";
        _head.font=Font(18.f);
        
    }
    return _head;
}
-(UILabel *)foot
{
    if (!_foot) {
        _foot =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 100)];
        _foot.numberOfLines=0;
        NSString * htmlString = @"     资料包括:\n     联系方式、标签、工作经历等\n     其中手机号码等联系方式仅 一度好友、二度好友参看";
        [_foot setTextColor:Color(@"3d3d3d")];
        [_foot setFont:Font(12)];
        _foot.text=htmlString;
    }
    return _foot;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return self.foot;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 100;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.head;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return  52;
}
#pragma mark 点击行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   // _selectedIndexPath=indexPath.row;
    [_secdelegate Didselect:indexPath.row];
   // UITableViewCell *cell=[self tableView:tableView cellForRowAtIndexPath:indexPath];
    //cell.accessoryView.backgroundColor=[AciMath getColor:@"39cb00"];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
