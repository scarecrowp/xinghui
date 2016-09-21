//
//  CommentCell.h
//  XingHui
//
//  Created by wangpei on 15/8/10.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CommentDelegate;
@interface CommentCell : UITableViewCell
@property(nonatomic,strong)UIImageView *headpic;
@property(nonatomic,strong)UILabel *lb_name;
@property(nonatomic,strong)UILabel *lb_time;
@property(nonatomic,strong)UILabel *lb_comment;
@property(nonatomic,strong)id<CommentDelegate>delegate;
@property(nonatomic,strong)UIButton *bt_comment;
@property(nonatomic,strong)XHUser *user;
-(void)setdada:(NSDictionary *)dic;
@end
@protocol CommentDelegate <NSObject>

-(void)ToUserDetail:(XHUser *)user;//点击头像查看用户页面
-(void)repayComment:(XHUser *)user;//回复评论

@end