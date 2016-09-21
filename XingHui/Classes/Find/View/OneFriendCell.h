//
//  OneFriendCell.h
//  XingHui
//
//  Created by wangpei on 15/8/21.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XHUser;
@protocol OneFriendDelegate;
@interface OneFriendCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lb_name;
@property (weak, nonatomic) IBOutlet UILabel *lb_company;
@property (weak, nonatomic) IBOutlet UILabel *lb_job;
@property (weak, nonatomic) IBOutlet UIImageView *img_head;
@property (nonatomic, strong) XHUser *friend;
@property (nonatomic, strong) id<OneFriendDelegate>delegate;
-(void)setData:(XHUser *)friend;
-(void)setSecondData:(XHUser *)friend;
-(void)setNearData:(XHUser *)friend;
-(void)setInvitionData:(XHUser *)user;//邀请好友
@end
@protocol OneFriendDelegate <NSObject>
@optional
-(void)invited:(NSString *)username tell:(NSString *)tell;
@end