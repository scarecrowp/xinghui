//
//  OneFriendCell.m
//  XingHui
//
//  Created by wangpei on 15/8/21.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "OneFriendCell.h"
#import "XHUser.h"
#import "UIImageView+Category.h"
#import "UILable+Category.h"
@implementation OneFriendCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [[[NSBundle mainBundle] loadNibNamed:@"OneFriendCell"owner:nil options:nil] objectAtIndex:0];
    self.restorationIdentifier=reuseIdentifier;
    _img_head.layer.cornerRadius=28;
    _img_head.layer.masksToBounds=YES;
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
-(void)setData:(XHUser *)friend
{
    _friend = friend;
    _lb_name.text=friend.userRealName;
    if (friend.company) {
        if (![[friend.company ToString]  isEqualToString:@""]) {
            _lb_company.text=[friend.company ToString];
        }
        else
        {
            _lb_company.text=@"暂未填写职位信息";
           
        }
    }
    else
    {
        _lb_company.text=@"暂未填写职位信息";
    }
    if (friend.job) {
        if (![[friend.job ToString] isEqualToString:@""]) {
            _lb_job.text=friend.job;
        }
        else
        {
             _lb_job.text=@"还未加入幸会";
        }
    }
    else
    {
         _lb_job.text=@"还未加入幸会";
    }
    WS(ws);
    if (friend.is_ok==0) {
        [_img_head setHidden:YES];
        
        UIButton *bt_invited=[[UIButton alloc] init];
        [self addSubview:bt_invited];
        [bt_invited setBackgroundImage:[AciMath getScImage:@"bt_green_bg@3x" top:6 bottom:6 left:6 right:6] forState:UIControlStateNormal];
        [bt_invited.titleLabel setFont:Font(14)];
        [bt_invited setTitle:@"邀请好友" forState:UIControlStateNormal];
        [bt_invited addTarget:self action:@selector(invited) forControlEvents:UIControlEventTouchUpInside];
        [bt_invited mas_makeConstraints:^(MASConstraintMaker *make){
            make.size.mas_equalTo(CGSizeMake(63, 26));
            make.right.equalTo(ws).with.offset(-10);
            make.centerY.equalTo(ws.mas_centerY);
        }];
    }
    else
    {
        if (friend.userpic) {
            if ([[friend.userpic ToString] isEqualToString:@""]) {
                [_img_head setImageFromString:friend.userRealName fontsize:30 paddintTop:10];
            }
            else
            {
                [_img_head sd_setImageWithURL:[NSURL URLWithString:friend.userpic]];
            }
        }
        else
        {
            [_img_head setImageFromString:friend.userRealName fontsize:30 paddintTop:10];
        }
    }
}
-(void)invited
{
    [_delegate invited:_friend.userRealName tell:_friend.tell];
}
/**
 *  设置二度好友的数据
 *
 *  @param friend XHuser
 */
-(void)setSecondData:(XHUser *)friend
{
    _lb_name.text=friend.userRealName;
 
    if (friend.company) {
        if (![[friend.company ToString]  isEqualToString:@""]) {
            _lb_company.text=[NSString stringWithFormat:@"%@ ｜ %@",[friend.company ToString],friend.job];
        }
    }
     _lb_job.text=@"张三等三个共同好友";
    
    if (friend.userpic) {
        if ([[friend.userpic ToString] isEqualToString:@""]) {
            [_img_head setImageFromString:friend.userRealName fontsize:30 paddintTop:10];
        }
        else
        {
            [_img_head sd_setImageWithURL:[NSURL URLWithString:friend.userpic]];
        }
    }
    else
    {
        [_img_head setImageFromString:friend.userRealName fontsize:30 paddintTop:10];
    }

}
/**
 *  设置附近好友的数据
 *
 *  @param friend XHUser
 */
-(void)setNearData:(XHUser *)friend
{
   _lb_name.text=friend.userRealName;
 //   float w=[_lb_name set]
   UILabel *_lb_relation =[[UILabel alloc] initWithFrame:CGRectMake( [_lb_name widthWithTitle]+_lb_name.frame.origin.x+5, _lb_name.frame.origin.y+5, 31, 15)];
    _lb_relation.text=[NSString stringWithFormat:@"%d度",friend.myfriend];
    [_lb_relation setFont:[UIFont systemFontOfSize:10]];
    [_lb_relation setTextColor:[UIColor whiteColor]];
    [_lb_relation setTextAlignment:NSTextAlignmentCenter];
    [_lb_relation setBackgroundColor:[AciMath getColor:@"51AF0D"]];
    UILabel *_lb_distance=[[UILabel alloc] initWithFrame:CGRectMake(_lb_relation.maxX+5, _lb_name.frame.origin.y+5,100,15)];
    [_lb_distance setTextColor:[AciMath getColor:@"969696"]];
    [_lb_distance setFont:[UIFont systemFontOfSize:11]];
    _lb_distance.text=[NSString stringWithFormat:@"%.2fkm",[friend.distance floatValue]];
  
    _lb_relation.layer.cornerRadius=2;
    _lb_relation.layer.masksToBounds=YES;
    [self addSubview:_lb_distance];
    [self addSubview:_lb_relation];
    if (friend.company) {
        if (![[friend.company ToString]  isEqualToString:@""]) {
             _lb_company.text=[NSString stringWithFormat:@"%@ ｜ %@",[friend.company ToString],friend.job];
        }
    }
    _lb_job.text=@"张三等三个共同好友";
   
    if (friend.userpic) {
        if ([[friend.userpic ToString] isEqualToString:@""]) {
            [_img_head setImageFromString:friend.userRealName fontsize:30 paddintTop:10];
        }
        else
        {
            [_img_head sd_setImageWithURL:[NSURL URLWithString:friend.userpic]];
        }
    }
    else
    {
        [_img_head setImageFromString:friend.userRealName fontsize:30 paddintTop:10];
    }

}
-(void)setInvitionData:(XHUser *)user
{
      _lb_name.text=user.userRealName;
    _lb_company.text=user.tell;
      [_img_head setImageFromString:user.userRealName fontsize:30 paddintTop:10];
    
}
@end
