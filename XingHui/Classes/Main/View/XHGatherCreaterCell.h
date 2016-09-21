//
//  XHGatherCreaterCell.h
//  XingHui
//
//  Created by gaoyuerui on 15/12/3.
//  Copyright © 2015年 wangpei. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XHGatherCreaterCellDelegate;
@interface XHGatherCreaterCell : UITableViewCell
@property (nonatomic, strong) UIImageView *img_head;
@property (nonatomic, strong) UILabel *lb_name;
@property (nonatomic, strong) UILabel *lb_relation;
@property (nonatomic, strong) UILabel *lb_job;
@property (nonatomic, strong) UILabel *lb_distance;
@property (nonatomic, weak) id<XHGatherCreaterCellDelegate> delegate;
-(void)setCreaterData:(XHUser *)user;
@end
@protocol XHGatherCreaterCellDelegate <NSObject>

-(void)ToCreaterDetail;

@end