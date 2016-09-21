//
//  XHUserJoinCell.h
//  XingHui
//
//  Created by wangpei on 15/6/10.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XHOtherUser;
@protocol UserCellDelegagte;
@interface XHUserJoinCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img_head;
@property (weak, nonatomic) IBOutlet UILabel *lb_name;
@property (weak, nonatomic) IBOutlet UILabel *lb_ralation;
@property (weak, nonatomic) IBOutlet UILabel *lb_distance;
@property (weak, nonatomic) IBOutlet UILabel *job;
@property (weak, nonatomic) IBOutlet UIButton *bt_action;
@property(nonatomic,weak)id<UserCellDelegagte>delegate;
@property(nonatomic,strong)XHUser *user;
- (IBAction)addFriend:(id)sender;
-(id)initWithGather:(XHOtherUser *)user;
@end
@protocol UserCellDelegagte <NSObject>
-(void)ToUserDetail:(XHUser *)user;
-(void)ChatWithUser:(XHUser *)user;
-(void)addFriend:(NSString *)username realName:(NSString *)realName;
@end