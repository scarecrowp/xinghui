//
//  XHJobCell.h
//  XingHui
//
//  Created by gaoyuerui on 15/10/19.
//  Copyright © 2015年 wangpei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHMyJobCell : UITableViewCell
@property(nonatomic,strong)UILabel *lb_title;
@property(nonatomic,strong)UILabel *lb_time;
@property(nonatomic,strong)UILabel *lb_postion;
-(void)SETJobData:(NSDictionary *)jobDic;
@end