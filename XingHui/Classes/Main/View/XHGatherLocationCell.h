//
//  XHGatherLocationCell.h
//  XingHui
//
//  Created by gaoyuerui on 15/11/24.
//  Copyright © 2015年 wangpei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XHGather;
@protocol LocationCellDelegate;
@interface XHGatherLocationCell : UITableViewCell
@property (nonatomic, strong) UILabel *lb_name;
@property (nonatomic, strong) UILabel *lb_location;
@property (nonatomic, strong) UILabel *lb_time;
@property (nonatomic, weak) id<LocationCellDelegate> delegate;
-(void)setData:(XHGather *)gather;
@end
@protocol LocationCellDelegate <NSObject>

-(void)ToLocationMap;

@end