//
//  XHHomePartyCell.h
//  XingHui
//
//  Created by wangpei on 15/5/25.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XHGather;
@interface XHHomePartyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *pic_big;
@property (weak, nonatomic) IBOutlet UIImageView *pic_meeting;
@property (weak, nonatomic) IBOutlet UILabel *lb_title;
@property (weak, nonatomic) IBOutlet UILabel *lb_time;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier data:(XHGather *)dic;
@end
