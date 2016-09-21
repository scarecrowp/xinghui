//
//  XHHomeTableView.m
//  XingHui
//
//  Created by wangpei on 15/5/25.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHHomeTableView.h"
#import "XHHomeMeetingCell.h"
#import "XHHomePartyCell.h"
#import "XHMeetDetailViewController.h"
#import "XHGather.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import "XHEmptyView.h"

@implementation XHHomeTableView
{
    NSMutableArray *storeArr;
}
typedef NS_ENUM(NSInteger, GatherType) {
    kBigGather  = 2,
    kSmallGather =1
};
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)rect
{
    self =[super initWithFrame:rect];
    if (self) {
        self.separatorStyle = UITableViewCellSelectionStyleNone;
        storeArr =[NSMutableArray new];
        self.delegate = self;
        
        
        self.dataSource = self;
 
    }
    return self;
}

-(void)storeArr:(NSMutableArray *)dataArr
{
    if (dataArr) {
        [storeArr addObjectsFromArray:dataArr];
    }
    [self reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return storeArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     XHGather *gather =[[XHGather alloc] initWithDic:[storeArr objectAtIndex:indexPath.row]];
    if (gather.type==2) {
 
        XHHomeMeetingCell *shopCell = (XHHomeMeetingCell *)[tableView dequeueReusableCellWithIdentifier:@"XHHomeMeetingCell"];
 
       if (!shopCell)
        {
            shopCell=[[XHHomeMeetingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"XHHomeMeetingCell"]];
            
         }
        else
        {
                //删除cell的所有子视图
            [shopCell removeJoinView];
        }
        [shopCell setData:gather];
        return shopCell;
    }
   else
    {
 
           XHHomePartyCell *shopCell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"XHHomePartyCell"]];
          if (!shopCell)
          {
            shopCell=[[XHHomePartyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"XHHomePartyCell"] data:gather];
          }
            return shopCell;
    }
  
}

#pragma mark -s

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return [tableView fd_heightForCellWithIdentifier:@"XHHomeMeetingCell" cacheByIndexPath:indexPath configuration:^(id cell) {
//        // 配置 cell 的数据源，和 "cellForRow" 干的事一致，比如：
//      //  cell.entity = self.feedEntities[indexPath.row];
//    }];
     XHGather *gather =[[XHGather alloc] initWithDic:[storeArr objectAtIndex:indexPath.row]];
     if (gather.type==2) {
                  return 153;
     }
    else
    {
        float hei= SCREEN_WIDTH/2+10+51+8+10;
        return hei;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_homedelegate seletegather:[storeArr objectAtIndex:indexPath.row]];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (storeArr.count==0) {
        UIView *empty=[XHEmptyView new];
        return empty;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    if (storeArr.count==0) {
        UIView *empty=[XHEmptyView new];
        return empty.height;
    }
    return 0;
}
@end
