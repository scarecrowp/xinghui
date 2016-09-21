//
//  GatherHead.m
//  XingHui
//
//  Created by gaoyuerui on 15/10/8.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "GatherHead.h"
#import "XHGather.h"
#import "UILable+Category.h"
@implementation GatherHead
-(instancetype)initWithGather:(XHGather *)gather
{
    self=[super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/2+60)];
    if (self) {
        _gather=gather;
        UIView *view_meng=[[UIView alloc] init];
        view_meng.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
       
        
        UILabel *lb_title=[[UILabel alloc] init];
        lb_title.text=gather.title;
        
        [lb_title setFont:Bold(20)];
        [lb_title setTextColor:Color(@"FFFFFF")];
        [view_meng addSubview:lb_title];
        
        UILabel *lb_distance=[[UILabel alloc] init];
        lb_distance.text=[NSString stringWithFormat:@"距离4.5km"];
        lb_distance.textColor=Color(@"FFFFFF");
        [lb_distance setFont:Font(12)];
        [view_meng addSubview:lb_distance];
        
        UIImageView *gatherPic=[UIImageView new];
        [gatherPic sd_setImageWithURL:[NSURL URLWithString:gather.img]];
        [self addSubview:gatherPic];
         [self addSubview:view_meng];
        __weak __typeof(&*self)ws = self;
      
        
        UIImageView *icon1=[UIImageView new];
        [view_meng addSubview:icon1];
        [icon1 setImage:[UIImage imageNamed:@"icon_location"]];
       
        
        UILabel *lb_address =[UILabel new];
        [view_meng addSubview:lb_address];
        lb_address.textColor=Color(@"C3C3C3");
        [lb_address setFont:Font(13)];
        lb_address.text=gather.location;
        [lb_address addTarget:self action:@selector(toMap)];
        
        
        UIImageView *icon2=[UIImageView new];
        [view_meng addSubview:icon2];
        icon2.contentMode=UIViewContentModeCenter;
        [icon2 setImage:[UIImage imageNamed:@"time"]];
        
        UILabel *lb_time=[UILabel new];
        [view_meng addSubview:lb_time];
        lb_time.text=gather.time;
        [lb_time setFont:Font(13)];
        lb_time.textColor=Color(@"C3C3C3");
        
        
        UIButton *bt_focus=[UIButton buttonWithType:UIButtonTypeCustom];
        [bt_focus setImage:[UIImage imageNamed:@"focusmeet"] forState:UIControlStateNormal];
        [bt_focus addTarget:self action:@selector(Addfocus) forControlEvents:UIControlEventTouchUpInside];
        [view_meng addSubview:bt_focus];

        UIButton *bt_join=[UIButton buttonWithType:UIButtonTypeCustom];
        [bt_join setImage:[UIImage imageNamed:@"signup"] forState:UIControlStateNormal];
        [bt_join addTarget:self action:@selector(JoinIn) forControlEvents:UIControlEventTouchUpInside];
        [view_meng addSubview:bt_join];
        
        UILabel *lb_focus=[UILabel new];
        lb_focus.textColor=Color(@"ffffff");
        [lb_focus setFont:Font(14)];
        lb_focus.textAlignment =NSTextAlignmentCenter;
        lb_focus.text=[NSString stringWithFormat:@"已有%lu人关注",(unsigned long)gather.focuserNum];
        
        UILabel *lb_join=[UILabel new];
        lb_join.textAlignment=NSTextAlignmentCenter;
        [lb_join setFont:Font(14)];
        lb_join.text=[NSString stringWithFormat:@"已有%lu人报名",gather.joiner.count];
        lb_join.textColor=Color(@"ffffff");
        [view_meng addSubview:lb_focus];
        [view_meng addSubview:lb_join];
        
        UIImageView *img_head=[UIImageView new];
        [img_head sd_setImageWithURL:[NSURL URLWithString:gather.creater.userpic]];
        img_head.layer.cornerRadius=30;
        img_head.layer.masksToBounds=YES;
        [self addSubview:img_head];
        
        UILabel *lb_zbf=[UILabel new];
        lb_zbf.text=@"主办方";
        lb_zbf.font=Font(14);
        [self addSubview:lb_zbf];
        
        UILabel *lb_createname=[UILabel new];
        lb_createname.text=gather.creater.userRealName;
        [self addSubview:lb_createname];
        [lb_createname setFont:Font(14)];
        
        UIImageView *img_right=[UIImageView new];
        [img_right setImage:[UIImage imageNamed:@"cellright"]];
        
        [self addSubview:img_right];
        
        [gatherPic mas_remakeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(ws);
            make.top.equalTo(ws);
            make.right.equalTo(ws);
            make.height.mas_equalTo(SCREEN_WIDTH/2-12);
            
        }];
        
        [view_meng mas_remakeConstraints:^(MASConstraintMaker *maker){
            maker.edges.equalTo(gatherPic);
        }];
        float w=[lb_title widthWithTitle];
        [lb_title mas_makeConstraints:^(MASConstraintMaker *maker){
            maker.top.equalTo(view_meng.mas_top).with.offset(10);
            maker.left.equalTo(view_meng.mas_left).with.offset(19);
        //    maker.right.equalTo(lb_distance.mas_left);
            maker.height.mas_equalTo(21);
            maker.width.mas_equalTo(w);
        }];
        [lb_title sizeToFit];
        [lb_distance mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerY.equalTo(lb_title.mas_centerY);
          
            make.left.equalTo(lb_title.mas_right).with.offset(5);
            make.right.equalTo(view_meng.mas_right);
        }];
        [icon1 mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(lb_title);
            make.top.equalTo(lb_title.mas_bottom).with.offset(8);
            make.size.mas_equalTo(CGSizeMake(9, 11));
        }];
        [icon2 mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(lb_title);
            make.top.equalTo(icon1.mas_bottom).with.offset(8);
            make.size.mas_equalTo(CGSizeMake(9, 11));
        }];
        
        [lb_address mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(icon1.mas_right).with.offset(5);
           // make.top.equalTo(icon1);
            make.centerY.equalTo(icon1.mas_centerY);
            make.right.equalTo(view_meng.mas_right);
            make.height.mas_equalTo(21);
           // make.size.mas_equalTo(CGSizeMake(9, 11));
        }];
        [lb_time mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(lb_address);
            
            make.centerY.equalTo(icon2.mas_centerY);
            make.right.equalTo(view_meng.mas_right);
            make.height.mas_equalTo(21);
        }];
        [bt_focus mas_makeConstraints:^(MASConstraintMaker *make){
          //  make.left.equalTo(lb_address).with.offset(10);
            make.centerX.mas_equalTo(view_meng.mas_centerX).with.offset(-SCREEN_WIDTH/4);
            make.top.equalTo(lb_time.mas_bottom).with.offset(8);
            
            make.size.mas_equalTo(CGSizeMake(126, 40));
        }];

        [bt_join mas_makeConstraints:^(MASConstraintMaker *make){
          //  make.left.equalTo(bt_focus.mas_right).with.offset(20);
         
            make.top.equalTo(bt_focus);
            make.centerX.mas_equalTo(SCREEN_WIDTH/4);
            //  make.right.equalTo(view_meng.mas_right);
            // make.height.mas_equalTo(21);
            make.size.equalTo(bt_focus);
        }];
        [lb_focus mas_makeConstraints:^(MASConstraintMaker *make){
 
            
            make.top.equalTo(bt_focus.mas_bottom).with.offset(5);
            make.centerX.mas_equalTo(bt_focus.mas_centerX);
            
            make.left.equalTo(bt_focus);
            make.right.equalTo(bt_focus);
        }];
        [lb_join mas_makeConstraints:^(MASConstraintMaker *make){
            
            make.left.equalTo(bt_join);
            make.right.equalTo(bt_join);
            make.top.equalTo(lb_focus);
            make.centerX.mas_equalTo(bt_join.mas_centerX);
        }];
        [img_head mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(ws).with.offset(8);
            make.size.mas_equalTo(CGSizeMake(60, 60));
            make.top.equalTo(view_meng.mas_bottom).offset(8);
           // make.bottom.equalTo(ws.mas_bottom).with.offset(5);
        }];
        [lb_zbf mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(img_head.mas_right).with.offset(13);
            make.height.mas_equalTo(21);
            make.top.equalTo(view_meng.mas_bottom).offset(14);
        }];
        [lb_createname mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(lb_zbf);
          
            make.top.equalTo(lb_zbf.mas_bottom).offset(8);
        }];
        [img_right mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.equalTo(ws).with.offset(-10);
            make.size.mas_equalTo(CGSizeMake(9, 16));
            make.centerY.equalTo(img_head);
         
        }];

    }
    return self;
}
-(void)toMap
{
    [_delegate toMap];
}
-(void)setConstraints
{
    
}
-(void)Addfocus
{
    [_delegate Addfocus:_gather.gid];
}
-(void)JoinIn
{
    [_delegate JoinIn:_gather.gid];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
